package js.node;
import js.node.http.IncomingMessage;
import js.node.http.ServerResponse;
import js.node.https.Agent;
import js.node.https.Server;

/**
	HTTPS is the HTTP protocol over TLS/SSL.
	In Node this is implemented as a separate module.
**/
@:jsRequire("https")
extern class Https {

	/**
	 *
	 */
	static var globalAgent : Agent;

	/**
	 * Returns a new web server object.
	 * The requestListener is a function which is automatically added to the 'request' event.
	 * @param	listener
	 * @return
	 */
	@:overload(function():js.node.http.Server { } )
	static function createServer(listener : js.node.http.IncomingMessage -> js.node.http.ServerResponse -> Void):Server;

	/**
	 * Node maintains several connections per server to make HTTP requests. This function allows one to transparently issue requests.
	 * @param	options
	 * @param	callback
	 */
	@:overload(function(options:String, callback : ServerResponse -> Void):js.node.http.ClientRequest { } )
	@:overload(function(options:String):js.node.http.ClientRequest{})
	@:overload(function(options:js.node.Http.HttpRequestOptions):js.node.http.ClientRequest{})
	static function request(options : js.node.Http.HttpRequestOptions, callback : ServerResponse -> Void):js.node.http.ClientRequest;

	/**
	 * Since most requests are GET requests without bodies, Node provides this convenience method. The only difference between this method and http.request() is that it sets the method to GET and calls req.end() automatically.
	 * @param	options
	 * @param	callback
	 */
	@:overload(function(options:String, callback : ServerResponse -> Void):js.node.http.ClientRequest { } )
	@:overload(function(options:String):js.node.http.ClientRequest{})
	@:overload(function (options : js.node.Http.HttpRequestOptions):js.node.http.ClientRequest{})
	static function get(options : js.node.Http.HttpRequestOptions, callback : ServerResponse -> Void):js.node.http.ClientRequest;


}
