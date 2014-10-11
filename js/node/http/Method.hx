package js.node.http;

/**
    Enumeration of possible HTTP methods as described in
    http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html
**/
@:enum abstract Method(String) from String to String {
    var Get = "GET";
    var Post = "POST";
    var Head = "HEAD";
    var Options = "OPTIONS";
    var Put = "PUT";
    var Delete = "DELETE";
    var Trace = "TRACE";
    var Connect = "CONNECT";
}
