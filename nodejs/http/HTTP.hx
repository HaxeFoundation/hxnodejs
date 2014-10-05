package nodejs.http;
import nodejs.net.TCPSocket;
import nodejs.NodeJS;
import js.html.ArrayBufferView;

extern class HTTPRequestOptions
{
	/**
	 *  A domain name or IP address of the server to issue the request to. Defaults to 'localhost'.
	 */
	var host : String;
		
	/**
	 *  To support url.parse() hostname is preferred over host
	 */
	var hostname : String;
	
	/**
	 *  Port of remote server. Defaults to 80.
	 */
	var port : Int;
	
	/**
	 *  Local interface to bind for network connections.
	 */
	var localAddress : String;
	
	/**
	 *  Unix Domain Socket (use one of host:port or socketPath)
	 */
	var socketPath : String;
	
	/**
	 *  A string specifying the HTTP request method. Defaults to 'GET'.
	 */
	var method : String;
	
	/**
	 *  Request path. Defaults to '/'. Should include query string if any. E.G. '/index.html?page=12'
	 */
	var path : String;
	
	/**
	 *  An object containing request headers.
	 */
	var headers : Dynamic;
	
	/**
	 *  Basic authentication i.e. 'user:password' to compute an Authorization header.
	 */
	var auth : String;
	
	/**
	 * Controls Agent behavior. When an Agent is used request will default to Connection: keep - alive. Possible values:
	 * undefined (default): use global Agent for this host and port.
	 * Agent object: explicitly use the passed in Agent.
	 * false: opts out of connection pooling with an Agent, defaults request to Connection: close.
	 */
	var agent : Dynamic;
	
}

/**
 * Class that describes the http methods defined by W3C.
 * http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html
 */
class HTTPMethod
{
	/**
	 * The GET method means retrieve whatever information (in the form of an entity) is identified by the Request-URI. If the Request-URI refers to a data-producing process, it is the produced data which shall be returned as the entity in the response and not the source text of the process, unless that text happens to be the output of the process.
	 * The semantics of the GET method change to a "conditional GET" if the request message includes an If-Modified-Since, If-Unmodified-Since, If-Match, If-None-Match, or If-Range header field. A conditional GET method requests that the entity be transferred only under the circumstances described by the conditional header field(s). The conditional GET method is intended to reduce unnecessary network usage by allowing cached entities to be refreshed without requiring multiple requests or transferring data already held by the client.
	 * The semantics of the GET method change to a "partial GET" if the request message includes a Range header field. A partial GET requests that only part of the entity be transferred, as described in section 14.35. The partial GET method is intended to reduce unnecessary network usage by allowing partially-retrieved entities to be completed without transferring data already held by the client.
	 * The response to a GET request is cacheable if and only if it meets the requirements for HTTP caching described in section 13.
	 */
	static public var Get 			: String = "GET";
	
	/**
	 * The POST method is used to request that the origin server accept the entity enclosed in the request as a new subordinate of the resource identified by the Request-URI in the Request-Line.
	 * POST is designed to allow a uniform method to cover the following functions:
     *- Annotation of existing resources;
     *- Posting a message to a bulletin board, newsgroup, mailing list,
     *  or similar group of articles;
     *- Providing a block of data, such as the result of submitting a
     *  form, to a data-handling process;
     *- Extending a database through an append operation.
	 * The actual function performed by the POST method is determined by the server and is usually dependent on the Request-URI. 
	 * The posted entity is subordinate to that URI in the same way that a file is subordinate to a directory containing it, a news article is subordinate to a newsgroup to which it is posted,
	 * or a record is subordinate to a database.
	 * The action performed by the POST method might not result in a resource that can be identified by a URI. In this case, either 200 (OK) or 204 (No Content) is the appropriate response status,
	 * depending on whether or not the response includes an entity that describes the result.
	 * If a resource has been created on the origin server, the response SHOULD be 201 (Created) and contain an entity which describes the status of the request and refers to the new resource, and
	 * a Location header (see section 14.30).
	 * Responses to this method are not cacheable, unless the response includes appropriate Cache-Control or Expires header fields. 
	 * However, the 303 (See Other) response can be used to direct the user agent to retrieve a cacheable resource.
	 * POST requests MUST obey the message transmission requirements set out in section 8.2.
	 */
	static public var Post 			: String = "POST";
	
