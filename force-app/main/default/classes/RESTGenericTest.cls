@IsTest
private class RESTGenericTest{

    @TestSetup
    static void makeData(){
        REST_Access__c orgAccess = new REST_Access__c(SetupOwnerId=UserInfo.getOrganizationId(), Test__c = true );
        insert orgAccess;
    }

    @IsTest
    private static void canDenyAccessOfAProfileOverTheDefaultOrgSettings(){
        //Setup(Given)
        insert new REST_Access__c( Test__c = false, SetupOwnerId = UserInfo.getProfileId() );
        
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
        Assert.areEqual(GenericRestStatusCode.UNAUTHORIZED.DESCRIPTION, jsonResponse.message, 'It\'s not the expected status for a unauthorized exception');
        Assert.areEqual(401, response.statusCode, 'It\'s not the expected status code for a unauthorized exception');
    }

    @IsTest
    private static void canDenyAccessOfAUserOverTheDefaultOrgSettings(){
        //Setup(Given)
        insert new REST_Access__c( Test__c = false, SetupOwnerId = UserInfo.getUserId() );
        
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
        Assert.areEqual(GenericRestStatusCode.UNAUTHORIZED.DESCRIPTION, jsonResponse.message, 'It\'s not the expected status for a unauthorized exception');
        Assert.areEqual(401, response.statusCode, 'It\'s not the expected status code for a unauthorized exception');
    }

    @IsTest
    private static void IfUserDontHasAccessToRestGetAnUnauthorizedException(){
        //Setup(Given)
        delete REST_Access__c.getOrgDefaults();
        
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
        Assert.areEqual(GenericRestStatusCode.UNAUTHORIZED.DESCRIPTION, jsonResponse.message, 'It\'s not the expected status for a unauthorized exception');
        Assert.areEqual(401, response.statusCode, 'It\'s not the expected status code for a unauthorized exception');
    }

    @IsTest
    private static void patch_withBody(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        JSONRequest getRequest = new JSONRequest();
        getRequest.data = 'Patch Body';
        request.requestBody = Blob.valueOf(JSON.serialize(getRequest));

        request.requestURI = '/patchWithBody/';
        request.httpMethod = 'PATCH';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doPatch();
        Test.stopTest();

        //Test(Then)
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected response of the PATCH resource');
        Assert.areEqual(request.httpMethod + ' ' + getRequest.data, String.valueOf(jsonResponse.data), 'It\'s not the expected data Response of the PATCH resource');
    }

    @IsTest
    private static void delete_withBody(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        JSONRequest getRequest = new JSONRequest();
        getRequest.data = 'Delete Body';
        request.requestBody = Blob.valueOf(JSON.serialize(getRequest));

        request.requestURI = '/deleteWithBody/';
        request.httpMethod = 'DELETE';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doDelete();
        Test.stopTest();

        //Test(Then)
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual(request.httpMethod + ' ' + getRequest.data, (String) jsonResponse.data, 'It\'s not the expected data Response of the DELETE resource');
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected response of the DELETE resource');
    }

    @IsTest
    private static void put_withBody(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        JSONRequest getRequest = new JSONRequest();
        getRequest.data = 'Put Body';
        request.requestBody = Blob.valueOf(JSON.serialize(getRequest));


        request.requestURI = '/putWithBody/';
        request.httpMethod = 'PUT';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doPut();
        Test.stopTest();

        //Test(Then)
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual(request.httpMethod + ' ' + getRequest.data, (String) jsonResponse.data, 'It\'s not the expected data Response of the PUT resource');
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected response of the PUT resource');
    }

    @IsTest
    private static void post_withBody(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        JSONRequest getRequest = new JSONRequest();
        getRequest.data = 'Post Body';
        request.requestBody = Blob.valueOf(JSON.serialize(getRequest));

        request.requestURI = '/postWithBody/';
        request.httpMethod = 'POST';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doPost();
        Test.stopTest();

        //Test(Then)
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual(request.httpMethod + ' ' + getRequest.data, (String) jsonResponse.data, 'It\'s not the expected data Response of the POST resource');
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected response of the POST resource');
    }

