public with sharing class GenericRestStatusCode {

    public static final RESTInternalCode UNHANDLED_ERROR = new RESTInternalCode( 0, 'UNHANDLED_ERROR', 'We have a unexpected Error. Please retry or contact with an adminsitrator.' );
    public static final RESTInternalCode SUCCESSFUL = new RESTInternalCode( 1, 'SUCCESSFUL', 'The Connection was a success.' );
    public static final RESTInternalCode UNKNOWN_RESOURCE = new RESTInternalCode( 2, 'UNKNOWN_RESOURCE', 'Unknown Resource.' );
    public static final RESTInternalCode BAD_JSON_FORMAT_REQUEST = new RESTInternalCode( 3, 'BAD_JSON_FORMAT_REQUEST', 'The request body is not in correct JSON format.' );
    public static final RESTInternalCode UNAUTHORIZED = new RESTInternalCode( 4, 'UNAUTHORIZED', 'You don\'t have access to the Resource.' );
    public static final RESTInternalCode INTERNAL_ERROR = new RESTInternalCode( 500, 'INTERNAL_ERROR', 'Internal Server Error.' );

    public inherited sharing class RESTInternalCode {
        public final Integer CODE { get; set; }
        public final String NAME { get; set; }
        public final String DESCRIPTION { get; set; }

        private RESTInternalCode (Integer code, String valueCode, String descriptionCode){
            this.CODE = code;
            this.NAME = valueCode;
            this.DESCRIPTION = descriptionCode;
        }
    }
}