	/**
	 * The OPTIONS method represents a request for information about the communication options available on the request/response chain identified by the Request-URI. 
	 * This method allows the client to determine the options and/or requirements associated with a resource, or the capabilities of a server, without implying a resource action or initiating a resource retrieval.
	 * Responses to this method are not cacheable.
	 * If the OPTIONS request includes an entity-body (as indicated by the presence of Content-Length or Transfer-Encoding), then the media type MUST be indicated by a Content-Type field.
	 * Although this specification does not define any use for such a body, future extensions to HTTP might use the OPTIONS body to make more detailed queries on the server.
	 * A server that does not support such an extension MAY discard the request body.
	 * If the Request-URI is an asterisk ("*"), the OPTIONS request is intended to apply to the server in general rather than to a specific resource. 
	 * Since a server's communication options typically depend on the resource, the "*" request is only useful as a "ping" or "no-op" type of method; it does nothing beyond allowing the client to test the capabilities of the server.
	 * For example, this can be used to test a proxy for HTTP/1.1 compliance (or lack thereof).
	 * If the Request-URI is not an asterisk, the OPTIONS request applies only to the options that are available when communicating with that resource.
	 * A 200 response SHOULD include any header fields that indicate optional features implemented by the server and applicable to that resource (e.g., Allow), possibly including extensions
	 * not defined by this specification. The response body, if any, SHOULD also include information about the communication options. The format for such a
	 * body is not defined by this specification, but might be defined by future extensions to HTTP. Content negotiation MAY be used to select the appropriate response format. 
	 * If no response body is included, the response MUST include a Content-Length field with a field-value of "0".
	 * The Max-Forwards request-header field MAY be used to target a specific proxy in the request chain. 
	 * When a proxy receives an OPTIONS request on an absoluteURI for which request forwarding is permitted, the proxy MUST check for a Max-Forwards field. If the Max-Forwards field-value is zero ("0"), the proxy MUST NOT forward the message; instead, the proxy SHOULD respond with its own communication options. If the Max-Forwards field-value is an integer greater than zero, the proxy MUST decrement the field-value when it forwards the request. If no Max-Forwards field is present in the request, then the forwarded request MUST NOT include a Max-Forwards field.
	 */
	static public var Options 		: String = "OPTIONS";
	
	/**
	 *The HEAD method is identical to GET except that the server MUST NOT return a message-body in the response.
	 * The metainformation contained in the HTTP headers in response to a HEAD request SHOULD be identical to the information sent in response to a GET request. 
	 * This method can be used for obtaining metainformation about the entity implied by the request without transferring the entity-body itself.
	 * This method is often used for testing hypertext links for validity, accessibility, and recent modification.
	 * The response to a HEAD request MAY be cacheable in the sense that the information contained in the response MAY be used to update a previously cached entity from that resource.
	 * If the new field values indicate that the cached entity differs from the current entity (as would be indicated by a change in Content-Length, Content-MD5, ETag or Last-Modified),
	 * then the cache MUST treat the cache entry as stale. 
	 */
	static public var Head 			: String = "HEAD";
	
	/**
	 * The PUT method requests that the enclosed entity be stored under the supplied Request-URI. If the Request-URI refers to an already existing resource, the enclosed entity SHOULD be considered
	 * as a modified version of the one residing on the origin server. If the Request-URI does not point to an existing resource, and that URI is capable of being defined as a new resource by the 
	 * requesting user agent, the origin server can create the resource with that URI. If a new resource is created, the origin server MUST inform the user agent via the 201 (Created) response. 
	 * If an existing resource is modified, either the 200 (OK) or 204 (No Content) response codes SHOULD be sent to indicate successful completion of the request. If the resource could not 
	 * be created or modified with the Request-URI, an appropriate error response SHOULD be given that reflects the nature of the problem. The recipient of the entity MUST NOT ignore any 
	 * Content-* (e.g. Content-Range) headers that it does not understand or implement and MUST return a 501 (Not Implemented) response in such cases.
	 * If the request passes through a cache and the Request-URI identifies one or more currently cached entities, those entries SHOULD be treated as stale. Responses to this method are not cacheable.
	 * The fundamental difference between the POST and PUT requests is reflected in the different meaning of the Request-URI. The URI in a POST request identifies the resource that will handle
	 * the enclosed entity. That resource might be a data-accepting process, a gateway to some other protocol, or a separate entity that accepts annotations. In contrast, the URI in a PUT request
	 * identifies the entity enclosed with the request -- the user agent knows what URI is intended and the server MUST NOT attempt to apply the request to some other resource.
	 * If the server desires that the request be applied to a different URI,
	 * it MUST send a 301 (Moved Permanently) response; the user agent MAY then make its own decision regarding whether or not to redirect the request.
	 * A single resource MAY be identified by many different URIs. For example, an article might have a URI for identifying "the current version" which is separate from the URI identifying 
	 * each particular version. In this case, a PUT request on a general URI might result in several other URIs being defined by the origin server.
	 * HTTP/1.1 does not define how a PUT method affects the state of an origin server.
	 * PUT requests MUST obey the message transmission requirements set out in section 8.2.
	 * Unless otherwise specified for a particular entity-header, the entity-headers in the PUT request SHOULD be applied to the resource created or modified by the PUT.
	 */
	static public var Put 			: String = "PUT";
	
	/**
	 * The DELETE method requests that the origin server delete the resource identified by the Request-URI. This method MAY be overridden by human intervention (or other means) on the origin server. The client cannot be guaranteed that the operation has been carried out, even if the status code returned from the origin server indicates that the action has been completed successfully. However, the server SHOULD NOT indicate success unless, at the time the response is given, it intends to delete the resource or move it to an inaccessible location.
	 * A successful response SHOULD be 200 (OK) if the response includes an entity describing the status, 202 (Accepted) if the action has not yet been enacted, or 204 (No Content) if the action has been enacted but the response does not include an entity.
	 * If the request passes through a cache and the Request-URI identifies one or more currently cached entities, those entries SHOULD be treated as stale. Responses to this method are not cacheable.
	 */
	static public var Delete		: String = "DELETE";
	