    @IsTest
    private static void get_withBody(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        JSONRequest getRequest = new JSONRequest();
        getRequest.data = 'Get Body';
        request.requestBody = Blob.valueOf(JSON.serialize(getRequest));

        request.requestURI = '/testWithBody/';
        request.httpMethod = 'GET';

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doGet();
        Test.stopTest();

        //Test(Then)
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual(request.httpMethod + ' ' + getRequest.data, (String) jsonResponse.data, 'It\'s not the expected data Response of the GET resource');
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected response of the Get resource');
    }

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
        request.addParameter('q', '131');

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doGet();
        Test.stopTest();

        //Test(Then)
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual('131', jsonResponse.data, 'It\'s not the expected response of the Get resource');
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
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected status of the Get resource');
        Assert.areEqual('firstTest', jsonResponse.data, 'It\'s not the expected response of the Get resource');
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
    private static void badJsonBodyException(){
        //Setup(Given)
        RESTGeneric.route_Configs = getMetadata();

        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();

        request.requestURI = '/JSONexception/';
        request.httpMethod = 'GET';

        request.requestBody = Blob.valueOf('JSON Body Exception');

        RestContext.request = request;
        RestContext.response = response;

        //Exercise(When)
        Test.startTest();
        RESTGeneric.doGet();
        Test.stopTest();

        //Test(Then)
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual(GenericRestStatusCode.BAD_JSON_FORMAT_REQUEST.DESCRIPTION, jsonResponse.message, 'It\'s not the expected status for a bad json body');
        Assert.areEqual(400, response.statusCode, 'It\'s not the expected response for a BAD JSON BODY');
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
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual('true', jsonResponse.data, 'It\'s not the expected status of the PATCH resource');
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
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual('true', jsonResponse.data, 'It\'s not the expected status of the DELETE resource');
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
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual('true', jsonResponse.data, 'It\'s not the expected status of the PUT resource');
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
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual('true', jsonResponse.data, 'It\'s not the expected status of the POST resource');
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
        JSONResponse jsonResponse = getRESTresponse();
        Assert.areEqual('true', jsonResponse.data, 'It\'s not the expected status of the Get resource');
        Assert.areEqual(200, response.statusCode, 'It\'s not the expected response of the Get resource');
    }

    private static JSONResponse getRESTresponse(){
        Map<String, Object> responseUntyped = (Map<String, Object>)JSON.deserializeUntyped(RestContext.response.responseBody.toString());

        JSONResponse jsonResponse = new JSONResponse();

        jsonResponse.hasError = (Boolean) responseUntyped.get('hasError');
        jsonResponse.internalCode = (Integer) responseUntyped.get('internalCode');
        jsonResponse.message = (String) responseUntyped.get('message');
        jsonResponse.data = (object) responseUntyped.get('data');
        return jsonResponse;
    }

