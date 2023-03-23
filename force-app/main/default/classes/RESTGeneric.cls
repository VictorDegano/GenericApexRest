@RestResource(urlMapping='/*')
global with sharing class RESTGeneric {

    @HttpGet
    global static void doGet(){
        resolveRequest();
    }

    @HttpPost
    global static void doPost() {
        resolveRequest();
    }

    @HttpPut
    global static void doPut() {
        resolveRequest();
    }

    @HttpDelete
    global static void doDelete() {
        resolveRequest();
    }

    @HttpPatch
    global static void doPatch() {
        resolveRequest();
    }

    private static void resolveRequest(){
        try {
            System.debug(LoggingLevel.DEBUG, 'Client IP: '+RestContext.request.remoteAddress );
            Generic_REST_Route__mdt route = [ SELECT Class__c, Method__c FROM Generic_REST_Route__mdt WHERE Path__c = :RestContext.request.requestURI AND Http_Method__c = :RestContext.request.httpMethod LIMIT 1 ];

            Type classType = Type.forName(route.Class__c);

            InterfaceRESTGeneric specificClass = (InterfaceRESTGeneric) classType.newInstance();

            specificClass.execute(route.Method__c);

        } catch (Exception processException) {
            setUnkownResource();
        }
    }

    private static void setUnkownResource(){
        RestResponse response = RestContext.response;
        response.statuscode = 404;
        response.responseBody = Blob.valueOf('Unknown Resource.');
    }
}