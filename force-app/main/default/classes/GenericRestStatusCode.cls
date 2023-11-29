public with sharing class GenericRestStatusCode {

    public static final RESTInternalCode UNHANDLED_ERROR = new RESTInternalCode( 0, 'UNHANDLED_ERROR', 'We have a unexpected Error. Please retry or contact with an adminsitrator.' );
    public static final RESTInternalCode SUCCESSFUL = new RESTInternalCode( 1, 'SUCCESSFUL', 'The Connection was a success.' );
    public static final RESTInternalCode UNKNOWN_RESOURCE = new RESTInternalCode( 2, 'UNKNOWN_RESOURCE', 'Unknown Resource.' );
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