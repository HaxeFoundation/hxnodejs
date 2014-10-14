package js.node;

import js.node.http.IncomingMessage;
import js.node.http.ClientRequest;
import js.node.http.ServerResponse;
import js.node.https.*;
import js.node.Tls.TlsServerOptions;
import js.node.Tls.TlsConnectOptions;

typedef HttpsRequestOptions = {
	>js.node.Http.HttpRequestOptions,
	>TlsConnectOptions, // TODO: clean those options up
}

/**
	HTTPS is the HTTP protocol over TLS/SSL.
	In Node this is implemented as a separate module.
**/
@:jsRequire("https")
extern class Https {

	/**
		Global instance of `Agent` for all HTTPS client requests.
	**/
	static var globalAgent:Agent;

	/**
		Returns a new HTTPS web server object.
		The options is similar to `Tls.createServer`.
		The `requestListener` is a function which is automatically added to the 'request' event.
	**/
	static function createServer(options:TlsServerOptions, ?listener:IncomingMessage->ServerResponse->Void):Server;

	/**
		Makes a request to a secure web server.

		`options` can be an object or a string. If `options` is a string, it is automatically parsed with `Url.parse`.

		All options from `Http.request` are valid.
	**/
	@:overload(function(options:String, ?callback:IncomingMessage->Void):ClientRequest {})
	static function request(options:HttpsRequestOptions, ?callback:IncomingMessage->Void):ClientRequest;

	/**
		Like `Http.get` but for HTTPS.
	**/
	@:overload(function(options:String, ?callback:IncomingMessage->Void):ClientRequest {})
	static function get(options:HttpsRequestOptions, ?callback:IncomingMessage->Void):ClientRequest;
}
