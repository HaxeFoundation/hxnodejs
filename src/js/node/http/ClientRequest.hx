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

package js.node.http;

import haxe.DynamicAccess;
import js.node.Buffer;
import js.node.events.EventEmitter.Event;
import js.node.net.Socket;
import js.node.stream.Writable;

/**
	Enumeration of events emitted by `ClientRequest`
**/
enum abstract ClientRequestEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when the request has been aborted by the client.
		This event is only emitted on the first call to `abort()`.

		Deprecated since Node.js v17.0.0. Listen for `'close'` instead.
	**/
	@:deprecated("Listen for ClientRequestEvent.Close / 'close' instead")
	var Abort:ClientRequestEvent<Void->Void> = "abort";

	/**
		Emitted when the request has been closed / completed.
	**/
	var Close:ClientRequestEvent<Void->Void> = "close";

	/**
		Emitted when the request has been sent / finished writing.
	**/
	var Finish:ClientRequestEvent<Void->Void> = "finish";

	/**
		Emitted each time a server responds to a request with a `CONNECT` method.
		If this event is not being listened for, clients receiving a `CONNECT` method will have their connections closed.
	**/
	var Connect:ClientRequestEvent<(response:IncomingMessage, socket:Socket, head:Buffer) -> Void> = "connect";

	/**
		Emitted when the server sends a '100 Continue' HTTP response,
		usually because the request contained 'Expect: 100-continue'.
		This is an instruction that the client should send the request body.
	**/
	var Continue:ClientRequestEvent<Void->Void> = "continue";

	/**
		Emitted when the server sends a 1xx intermediate response (excluding 101 Upgrade).
		The listeners of this event will receive an object containing the HTTP version, status code, status message,
		key-value headers object, and array with the raw header names followed by their respective values.
	**/
	var Information:ClientRequestEvent<InformationEventData->Void> = "information";

	/**
		Emitted when a response is received to this request. This event is emitted only once.
	**/
	var Response:ClientRequestEvent<IncomingMessage->Void> = "response";

	/**
		Emitted after a socket is assigned to this request.
	**/
	var Socket:ClientRequestEvent<Socket->Void> = "socket";

	/**
		Emitted when the underlying socket times out from inactivity.
		This only notifies that the socket has been idle. The request must be destroyed manually.

		See also: [request.setTimeout()](https://nodejs.org/docs/latest-v24.x/api/http.html#requestsettimeouttimeout-callback).
	**/
	var Timeout:ClientRequestEvent<Socket->Void> = "timeout";

	/**
		Emitted each time a server responds to a request with an upgrade.
		If this event is not being listened for and the response status code is 101 Switching Protocols,
		clients receiving an upgrade header will have their connections closed.
	**/
	var Upgrade:ClientRequestEvent<(response:IncomingMessage, socket:Socket, head:Buffer) -> Void> = "upgrade";
}

