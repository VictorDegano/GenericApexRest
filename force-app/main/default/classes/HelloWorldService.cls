public with sharing class HelloWorldService implements InterfaceRESTGeneric{
    public static void execute(Object parameters) {

        if('hello'.equalsIgnoreCase((String) parameters)){
            RestResponse response = RestContext.response;
            response.statuscode = 200;
            response.responseBody = Blob.valueOf('Hello World!');
        } else {
            throw new HandledException('Unkown Method');
        }
    }

}