@IsTest
public inherited sharing class TestService implements InterfaceRESTGeneric{


    public static void execute(Object restParameters){        
        Map<String, Object> parameters = (Map<String, Object>)restParameters;
        JSONResponse responseBody = new JSONResponse();
        RestResponse response = RestContext.response;
        // String result = '';
        String method = ((String) parameters.get('METHOD')).toLowerCase();
        System.debug(method);
        switch on method {
            when 'test method' {
                responseBody.data = String.valueOf('test method'.equalsIgnoreCase((String) parameters.get('METHOD')));
            }
            when 'post method' {
                responseBody.data = String.valueOf('post method'.equalsIgnoreCase((String) parameters.get('METHOD')));
            }
            when 'put method' {
                responseBody.data = String.valueOf('put method'.equalsIgnoreCase((String) parameters.get('METHOD')));
            }
            when 'patch method' {
                responseBody.data = String.valueOf('patch method'.equalsIgnoreCase((String) parameters.get('METHOD')));
            }
            when 'delete method' {
                responseBody.data = String.valueOf('delete method'.equalsIgnoreCase((String) parameters.get('METHOD')));
            }
            when 'test with params method' {
                responseBody.data = String.valueOf(((List<String>) parameters.get('PATH_PARAMETERS'))[0]);
            }
            when 'test with query method' {
                responseBody.data = String.valueOf(RestContext.request.params.get('q'));
            }
            when else { // exception
                throw new HandledException();
            }
        }

        response.statuscode = 200;
        response.responseBody = responseBody.toBlob();
        // response.responseBody = Blob.valueOf(result);
    }

}