	/**
	 * The TRACE method is used to invoke a remote, application-layer loop- back of the request message. The final recipient of the request SHOULD reflect the message received back to the client as the entity-body of a 200 (OK) response. The final recipient is either the
	 * origin server or the first proxy or gateway to receive a Max-Forwards value of zero (0) in the request (see section 14.31). A TRACE request MUST NOT include an entity.
	 * TRACE allows the client to see what is being received at the other end of the request chain and use that data for testing or diagnostic information. The value of the Via header field (section 14.45) is of particular interest, since it acts as a trace of the request chain. Use of the Max-Forwards header field allows the client to limit the length of the request chain, which is useful for testing a chain of proxies forwarding messages in an infinite loop.
	 * If the request is valid, the response SHOULD contain the entire request message in the entity-body, with a Content-Type of "message/http". Responses to this method MUST NOT be cached
	 */
	static public var Trace			: String = "TRACE";
	
	/**
	 * This specification reserves the method name CONNECT for use with a proxy that can dynamically switch to being a tunnel (e.g. SSL tunneling [44]).
	 */
	static public var Connect		: String = "CONNECT";
}

/**
 * To use the HTTP server and client one must require('http').
 * The HTTP interfaces in Node are designed to support many features of the protocol which have been traditionally difficult to use. 
 * In particular, large, possibly chunk-encoded, messages. The interface is careful to never buffer entire requests or responses--the user is able to stream data.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('http'))")
extern class HTTP
{
	/**
	 * A collection of all the standard HTTP response status codes, and the short description of each. For example, http.STATUS_CODES[404] === 'Not Found'.
	 */
	static var STATUS_CODES : Dynamic;
	
	/**
	 * Global instance of Agent which is used as the default for all http client requests.
	 */
	static var globalAgent : HTTPAgent;
	
	/**
	 * Returns a new web server object.
	 * The requestListener is a function which is automatically added to the 'request' event.
	 * @param	listener
	 * @return
	 */
	@:overload(function():HTTPServer { } )	
	static function createServer(listener : IncomingMessage -> ServerResponse -> Void):HTTPServer;
	
	/**
	 * This function is deprecated; please use http.request() instead. Constructs a new HTTP client. port and host refer to the server to be connected to.
	 * @param	p_port
	 * @param	p_host
	 * @return
	 */
	@:overload(function():Dynamic{})
	@:overload(function(p_port:Int):Dynamic{})
	static function createClient(p_port:Int,p_host:String):Dynamic;
	
	
	/**
	 * Node maintains several connections per server to make HTTP requests. This function allows one to transparently issue requests.
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function(p_options:String, p_callback : ServerResponse -> Void):HTTPClientRequest { } )
	@:overload(function(p_options:String):HTTPClientRequest{})
	@:overload(function(p_options:HTTPRequestOptions):HTTPClientRequest{})
	static function request(p_options : HTTPRequestOptions, p_callback : ServerResponse -> Void):HTTPClientRequest;
	
	/**
	 * Since most requests are GET requests without bodies, Node provides this convenience method. The only difference between this method and http.request() is that it sets the method to GET and calls req.end() automatically.
	 * @param	p_options
	 * @param	p_callback
	 */
	@:overload(function(p_options:String, p_callback : ServerResponse -> Void):HTTPClientRequest { } )
	@:overload(function(p_options:String):HTTPClientRequest{})
	@:overload(function (p_options : HTTPRequestOptions):HTTPClientRequest{})
	static function get(p_options : HTTPRequestOptions, p_callback : ServerResponse -> Void):HTTPClientRequest;
	
	
}


/**
 * In node 0.5.3+ there is a new implementation of the HTTP Agent which is used for pooling sockets used in HTTP client requests.
 * Previously, a single agent instance helped pool for a single host+port. The current implementation now holds sockets for any number of hosts.
 * The current HTTP Agent also defaults client requests to using Connection:keep-alive. If no pending HTTP requests are waiting on a socket to become free the socket is closed. This means that node's pool has the benefit of keep-alive when under load but still does not require developers to manually close the HTTP clients using keep-alive.
 * Sockets are removed from the agent's pool when the socket emits either a "close" event or a special "agentRemove" event. This means that if you intend to keep one HTTP request open for a long time and don't want it to stay in the pool you can do something along the lines of:
 */

extern class HTTPAgent
{
	/**
	 * By default set to 5. Determines how many concurrent sockets the agent can have open per origin. Origin is either a 'host:port' or 'host:port:localAddress' combination.
	 */
	var maxSockets : Int;
	
	/**
	 * An object which contains arrays of sockets currently in use by the Agent. Do not modify.
	 */
	var sockets : Array<TCPSocket>;
	
	/**
	 * An object which contains queues of requests that have not yet been assigned to sockets. Do not modify.
	 */
	var requests : Array<IncomingMessage>;
}