public with sharing class JSONRequest {

    public object data { get; set; }

    public static JSONRequest deserialize(String jsonString){
        return (JSONRequest) JSON.deserialize(jsonString, JSONRequest.class);
    }
}