package nodejs.http;
import nodejs.events.EventEmitter;
import nodejs.stream.Writable;

/**
 * 
 */
class HTTPClientRequestEventType
{
	/**	 
	 * Emitted when a response is received to this request. This event is emitted only once. The response argument will be an instance of http.IncomingMessage.
	 * function (response) { }
	 * Options:
	 * host: A domain name or IP address of the server to issue the request to.
	 * port: Port of remote server.
	 * socketPath: Unix Domain Socket (use one of host:port or socketPath)
	 */
	static public var Response : String = "response";
	
	/**
	 * Emitted after a socket is assigned to this request.
	 * function (socket) { }
	 */
	static public var Socket : String = "socket";
	
	/**
	 * Emitted each time a server responds to a request with a CONNECT method. If this event isn't being listened for, clients receiving a CONNECT method will have their connections closed.
	 * function (response, socket, head) { }
	 * A client server pair that show you how to listen for the connect event.
	 */
	static public var Connect : String = "connect";
	
	/**
	 * Emitted each time a server responds to a request with an upgrade. If this event isn't being listened for, clients receiving an upgrade header will have their connections closed.
	 * function (response, socket, head) { }
	 * A client server pair that show you how to listen for the upgrade event.
	 */
	static public var Upgrade : String = "upgrade";
	
	/**
	 * Emitted when the server sends a '100 Continue' HTTP response, usually because the request contained 'Expect: 100-continue'. This is an instruction that the client should send the request body.
	 * function () { }
	 */
	static public var Continue : String = "continue";
	
}

/**
 * This object is created internally and returned from http.request(). 
 * It represents an in-progress request whose header has already been queued. 
 * The header is still mutable using the setHeader(name, value), getHeader(name), removeHeader(name) API.
 * The actual header will be sent along with the first data chunk or when closing the connection.
 * 
 * http://nodejs.org/api/http.html#http_class_http_clientrequest
 * 
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class HTTPClientRequest extends Writable
{
	
	/**
	 * Aborts a request. (New since v0.3.8.)
	 */
	function abort() : Void;
	
	/**
	 * Once a socket is assigned to this request and is connected socket.setTimeout() will be called.
	 * @param	p_timeout
	 * @param	p_callback
	 */
	@:overload(function(p_timeout:Int):Void{})
	function setTimeout(p_timeout:Int, p_callback:Dynamic):Void;
		
	/**
	 * Once a socket is assigned to this request and is connected socket.setNoDelay() will be called.
	 * @param	p_nodelay
	 */
	@:overload(function():Void { } )
	function setNoDelay(p_nodelay:Bool):Void;
	
	/**
	 * Once a socket is assigned to this request and is connected socket.setKeepAlive() will be called.
	 * @param	p_enable
	 * @param	p_initialDelay
	 */
	@:overload(function():Void { } )
	@:overload(function(p_enable : Bool):Void { } )	
	function setKeepAlive(p_enable : Bool, p_initialDelay:Int):Void;
	
}