    private static List<Generic_REST_Route__mdt> getMetadata(){
        return (List<Generic_REST_Route__mdt>)JSON.deserialize('[' + 
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
            '"access_control_field__c": "test__c",' + 
            '"method__c": "test method"' + 
            '},' + 
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
            '"access_control_field__c": "test__c",' + 
            '"method__c": "Exception method"' + 
            '},' + 
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
            '"access_control_field__c": "test__c",' + 
            '"method__c": "post method"' + 
            '},' + 
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
            '"access_control_field__c": "test__c",' + 
            '"method__c": "put method"' + 
            '},' + 
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
            '"access_control_field__c": "test__c",' + 
            '"method__c": "patch method"' + 
            '},' + 
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
            '"access_control_field__c": "test__c",' + 
            '"method__c": "delete method"' + 
            '},' + 
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
            '"access_control_field__c": "test__c",' + 
            '"method__c": "test with params method"' + 
            '},' + 
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
            '"access_control_field__c": "test__c",' + 
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
            '"access_control_field__c": "test__c",' + 
            '"method__c": "test with params method"' + 
            '},' + 
            '{' + 
            '"attributes.type": "Generic_REST_Route__mdt",' + 
            '"attributes.url": "m004W000000urxsQAJ",' + 
            '"id": "m004W000000urxsQAJ",' + 
            '"developername": "Test-GetWithBody",' + 
            '"masterlabel": "Test-GetWithBody",' + 
            '"language": "en_US",' + 
            '"namespaceprefix": null,' + 
            '"label": "Test-GetWithBody",' + 
            '"qualifiedapiname": "Test-GetWithBody",' + 
            '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' + 
            '"http_method__c": "GET",' + 
            '"path__c": "/testWithBody/",' + 
            '"class__c": "TestService",' + 
            '"access_control_field__c": "test__c",' + 
            '"method__c": "WithBody"' + 
            '},' + 
            '{' + 
            '"attributes.type": "Generic_REST_Route__mdt",' + 
            '"attributes.url": "m004W000000urxsQAK",' + 
            '"id": "m004W000000urxsQAK",' + 
            '"developername": "Test-PostWithBody",' + 
            '"masterlabel": "Test-PostWithBody",' + 
            '"language": "en_US",' + 
            '"namespaceprefix": null,' + 
            '"label": "Test-Post",' + 
            '"qualifiedapiname": "Test-PostWithBody",' + 
            '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' + 
            '"http_method__c": "POST",' + 
            '"path__c": "/postWithBody/",' + 
            '"class__c": "TestService",' + 
            '"access_control_field__c": "test__c",' + 
            '"method__c": "WithBody"' + 
            '},' + 
            '{' + 
            '"attributes.type": "Generic_REST_Route__mdt",' + 
            '"attributes.url": "m004W000000urxsQAL",' + 
            '"id": "m004W000000urxsQAL",' + 
            '"developername": "Test-PutWithBody",' + 
            '"masterlabel": "Test-PutWithBody",' + 
            '"language": "en_US",' + 
            '"namespaceprefix": null,' + 
            '"label": "Test-PutWithBody",' + 
            '"qualifiedapiname": "Test-PutWithBody",' + 
            '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' + 
            '"http_method__c": "PUT",' + 
            '"path__c": "/putWithBody/",' + 
            '"class__c": "TestService",' + 
            '"access_control_field__c": "test__c",' + 
            '"method__c": "WithBody"' + 
            '},' + 
            '{' + 
            '"attributes.type": "Generic_REST_Route__mdt",' + 
            '"attributes.url": "m004W000000urxsQAM",' + 
            '"id": "m004W000000urxsQAM",' + 
            '"developername": "Test-PatchWithBody",' + 
            '"masterlabel": "Test-PatchWithBody",' + 
            '"language": "en_US",' + 
            '"namespaceprefix": null,' + 
            '"label": "Test-PatchWithBody",' + 
            '"qualifiedapiname": "Test-PatchWithBody",' + 
            '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' + 
            '"http_method__c": "PATCH",' + 
            '"path__c": "/patchWithBody/",' + 
            '"class__c": "TestService",' + 
            '"access_control_field__c": "test__c",' + 
            '"method__c": "WithBody"' + 
            '},' + 
            '{' + 
            '"attributes.type": "Generic_REST_Route__mdt",' + 
            '"attributes.url": "m004W000000urxsQAN",' + 
            '"id": "m004W000000urxsQAN",' + 
            '"developername": "Test-DeleteWithBody",' + 
            '"masterlabel": "Test-DeleteWithBody",' + 
            '"language": "en_US",' + 
            '"namespaceprefix": null,' + 
            '"label": "Test-DeleteWithBody",' + 
            '"qualifiedapiname": "Test-DeleteWithBody",' + 
            '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' + 
            '"http_method__c": "DELETE",' + 
            '"path__c": "/deleteWithBody/",' + 
            '"class__c": "TestService",' + 
            '"access_control_field__c": "test__c",' + 
            '"method__c": "WithBody"' + 
            '},' + 
            '{' + 
            '"attributes.type": "Generic_REST_Route__mdt",' + 
            '"attributes.url": "m004W000000urxsQAO",' + 
            '"id": "m004W000000urxsQAO",' + 
            '"developername": "JSONException-Get",' + 
            '"masterlabel": "JSONException-Get",' + 
            '"language": "en_US",' + 
            '"namespaceprefix": null,' + 
            '"label": "JSONException-Get",' + 
            '"qualifiedapiname": "JSONException-Get",' + 
            '"systemmodstamp": "2023-04-12T01:10:12.000+0000",' + 
            '"http_method__c": "GET",' + 
            '"path__c": "/JSONexception/",' + 
            '"class__c": "TestService",' + 
            '"access_control_field__c": "test__c",' + 
            '"method__c": "JSON Exception method"' + 
            '}' + 
            ']', List<Generic_REST_Route__mdt>.class);
    }

}