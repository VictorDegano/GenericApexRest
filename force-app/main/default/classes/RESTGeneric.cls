@RestResource(urlMapping = '/*')
global with sharing class RESTGeneric{

    public static final String METHOD = 'METHOD';
    public static final String PARAMS_IN_PATH = 'PARAMS_IN_PATH';
    public static final String PATH_PARAMETERS = 'PATH_PARAMETERS';
    public static final String HAS_BODY = 'HAS_BODY';
    public static final String REQUEST_BODY = 'REQUEST_BODY';

    @TestVisible
    private static List<Generic_REST_Route__mdt> route_Configs = Generic_REST_Route__mdt.getAll().values();
    @HttpGet
    global static void doGet(){
        resolveRequest();
    }

    @HttpPost
    global static void doPost(){
        resolveRequest();
    }

    @HttpPut
    global static void doPut(){
        resolveRequest();
    }

    @HttpDelete
    global static void doDelete(){
        resolveRequest();
    }

    @HttpPatch
    global static void doPatch(){
        resolveRequest();
    }

    private static void resolveRequest(){
        try{
            Optional route = getRoute();

            if (!route.isPresent()){
                setUnkownResource();
                return;
            }

            Generic_REST_Route__mdt restRoute = (Generic_REST_Route__mdt) route.get();

            controlAccess(restRoute);

            executeSpecificREST(restRoute);
        } catch (SecurityException  noAccessException) {
            setUnauthorizedRequest(GenericRestStatusCode.UNAUTHORIZED);
        } catch (JSONException  aJsonProcessException) {
            setBadRequest(GenericRestStatusCode.BAD_JSON_FORMAT_REQUEST);
        } catch (Exception processException){
            setServerError();
        }
    }

    private static void controlAccess(Generic_REST_Route__mdt route) {
        Boolean authorized = (Boolean) REST_Access__c.getInstance()?.get(route.Access_Control_Field__c) ?? false;
        if(! authorized){
            throw new SecurityException();
        }
    }

    private static void executeSpecificREST(Generic_REST_Route__mdt route) {
        Type classType = Type.forName(route.Class__c);

        InterfaceRESTGeneric specificClass = (InterfaceRESTGeneric)classType.newInstance();

        Map<String, Object> parameters = new Map<String, Object>{ METHOD => route.Method__c, PARAMS_IN_PATH => false };
        Boolean isParamsInPath = route.Path__c.contains('*');

        if (isParamsInPath){
            parameters.put(PARAMS_IN_PATH, isParamsInPath);
            parameters.put(PATH_PARAMETERS, loadPathParameters(route.Path__c));
        }

        if(RestContext.request.requestBody != null){
            parameters.put(HAS_BODY, true);
            parameters.put(REQUEST_BODY, getJsonRequest());
        }

        specificClass.execute(parameters);
    }

    private static JSONRequest getJsonRequest(){
        JSONRequest requestBody;
        try {
            requestBody = JSONRequest.deserializeFromBlob(RestContext.request.requestBody);
        } catch ( Exception conversionExeption ) {
            throw new JSONException(conversionExeption.getMessage());
        }

        return requestBody;
    }

    private static List<String> loadPathParameters(String path){
        final String REGEX_BOUNDS = '(?i)({0})';
        final String REGEX_SPLITER = ' ';
        final String REGEX_JOINER = '|';
        final List<String> PATH_PARTS = path.split('[*]');
        final String REGEX_REPLACER = String.format(REGEX_BOUNDS, new List<String>{ String.join(PATH_PARTS, REGEX_JOINER) });

        return RestContext.request.requestURI.replaceAll(REGEX_REPLACER, REGEX_SPLITER).trim().split(REGEX_SPLITER);
    }

    private static Optional getRoute(){
        /** Regex explanation ^(?i)(PATH_1){1}(\S+){1}(PATH_2){1}(\?*\S+[^\/])*$
         * (?i) - Do the matching Case Insensitive
         * (PATH_1){1} - match the first part of uri one time
         * (\\S+){1} - match any thing 0 or 1 time
         * (PATH_1){1} - match the other part of uri one time
         * (\\?*\\S+[^\\/])* - match query param or another path param
         */
        final String REGEX_BOUNDS = '^(?i)({0}){1}(\\?*\\S+[^\\/])*$';
        final String GROUP_SEPARATORS = '){1}(\\S+){1}(';
        final String SPLIT_REGEX = '[*]';

        Optional config = new Optional();
        Pattern uriPattern;
        Matcher requestUriMatcher;
        String regex, routePath;
        for (Generic_REST_Route__mdt routeConfig : route_Configs){
            routePath = routeConfig.Path__c;
            regex = routeConfig.Path__c.containsIgnoreCase('*') ? String.format(REGEX_BOUNDS, new List<String>{ String.join(routePath.split(SPLIT_REGEX), GROUP_SEPARATORS) }) : routePath;
            uriPattern = Pattern.compile(regex);
            requestUriMatcher = uriPattern.matcher(RestContext.request.requestURI);

            if (routeConfig.Http_Method__c.equalsIgnoreCase(RestContext.request.httpMethod) && requestUriMatcher.matches()){
                config = Optional.of(routeConfig);
            }
        }
        return config;
    }

    private static void setUnauthorizedRequest(GenericRestStatusCode.RESTInternalCode restStatusCode){
        setResponse(401, restStatusCode);
    }

    private static void setBadRequest(GenericRestStatusCode.RESTInternalCode restStatusCode){
        setResponse(400, restStatusCode);
    }

    private static void setUnkownResource(){
        setResponse(404, GenericRestStatusCode.UNKNOWN_RESOURCE);
    }

    private static void setServerError(){
        setResponse(500, GenericRestStatusCode.INTERNAL_ERROR);
    }

    private static void setResponse(Integer responseStatusCode, GenericRestStatusCode.RESTInternalCode restStatusCode){
        RestResponse response = RestContext.response;
        response.statuscode = responseStatusCode;

        JSONResponse responseBody = new JSONResponse();
        responseBody.hasError = responseStatusCode >= 400;
        responseBody.internalCode = restStatusCode.CODE;
        responseBody.message = restStatusCode.DESCRIPTION;

        response.responseBody = responseBody.toBlob();
    }

}