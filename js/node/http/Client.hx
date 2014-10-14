package js.node.http;

import haxe.DynamicAccess;

@:deprecated("http.Client will be removed soon. Do not use it.")
extern class Client extends js.node.events.EventEmitter {
    @:overload(function(path:String, ?headers:DynamicAccess<String>):ClientRequest {})
    @:overload(function(method:Method, ?headers:DynamicAccess<String>):ClientRequest {})
    function request(method:Method, path:String, ?headers:DynamicAccess<String>):ClientRequest;
}
