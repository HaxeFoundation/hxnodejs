/*
 * Copyright (C)2014-2026 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package js.node;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.http.*;
import js.node.net.Socket;
import js.node.stream.Duplex;
import js.node.url.URL;
import js.node.web.AbortSignal;
import js.lib.Error;

/**
	The HTTP interfaces in Node are designed to support many features of the protocol
	which have been traditionally difficult to use. In particular, large, possibly chunk-encoded, messages.
	The interface is careful to never buffer entire requests or responses--the user is able to stream data.

	HTTP message headers are represented by an object like this:
		{ 'content-length': '123',
		  'content-type': 'text/plain',
		  'connection': 'keep-alive' }
	Keys are lowercased. Values are not modified.

	In order to support the full spectrum of possible HTTP applications, Node's HTTP API is very low-level.
	It deals with stream handling and message parsing only. It parses a message into headers and body but
	it does not parse the actual headers or the body.
**/
@:jsRequire("http")
extern class Http {
	/**
		A list of the HTTP methods that are supported by the parser.
	**/
	static var METHODS:Array<String>;

	/**
		A collection of all the standard HTTP response status codes, and the short description of each.
		For example, `http.STATUS_CODES[404] === 'Not Found'`.
	**/
	static var STATUS_CODES(default, null):DynamicAccess<String>;

	/**
		Returns a new web server object.

		The `requestListener` is a function which is automatically added to the `'request'` event.
	**/
	@:overload(function(options:HttpCreateServerOptions, ?requestListener:(request:IncomingMessage, response:ServerResponse) -> Void):Server {})
	static function createServer(?requestListener:(request:IncomingMessage, response:ServerResponse) -> Void):Server;

	/**
		Since most requests are GET requests without bodies, Node.js provides this convenience method.
		The only difference between this method and `request()` is that it sets the method to GET and calls `end()` automatically.
		The callback must take care to consume the response data for reasons stated in `http.ClientRequest` section.
	**/
	@:overload(function(url:URL, ?options:HttpRequestOptions, ?callback:IncomingMessage->Void):ClientRequest {})
	@:overload(function(url:String, ?options:HttpRequestOptions, ?callback:IncomingMessage->Void):ClientRequest {})
	static function get(options:HttpRequestOptions, ?callback:IncomingMessage->Void):ClientRequest;

	/**
		Global instance of Agent which is used as the default for all http client requests.
	**/
	static var globalAgent:Agent;

	/**
		Read-only maximum allowed size of HTTP headers in bytes.
		Defaults to 16 KiB. Configurable via `--max-http-header-size`.

		@see https://nodejs.org/docs/latest-v24.x/api/http.html#httpmaxheadersize
	**/
	static var maxHeaderSize(default, null):Int;

	/**
		Node.js maintains several connections per server to make HTTP requests.
		This function allows one to transparently issue requests.

		`url` can be a string or a URL object.
		If `url` is a string, it is automatically parsed with `new URL()`.
		If it is a `URL` object, it will be automatically converted to an ordinary `options` object.

		If both `url` and `options` are specified, the objects are merged, with the `options` properties taking precedence.

		The optional `callback` parameter will be added as a one-time listener for the `'response'` event.

		`request()` returns an instance of the `http.ClientRequest` class.
		The `ClientRequest` instance is a writable stream.
		If one needs to upload a file with a POST request, then write to the `ClientRequest` object.
	**/
	@:overload(function(url:URL, ?options:HttpRequestOptions, ?callback:IncomingMessage->Void):ClientRequest {})
	@:overload(function(url:String, ?options:HttpRequestOptions, ?callback:IncomingMessage->Void):ClientRequest {})
	static function request(options:HttpRequestOptions, ?callback:IncomingMessage->Void):ClientRequest;

	/**
		Performs the low-level validations on the provided `name` that are done when `res.setHeader(name, value)` is called.
		@throws `TypeError` if the `name` is invalid.
	**/
	static function validateHeaderName(name:String, ?label:String):Void;

	/**
		Performs the low-level validations on the provided `value` that are done when `res.setHeader(name, value)` is called.
		@throws `TypeError` if the `value` is invalid.
	**/
	static function validateHeaderValue(name:String, value:EitherType<String, Array<String>>):Void;

	/**
		Set the maximum number of idle HTTP parsers that can stay around for reuse.
		Default: `1000`.
	**/
	static function setMaxIdleHTTPParsers(max:Int):Void;

	/**
		Undici `WebSocket` constructor exposed via `node:http`.
	**/
	static var WebSocket:Class<js.node.web.WebSocket>;

	/**
		Undici `CloseEvent` constructor exposed via `node:http`.
	**/
	static var CloseEvent:Class<js.node.web.CloseEvent>;

	/**
		Undici `MessageEvent` constructor exposed via `node:http`.
	**/
	static var MessageEvent:Class<js.node.web.MessageEvent>;

	/**
		Parent class of `http.ClientRequest` and `http.ServerResponse`.

		@see https://nodejs.org/docs/latest-v24.x/api/http.html#class-httpoutgoingmessage
	**/
	static var OutgoingMessage:Class<OutgoingMessage>;

	/**
		Dynamically resets the global configurations to enable built-in proxy support for
		`fetch()` and `http.request()` / `https.request()` at runtime.

		Returns a restore function for the previous agent/dispatcher settings.

		Added in: v24.14.0.

		@see https://nodejs.org/docs/latest-v24.x/api/http.html#httpsetglobalproxyfromenvproxyenv
	**/
	static function setGlobalProxyFromEnv(?proxyEnv:DynamicAccess<String>):() -> Void;
}

