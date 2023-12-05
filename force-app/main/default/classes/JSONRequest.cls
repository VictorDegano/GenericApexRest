public with sharing class JSONRequest {

    public object data { get; set; }

    public static JSONRequest deserializeFromBlob(Blob requestBody){
        return deserialize(requestBody.toString());
    }

    public static JSONRequest deserialize(String jsonString){
        Map<String, Object> responseUntyped = (Map<String, Object>) JSON.deserializeUntyped(jsonString);
        System.debug(responseUntyped);
        JSONRequest jsonRequest = new JSONRequest();
        jsonRequest.data = (object) responseUntyped.get('data');

        return jsonRequest;
    }
}