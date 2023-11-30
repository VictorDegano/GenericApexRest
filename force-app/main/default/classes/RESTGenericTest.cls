@IsTest
private class RESTGenericTest{

    @IsTest
    private static void get_withPathParametersAtEnd(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI = '/withPathparameters/paramAtEnd';
        request.httpMethod = 'GET';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doGet();
        Test.stopTest();

        //Test(Then)
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected status of the Get resource');
        Assert.areEqual('paramAtEnd', jsonResponse.data, 'It\'s not the expected response of the Get resource');
    }

    @IsTest
    private static void get_withQueryParameters(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI = '/test/withquery/';
        request.httpMethod = 'GET';
        request.addParameter( 'q', '131');

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doGet();
        Test.stopTest();

        //Test(Then)
        Assert.areEqual('131', response.responseBody.toString(), 'It\'s not the expected response of the Get resource');
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected status of the Get resource');
    }

    @IsTest
    private static void get_withPathParametersAtMiddle(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI = '/teSt/firstTest/withPathparameters/';
        request.httpMethod = 'GET';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doGet();
        Test.stopTest();

        //Test(Then)
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected status of the Get resource');
        Assert.areEqual('firstTest', response.responseBody.toString(), 'It\'s not the expected response of the Get resource');
    }

    @IsTest
    private static void resourceException(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI = '/exception/';
        request.httpMethod = 'GET';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doGet();
        Test.stopTest();

        //Test(Then)
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual('Internal Server Error.', jsonResponse.message, 'It\'s not the expected status for a exception');
        Assert.areEqual(500, response.statusCode, 'It\'s not the expected response for a exception');
    }

    @IsTest
    private static void unknownResource(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI = '/unknown/';
        request.httpMethod = 'GET';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doGet();
        Test.stopTest();

        //Test(Then)
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual('Unknown Resource.', jsonResponse.message, 'It\'s not the expected status for a missconfigured resource');
        Assert.areEqual(404, response.statusCode, 'It\'s not the expected response for a missconfigured resource');
    }

    @IsTest
    private static void patch_withOutBody(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI = '/patch/';
        request.httpMethod = 'PATCH';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doPatch();
        Test.stopTest();

        //Test(Then)
        Assert.areEqual('true', response.responseBody.toString(), 'It\'s not the expected status of the PATCH resource');
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected response of the PATCH resource');
    }

    @IsTest
    private static void delete_withOutParameters(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI = '/delete/';
        request.httpMethod = 'DELETE';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doDelete();
        Test.stopTest();

        //Test(Then)
        Assert.areEqual('true', response.responseBody.toString(), 'It\'s not the expected status of the DELETE resource');
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected response of the DELETE resource');
    }

    @IsTest
    private static void put_withOutBody(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI = '/put/';
        request.httpMethod = 'PUT';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doPut();
        Test.stopTest();

        //Test(Then)
        Assert.areEqual('true', response.responseBody.toString(), 'It\'s not the expected status of the PUT resource');
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected response of the PUT resource');
    }

    @IsTest
    private static void post_withOutBody(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI = '/post/';
        request.httpMethod = 'POST';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doPost();
        Test.stopTest();

        //Test(Then)
        Assert.areEqual('true', response.responseBody.toString(), 'It\'s not the expected status of the POST resource');
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected response of the POST resource');
    }

    @IsTest
    private static void get_withOutParameters(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI = '/test/';
        request.httpMethod = 'GET';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doGet();
        Test.stopTest();

        //Test(Then)
        Assert.areEqual('true', response.responseBody.toString(), 'It\'s not the expected status of the Get resource');
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected response of the Get resource');
    }

    private static JSONResponse getRESTresponse() {
		Map<String, Object> responseUntyped = (Map<String, Object>) JSON.deserializeUntyped(RestContext.response.responseBody.toString());

        JSONResponse jsonResponse = new JSONResponse();

        jsonResponse.hasError = (Boolean) responseUntyped.get('hasError');
        jsonResponse.internalCode = (Integer) responseUntyped.get('internalCode');
        jsonResponse.message = (String) responseUntyped.get('message');
        jsonResponse.data = (object) responseUntyped.get('data');
        return jsonResponse;
    }