typedef HttpCreateServerOptions = {
	/**
		Specifies the `IncomingMessage` class to be used. Useful for extending the original `IncomingMessage`.

		Default: `js.node.http.IncomingMessage`.
	**/
	@:optional var IncomingMessage:Class<IncomingMessage>;

	/**
		Specifies the `ServerResponse` class to be used. Useful for extending the original `ServerResponse`.

		Default: `ServerResponse`.
	**/
	@:optional var ServerResponse:Class<ServerResponse>;

	/**
		Sets the timeout value in milliseconds for receiving the entire request from the client.
		See `server.requestTimeout`.
	**/
	@:optional var requestTimeout:Int;

	/**
		Sets the timeout value in milliseconds for receiving the complete HTTP headers from the client.
		See `server.headersTimeout`.
	**/
	@:optional var headersTimeout:Int;

	/**
		The number of milliseconds of inactivity a server needs to wait for additional incoming data,
		after it has finished writing the last response, before a socket will be destroyed.
	**/
	@:optional var keepAliveTimeout:Int;

	/**
		Additional milliseconds of inactivity to allow before destroying a keep-alive socket
		after `keepAliveTimeout` elapses. Default: `1000`.
	**/
	@:optional var keepAliveTimeoutBuffer:Int;

	/**
		Sets the interval value in milliseconds to check for request and headers timeout in incomplete requests.
	**/
	@:optional var connectionsCheckingInterval:Int;

	/**
		Sets the maximum number of requests that may be made on a single socket before it is closed.
		Default: `0` (no limit).
	**/
	@:optional var maxRequestsPerSocket:Int;

	/**
		Whether or not to enable keep-alive on incoming connections.
	**/
	@:optional var keepAlive:Bool;

	/**
		Initial delay for keep-alive in milliseconds.
	**/
	@:optional var keepAliveInitialDelay:Int;

	/**
		Optionally overrides all `net.Socket`s' `readableHighWaterMark` and `writableHighWaterMark`.
	**/
	@:optional var highWaterMark:Int;

	/**
		If set to `true`, it disables the use of Nagle's algorithm immediately after a new incoming connection is received.
	**/
	@:optional var noDelay:Bool;

	/**
		Optionally overrides the value of `--max-http-header-size` for requests
		received by this server. Default: `16384` (16 KiB).
	**/
	@:optional var maxHeaderSize:Int;

	/**
		If set to `true`, use an HTTP parser with leniency flags enabled.
		Default: `false`.
	**/
	@:optional var insecureHTTPParser:Bool;

	/**
		If set to `true`, join duplicate header field values with `, ` instead of discarding.
		Default: `false`.
	**/
	@:optional var joinDuplicateHeaders:Bool;

	/**
		If set to `true`, respond with `400 Bad Request` when an HTTP/1.1 request lacks a `Host` header.
		Default: `true`.
	**/
	@:optional var requireHostHeader:Bool;

	/**
		Callback that receives an incoming request and returns whether an upgrade should be accepted.
		Default: accept upgrades when a `'upgrade'` listener is registered.
	**/
	@:optional var shouldUpgradeCallback:(request:IncomingMessage) -> Bool;

	/**
		`uniqueHeaders` is an optional configuration specific to HTTP servers.

		@see https://nodejs.org/docs/latest-v24.x/api/http.html#httpcreateserveroptions-requestlistener
	**/
	@:optional var uniqueHeaders:Array<EitherType<String, Array<String>>>;

	/**
		If set to `true`, writing a body for methods/statuses that do not allow one throws.
		Default: `false`.
	**/
	@:optional var rejectNonStandardBodyWrites:Bool;

	/**
		If set to `true`, requests without a body are initialized as already-ended readable streams.
		Default: `false`.
	**/
	@:optional var optimizeEmptyRequests:Bool;
}

