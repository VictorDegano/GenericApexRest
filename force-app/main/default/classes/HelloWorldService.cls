public with sharing class HelloWorldService implements InterfaceRESTGeneric{
    public static void execute(Object restParameters) {
        Map<String, Object> parameters = (Map<String, Object>) restParameters;
        RestResponse response = RestContext.response;
        response.statuscode = 200;

        if('hello'.equalsIgnoreCase((String) parameters.get('METHOD')) || 'helloWithQuery'.equalsIgnoreCase((String) parameters.get('METHOD'))){
            response.responseBody = Blob.valueOf('Hello World!');
        } else if('hello with name'.equalsIgnoreCase((String) parameters.get('METHOD')) && (Boolean) parameters.get('paramsinpath')){
            String name = RestContext.request.requestURI.substringBetween('/hello/', '/greetings/');
            response.responseBody = Blob.valueOf('Hello '+name+'! Greetings!');
        } else {
            throw new HandledException('Unkown Method');
        }
    }

}