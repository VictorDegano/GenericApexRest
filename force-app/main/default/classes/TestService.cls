@IsTest
public inherited sharing class TestService implements InterfaceRESTGeneric{


    public static void execute(Object restParameters){
        Map<String, Object> parameters = (Map<String, Object>)restParameters;
        RestResponse response = RestContext.response;
        String result = '';
        String method = ((String) parameters.get('METHOD')).toLowerCase();
        System.debug(method);
        switch on method {
            when 'test method' {
                result = String.valueOf('test method'.equalsIgnoreCase((String) parameters.get('METHOD')));
            }
            when 'post method' {
                result = String.valueOf('post method'.equalsIgnoreCase((String) parameters.get('METHOD')));
            }
            when 'put method' {
                result = String.valueOf('put method'.equalsIgnoreCase((String) parameters.get('METHOD')));
            }
            when 'patch method' {
                result = String.valueOf('patch method'.equalsIgnoreCase((String) parameters.get('METHOD')));
            }
            when 'delete method' {
                result = String.valueOf('delete method'.equalsIgnoreCase((String) parameters.get('METHOD')));
            }
            when 'test with params method' {
                result = String.valueOf(((List<String>) parameters.get('PATH_PARAMETERS'))[0]);
            }
            when 'test with query method' {
                result = String.valueOf(RestContext.request.params.get('q'));
            }
            when else { // exception
                throw new HandledException();
            }
        }

        response.statuscode = 200;
        response.responseBody = Blob.valueOf(result);
    }

}