/**
	This object is created internally and returned from `http.request()`.
	It represents an in-progress request whose header has already been queued.
	The header is still mutable using the `setHeader(name, value)`, `getHeader(name)`, `removeHeader(name)` API.
	The actual header will be sent along with the first data chunk or when calling `request.end()`.

	To get the response, add a listener for `'response'` to the request object.
	`'response'` will be emitted from the request object when the response headers have been received.
	The `'response'` event is executed with one argument which is an instance of `http.IncomingMessage`.

	During the `'response'` event, one can add listeners to the response object; particularly to listen for the `'data'` event.

	If no `'response'` handler is added, then the response will be entirely discarded. However,
	if a `'response'` event handler is added, then the data from the response object *must* be consumed,
	either by calling `response.read()` whenever there is a `'readable'` event, or by adding a `'data'` handler,
	or by calling the `.resume()` method. Until the data is consumed, the `'end'` event will not fire.
	Also, until the data is read it will consume memory that can eventually lead to a 'process out of memory' error.

	Unlike the `request` object, if the response closes prematurely, the response object does not emit an `'error'` event
	but instead emits the `'aborted'` event.

	Node.js does not check whether Content-Length and the length of the body which has been transmitted are equal or not.

	@see https://nodejs.org/docs/latest-v24.x/api/http.html#class-httpclientrequest
**/
@:jsRequire("http", "ClientRequest")
extern class ClientRequest extends Writable<ClientRequest> {
	/**
		Marks the request as aborting. Calling this will cause remaining data in the response to be dropped and the socket to be destroyed.

		Deprecated since Node.js v14.1.0 / v13.14.0. Use `destroy()` instead.
	**/
	@:deprecated("Use destroy() instead")
	function abort():Void;

	/**
		The `request.aborted` property will be `true` if the request has been aborted.

		Deprecated since Node.js v17.0.0. Check `destroyed` instead.
	**/
	@:deprecated("Use destroyed instead")
	var aborted(default, null):Bool;

	/**
		See `request.socket`.

		Deprecated since Node.js v16.0.0.
	**/
	@:deprecated("Use socket instead")
	var connection(default, null):Socket;

	/**
		The `request.finished` property will be true if `request.end()` has been called.

		Deprecated since Node.js v13.4.0 / v12.16.0. Use `writableEnded` instead.
	**/
	@:deprecated("Use writableEnded instead")
	var finished(default, null):Bool;

	/**
		Flush the request headers.

		For efficiency reasons, node.js normally buffers the request headers until you call `request.end()`
		or write the first chunk of request data. It then tries hard to pack the request headers and data
		into a single TCP packet.

		That's usually what you want (it saves a TCP round-trip) but not when the first data isn't sent
		until possibly much later. `flushHeaders` lets you bypass the optimization and kickstart the request.
	**/
	function flushHeaders():Void;

	/**
		Reads out a header on the request. The name is case-insensitive.
		The type of the return value depends on the arguments provided to `request.setHeader()`.
	**/
	function getHeader(name:String):haxe.extern.EitherType<String, Array<String>>;

	/**
		Returns an array containing the unique names of the current outgoing headers.
	**/
	function getHeaderNames():Array<String>;

	/**
		Returns a shallow copy of the current outgoing headers.
	**/
	function getHeaders():DynamicAccess<haxe.extern.EitherType<String, Array<String>>>;

	/**
		Returns an array containing the unique names of the current outgoing raw headers.
		Header names are returned with their exact casing.
	**/
	function getRawHeaderNames():Array<String>;

	/**
		Returns `true` if the header identified by `name` is currently set in the outgoing headers.
	**/
	function hasHeader(name:String):Bool;

	/**
		Limits maximum response headers count. If set to 0, no limit will be applied.

		Default: `2000`
	**/
	var maxHeadersCount:Null<Int>;

	/**
		The request path.
	**/
	var path:String;

	/**
		The HTTP request method.
	**/
	var method:Method;

	/**
		The request host header value.
	**/
	var host(default, null):String;

	/**
		The request protocol (`http:` / `https:`).
	**/
	var protocol(default, null):String;

	/**
		Whether the request reused an existing socket.
	**/
	var reusedSocket(default, null):Bool;

	/**
		Removes a header that's already defined into headers object.
	**/
	function removeHeader(name:String):Void;

	/**
		Sets a single header value for headers object.
		If this header already exists in the to-be-sent headers, its value will be replaced.
		Use an array of strings here to send multiple headers with the same name.
		Non-string values will be stored without modification. Therefore, `request.getHeader()` may return non-string values.
		However, the non-string values will be converted to strings for network transmission.
	**/
	@:overload(function(name:String, value:Array<String>):Void {})
	function setHeader(name:String, value:String):Void;

	/**
		Append a single header value for the header object.

		@see https://nodejs.org/api/http.html#outgoingmessageappendheadername-value
	**/
	@:overload(function(name:String, value:Array<String>):ClientRequest {})
	function appendHeader(name:String, value:String):ClientRequest;

	/**
		Sets multiple header values for implicit headers.

		@see https://nodejs.org/api/http.html#outgoingmessagesetheadersheaders
	**/
	@:overload(function(headers:DynamicAccess<haxe.extern.EitherType<String, Array<String>>>):Void {})
	function setHeaders(headers:js.node.web.Headers):Void;

	/**
		Once a socket is assigned to this request and is connected
		`socket.setNoDelay` will be called.
	**/
	function setNoDelay(?noDelay:Bool):Void;

	/**
		Once a socket is assigned to this request and is connected
		`socket.setKeepAlive`() will be called.
	**/
	@:overload(function(?initialDelay:Int):Void {})
	function setSocketKeepAlive(enable:Bool, ?initialDelay:Int):Void;

	/**
		Once a socket is assigned to this request and is connected `socket.setTimeout()` will be called.
	**/
	function setTimeout(timeout:Int, ?callback:Socket->Void):ClientRequest;

	/**
		Clears the timeout set by `request.setTimeout()`.
	**/
	function clearTimeout():Void;

	/**
		Reference to the underlying socket. Usually users will not want to access this property.
		In particular, the socket will not emit `'readable'` events because of how the protocol parser attaches to the socket.
		The `socket` may also be accessed via `request.connection`.
	**/
	var socket(default, null):Socket;

	// This field is defined in super class.
	// var writableEnded(default, null):Bool;
	// var writableFinished(default, null):Bool;
}

typedef InformationEventData = {
	var httpVersion:String;
	var httpVersionMajor:Int;
	var httpVersionMinor:Int;
	var statusCode:Int;
	var statusMessage:String;
	var headers:DynamicAccess<String>;
	var rawHeaders:Array<String>;
}
