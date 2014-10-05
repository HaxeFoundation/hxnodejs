package nodejs.http;
import nodejs.http.HTTP.HTTPRequestOptions;
import nodejs.net.TCPSocket;
import nodejs.NodeJS;
import js.html.ArrayBufferView;



/**
 * HTTPS is the HTTP protocol over TLS/SSL. In Node this is implemented as a separate module.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('https'))")
extern class HTTPS
{
		
	/**
	 * 
	 */
	static var globalAgent : HTTPSAgent;
	
	/**
	 * Returns a new web server object.
	 * The requestListener is a function which is automatically added to the 'request' event.
	 * @param	listener
	 * @return
	 */
	@:overload(function():HTTPSServer { } )	
	static function createServer(listener : IncomingMessage -> ServerResponse -> Void):HTTPSServer;
	
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
 * An Agent object for HTTPS similar to http.Agent. See https.request() for more information.
 */
extern class HTTPSAgent
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
