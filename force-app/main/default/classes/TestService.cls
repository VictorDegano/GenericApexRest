@IsTest
public inherited sharing class TestService implements InterfaceRESTGeneric{
    public static void execute(Object restParameters){
        Map<String, Object> parameters = (Map<String, Object>)restParameters;
        JSONResponse responseBody = new JSONResponse();
        RestResponse response = RestContext.response;

        String method = ((String) parameters.get(RESTGeneric.METHOD)).toLowerCase();

        switch  on method{
            when 'test method'{
                responseBody.data = String.valueOf('test method'.equalsIgnoreCase(method));
            }
            when 'post method'{
                responseBody.data = String.valueOf('post method'.equalsIgnoreCase(method));
            }
            when 'put method'{
                responseBody.data = String.valueOf('put method'.equalsIgnoreCase(method));
            }
            when 'patch method'{
                responseBody.data = String.valueOf('patch method'.equalsIgnoreCase(method));
            }
            when 'delete method'{
                responseBody.data = String.valueOf('delete method'.equalsIgnoreCase(method));
            }
            when 'test with params method'{
                responseBody.data = String.valueOf(((List<String>)parameters.get(RESTGeneric.PATH_PARAMETERS))[0]);
            }
            when 'test with query method'{
                responseBody.data = String.valueOf(RestContext.request.params.get('q'));
            }
            when 'withbody'{
                responseBody.data = RestContext.request.httpMethod + ' ' + ((JSONRequest)parameters.get(RESTGeneric.REQUEST_BODY)).data;
            }
            when else{
                throw new HandledException('Unknown Method');
            }
        }

        response.statuscode = 200;
        response.responseBody = responseBody.toBlob();
    }

}