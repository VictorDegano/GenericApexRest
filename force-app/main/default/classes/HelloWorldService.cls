public with sharing class HelloWorldService implements InterfaceRESTGeneric{
    public static void execute(Object restParameters) {
        Map<String, Object> parameters = (Map<String, Object>) restParameters;
        RestResponse response = RestContext.response;
        response.statuscode = 200;
        Boolean unknownMethod = true;

        JSONResponse responseBody = new JSONResponse();

        if('hello'.equalsIgnoreCase((String) parameters.get('METHOD')) || 'helloWithQuery'.equalsIgnoreCase((String) parameters.get('METHOD'))){
            responseBody.data = 'Hello World!';
            unknownMethod = false;
        } else if('hello with name'.equalsIgnoreCase((String) parameters.get('METHOD')) && (Boolean) parameters.get('paramsinpath')){
            String name = RestContext.request.requestURI.substringBetween('/hello/', '/greetings/');
            responseBody.data = 'Hello '+name+'! Greetings!';
            unknownMethod = false;
        } 
        
        if(unknownMethod) {
            throw new HandledException('Unkown Method');
        }

        response.responseBody = responseBody.toBlob();
    }

}