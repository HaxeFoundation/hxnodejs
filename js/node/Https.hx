package js.node;

/**
 * HTTPS is the HTTP protocol over TLS/SSL. In Node this is implemented as a separate module.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:jsRequire("https")
extern class Https {
		
	/**
	 * 
	 */
	static var globalAgent : HttpsAgent;
	
	/**
	 * Returns a new web server object.
	 * The requestListener is a function which is automatically added to the 'request' event.
	 * @param	listener
	 * @return
	 */
	@:overload(function():js.node.http.HttpsServer { } )	
	static function createServer(listener : js.node.http.IncomingMessage -> js.node.http.ServerResponse -> Void):HttpsServer;
	
	/**
	 * Node maintains several connections per server to make HTTP requests. This function allows one to transparently issue requests.
	 * @param	options
	 * @param	callback
	 */
	@:overload(function(options:String, callback : ServerResponse -> Void):js.node.http.HttpClientRequest { } )
	@:overload(function(options:String):js.node.http.HttpClientRequest{})
	@:overload(function(options:js.node.Http.HttpRequestOptions):js.node.http.HttpClientRequest{})
	static function request(options : js.node.Http.HttpRequestOptions, callback : ServerResponse -> Void):js.node.http.HttpClientRequest;
	
	/**
	 * Since most requests are GET requests without bodies, Node provides this convenience method. The only difference between this method and http.request() is that it sets the method to GET and calls req.end() automatically.
	 * @param	options
	 * @param	callback
	 */
	@:overload(function(options:String, callback : ServerResponse -> Void):js.node.http.HttpClientRequest { } )
	@:overload(function(options:String):js.node.http.HttpClientRequest{})
	@:overload(function (options : js.node.Http.HttpRequestOptions):js.node.http.HttpClientRequest{})
	static function get(options : js.node.Http.HttpRequestOptions, callback : ServerResponse -> Void):js.node.http.HttpClientRequest; 
	
	
}

/**
 * An Agent object for HTTPS similar to http.Agent. See https.request() for more information.
 */
extern class HttpsAgent {
	
	/**
	 * By default set to 5. Determines how many concurrent sockets the agent can have open per origin. Origin is either a 'host:port' or 'host:port:localAddress' combination.
	 */
	var maxSockets : Int;
	
	/**
	 * An object which contains arrays of sockets currently in use by the Agent. Do not modify.
	 */
	var sockets : Array<js.node.net.TCPSocket>;
	
	/**
	 * An object which contains queues of requests that have not yet been assigned to sockets. Do not modify.
	 */
	var requests : Array<IncomingMessage>;
}
