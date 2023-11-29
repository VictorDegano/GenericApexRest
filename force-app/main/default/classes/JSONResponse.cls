public with sharing class JSONResponse {
    public Boolean hasError { get; set; }
    public Integer internalCode { get; set; }
    public String message { get; set; }
    public Object data { get; set; }

    public JSONResponse() {
        this.initialize();
    }

    private void initialize(){
        this.hasError = false;
        this.internalCode = GenericRestStatusCode.SUCCESSFUL.CODE;
        this.message = GenericRestStatusCode.SUCCESSFUL.DESCRIPTION;
        this.data = new List<Object>();
    }

    public String serialize(){
        return JSON.serializePretty(this);
    }

    public Blob toBlob(){
        return Blob.valueOf(this.serialize());
    }
}