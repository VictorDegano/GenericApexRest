public with sharing class JSONRequest {
    public JSONRequest() {

    }

    public static JSONRequest deserialize(String jsonString){
        return (JSONRequest) JSON.deserialize(jsonString, JSONRequest.class);
    }
}