    private static List<Generic_REST_Route__mdt> getMetadata(){
        return (List<Generic_REST_Route__mdt>) JSON.deserialize(
            '['+
                '{' +
                    '"attributes.type": "Generic_REST_Route__mdt",' +
                    '"attributes.url": "m004W000000urxsQAA",' +
                    '"id": "m004W000000urxsQAA",' +
                    '"developername": "Test-Get",' +
                    '"masterlabel": "Test-Get",' +
                    '"language": "en_US",' +
                    '"namespaceprefix": null,' +
                    '"label": "Test-Get",' +
                    '"qualifiedapiname": "Test-Get",' +
                    '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' +
                    '"http_method__c": "GET",' +
                    '"path__c": "/test/",' +
                    '"class__c": "TestService",' +
                    '"method__c": "test method"' +
                '},'+
                '{' +
                    '"attributes.type": "Generic_REST_Route__mdt",' +
                    '"attributes.url": "m004W000000urxsQAB",' +
                    '"id": "m004W000000urxsQAB",' +
                    '"developername": "Exception-Get",' +
                    '"masterlabel": "Exception-Get",' +
                    '"language": "en_US",' +
                    '"namespaceprefix": null,' +
                    '"label": "Exception-Get",' +
                    '"qualifiedapiname": "Exception-Get",' +
                    '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' +
                    '"http_method__c": "GET",' +
                    '"path__c": "/exception/",' +
                    '"class__c": "TestService",' +
                    '"method__c": "Exception method"' +
                '},'+
                '{' +
                    '"attributes.type": "Generic_REST_Route__mdt",' +
                    '"attributes.url": "m004W000000urxsQAC",' +
                    '"id": "m004W000000urxsQAC",' +
                    '"developername": "Test-Post",' +
                    '"masterlabel": "Test-Post",' +
                    '"language": "en_US",' +
                    '"namespaceprefix": null,' +
                    '"label": "Test-Post",' +
                    '"qualifiedapiname": "Test-Post",' +
                    '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' +
                    '"http_method__c": "POST",' +
                    '"path__c": "/post/",' +
                    '"class__c": "TestService",' +
                    '"method__c": "post method"' +
                '},'+
                '{' +
                    '"attributes.type": "Generic_REST_Route__mdt",' +
                    '"attributes.url": "m004W000000urxsQAD",' +
                    '"id": "m004W000000urxsQAD",' +
                    '"developername": "Test-Put",' +
                    '"masterlabel": "Test-Put",' +
                    '"language": "en_US",' +
                    '"namespaceprefix": null,' +
                    '"label": "Test-Put",' +
                    '"qualifiedapiname": "Test-Put",' +
                    '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' +
                    '"http_method__c": "PUT",' +
                    '"path__c": "/put/",' +
                    '"class__c": "TestService",' +
                    '"method__c": "put method"' +
                '},'+
                '{' +
                    '"attributes.type": "Generic_REST_Route__mdt",' +
                    '"attributes.url": "m004W000000urxsQAE",' +
                    '"id": "m004W000000urxsQAE",' +
                    '"developername": "Test-Patch",' +
                    '"masterlabel": "Test-Patch",' +
                    '"language": "en_US",' +
                    '"namespaceprefix": null,' +
                    '"label": "Test-Patch",' +
                    '"qualifiedapiname": "Test-Patch",' +
                    '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' +
                    '"http_method__c": "PATCH",' +
                    '"path__c": "/patch/",' +
                    '"class__c": "TestService",' +
                    '"method__c": "patch method"' +
                '},'+
                '{' +
                    '"attributes.type": "Generic_REST_Route__mdt",' +
                    '"attributes.url": "m004W000000urxsQAF",' +
                    '"id": "m004W000000urxsQAF",' +
                    '"developername": "Test-Delete",' +
                    '"masterlabel": "Test-Delete",' +
                    '"language": "en_US",' +
                    '"namespaceprefix": null,' +
                    '"label": "Test-Delete",' +
                    '"qualifiedapiname": "Test-Delete",' +
                    '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' +
                    '"http_method__c": "DELETE",' +
                    '"path__c": "/delete/",' +
                    '"class__c": "TestService",' +
                    '"method__c": "delete method"' +
                '},'+
                '{' +
                    '"attributes.type": "Generic_REST_Route__mdt",' +
                    '"attributes.url": "m004W000000urxsQAG",' +
                    '"id": "m004W000000urxsQAG",' +
                    '"developername": "Test-GetPathParameters",' +
                    '"masterlabel": "Test-GetPathParameters",' +
                    '"language": "en_US",' +
                    '"namespaceprefix": null,' +
                    '"label": "Test-GetPathParameters",' +
                    '"qualifiedapiname": "Test-GetPathParameters",' +
                    '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' +
                    '"http_method__c": "GET",' +
                    '"path__c": "/test/*/withpathparameters/",' +
                    '"class__c": "TestService",' +
                    '"method__c": "test with params method"' +
                '},'+
                '{' +
                    '"attributes.type": "Generic_REST_Route__mdt",' +
                    '"attributes.url": "m004W000000urxsQAH",' +
                    '"id": "m004W000000urxsQAH",' +
                    '"developername": "Test-GetQueryParameters",' +
                    '"masterlabel": "Test-GetQueryParameters",' +
                    '"language": "en_US",' +
                    '"namespaceprefix": null,' +
                    '"label": "Test-GetQueryParameters",' +
                    '"qualifiedapiname": "Test-GetQueryParameters",' +
                    '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' +
                    '"http_method__c": "GET",' +
                    '"path__c": "/test/withquery/",' +
                    '"class__c": "TestService",' +
                    '"method__c": "test with query method"' +
                '},' +
                '{' +
                    '"attributes.type": "Generic_REST_Route__mdt",' +
                    '"attributes.url": "m004W000000urxsQAI",' +
                    '"id": "m004W000000urxsQAI",' +
                    '"developername": "Test-GetPathParametersAtEnds",' +
                    '"masterlabel": "Test-GetPathParametersAtEnds",' +
                    '"language": "en_US",' +
                    '"namespaceprefix": null,' +
                    '"label": "Test-GetPathParametersAtEnds",' +
                    '"qualifiedapiname": "Test-GetPathParametersAtEnds",' +
                    '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' +
                    '"http_method__c": "GET",' +
                    '"path__c": "/withpathparameters/*",' +
                    '"class__c": "TestService",' +
                    '"method__c": "test with params method"' +
                '}' +
            ']',
            List<Generic_REST_Route__mdt>.class
        );
    }

}