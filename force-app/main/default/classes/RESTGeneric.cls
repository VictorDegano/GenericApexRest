@RestResource(urlMapping = '/*')
global with sharing class RESTGeneric{
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

            executeSpecificREST((Generic_REST_Route__mdt) route.get());

        } catch (Exception processException){
            setServerError();
        }
    }

    private static void executeSpecificREST(Generic_REST_Route__mdt route){
        Type classType = Type.forName(route.Class__c);

        InterfaceRESTGeneric specificClass = (InterfaceRESTGeneric)classType.newInstance();

        Map<String, Object> parameters = new Map<String, Object>{ 'METHOD' => route.Method__c, 'PARAMS_IN_PATH' => false };
        Boolean isParamsInPath = route.Path__c.contains('*');

        if (isParamsInPath){
            parameters.put('PARAMS_IN_PATH', isParamsInPath);
            parameters.put('PATH_PARAMETERS', loadPathParameters(route.Path__c));
        }

        specificClass.execute(parameters);
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

    private static void setUnkownResource(){
        RestResponse response = RestContext.response;
        response.statuscode = 404;
        response.responseBody = Blob.valueOf('Unknown Resource.');
    }

    private static void setServerError(){
        RestResponse response = RestContext.response;
        response.statuscode = 500;
        response.responseBody = Blob.valueOf('Internal Server Error.');
    }

}