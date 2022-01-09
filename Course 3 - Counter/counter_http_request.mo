import Text "mo:base/Text";
import Nat "mo:base/Nat";

actor Counter{
    public type ChunkId = Nat;
    public type HeaderField = (Text, Text);
    public type HttpRequest = {
        url : Text;
        method : Text;
        body : Text;
        headers : [HeaderField];
    };

    public type HttpResponse = {
        body : Blob;
        headers : [HeaderField];
        streaming_strategy : ?StreamingStrategy;
        status_code : Nat16;
    };
    public type Key = Text;
    public type Path = Text;
    public type SetAssetContentArguments = {
        key : Key;
        sha256 : ?[Nat8];
        chunk_ids : [ChunkId];
        content_encoding : Text;
    };
    public type StreamingCallbackResponse = {
        token : ?StreamingCallbackToken;
        body : [Nat8];
    };
    public type StreamingCallbackToken = {
        key : Key;
        sha256 : ?[Nat8];
        index : Nat;
        content_encoding : Text;
    };
    public type StreamingStrategy = {
        #Callback : {
            token : StreamingCallbackToken;
            callback : shared query StreamingCallbackToken -> async StreamingCallbackResponse;
        };
    };

    var counter = 0;

    // Get the value of the counter.
    public query func get() : async Nat {
        return counter;
    };

    // Set the value of the counter.
    public func set(n : Nat) : async () {
        counter := n;
    };

    // Increment the value of the counter.
    public func inc() : async () {
        counter += 1;
    };

    public shared query func http_request() : async HttpResponse {
        {
            body = Text.encodeUtf8("<html><body><h1>" # "Current value of 'counter': " # Nat.toText(counter) # "</h1></body></html>");
            headers = [];
            streaming_strategy = null;
            status_code = 200;
        }
    };
}