/**
	Type of the options object passed to `Http.request`.
**/
typedef HttpRequestOptions = {
	/**
		Controls Agent behavior.

		Possible values:

		- `undefined` (default): use http.globalAgent for this host and port.
		- `Agent` object: explicitly use the passed in `Agent`.
		- `false` : causes a new `Agent` with default values to be used.
	**/
	@:optional var agent:EitherType<Agent, Bool>;

	/**
		Basic authentication i.e. `'user:password'` to compute an Authorization header.
	**/
	@:optional var auth:String;

	/**
		A function that produces a socket/stream to use for the request when the `agent` option is not used.
		This can be used to avoid creating a custom `Agent` class just to override the default `createConnection` function.
		See [agent.createConnection()](https://nodejs.org/docs/latest-v24.x/api/http.html#agentcreateconnectionoptions-callback) for more details.
		Any `Duplex` stream is a valid return value.
	**/
	@:optional var createConnection:(options:SocketConnectOptionsTcp, ?callback:(err:Error, stream:IDuplex) -> Void) -> IDuplex;

	/**
		Default port for the protocol.

		Default: `agent.defaultPort` if an Agent is used, else `undefined`.
	**/
	@:optional var defaultPort:Int;

	/**
		IP address family to use when resolving `host` or `hostname`.
		Valid values are `4` or `6`. When unspecified, both IP v4 and v6 will be used.
	**/
	@:optional var family:js.node.Dns.DnsAddressFamily;

	/**
		An object or raw-headers array containing request headers.
	**/
	@:optional var headers:EitherType<DynamicAccess<EitherType<String, Array<String>>>, Array<String>>;

	/**
		A domain name or IP address of the server to issue the request to.

		Default: `'localhost'`.
	**/
	@:optional var host:String;

	/**
		Alias for `host`.
		To support `url.parse()`, hostname will be used if both `host` and `hostname` are specified.
	**/
	@:optional var hostname:String;

	/**
		Local interface to bind for network connections.
	**/
	@:optional var localAddress:String;

	/**
		A string specifying the HTTP request method.

		Default: `'GET'`.
	**/
	@:optional var method:Method;

	/**
		Request path. Should include query string if any. E.G. `'/index.html?page=12'`.
		An exception is thrown when the request path contains illegal characters.
		Currently, only spaces are rejected but that may change in the future.

		Default: `'/'`.
	**/
	@:optional var path:String;

	/**
		Port of remote server.

		Default: `defaultPort` if set, else `80`.
	**/
	@:optional var port:Int;

	/**
		Protocol to use.

		Default: `'http:'`.
	**/
	@:optional var protocol:String;

	/**
		Specifies whether or not to automatically add default headers such as
		`Connection`, `Content-Length`, `Transfer-Encoding`, and `Host`.
		Defaults to `true`.
	**/
	@:optional var setDefaultHeaders:Bool;

	/**
		Specifies whether or not to automatically add the Host header.
		If provided, this overrides `setDefaultHeaders`.
		Defaults to `true`.
	**/
	@:optional var setHost:Bool;

	/**
		Unix Domain Socket (cannot be used if one of host or port is specified, those specify a TCP Socket).
	**/
	@:optional var socketPath:String;

	/**
		A number specifying the socket timeout in milliseconds.
		This will set the timeout before the socket is connected.
	**/
	@:optional var timeout:Int;

	/**
		Local port to bind to for network connections.
	**/
	@:optional var localPort:Int;

	/**
		Optional dns.lookup() hints.
	**/
	@:optional var hints:Int;

	/**
		Custom lookup function. Default: `Dns.lookup`.
	**/
	@:optional var lookup:(hostname:String, options:Null<js.node.Dns.DnsLookupOptions>,
		callback:js.node.Dns.DnsLookupCallbackSingle) -> Void;

	/**
		An AbortSignal that may be used to abort an ongoing request.
	**/
	@:optional var signal:AbortSignal;

	/**
		Headers names which values are treated as arrays of values.
	**/
	@:optional var uniqueHeaders:Array<EitherType<String, Array<String>>>;

	/**
		Join duplicate headers into a comma-separated string for select headers.
	**/
	@:optional var joinDuplicateHeaders:Bool;

	/**
		Optionally overrides the value of `--max-http-header-size` for request parsing.
	**/
	@:optional var maxHeaderSize:Int;

	/**
		If `true`, use an insecure HTTP parser that accepts invalid HTTP headers.
	**/
	@:optional var insecureHTTPParser:Bool;
}
