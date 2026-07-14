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

package js.node.http2;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.Buffer;
import js.node.Http2.Http2Headers;
import js.node.events.EventEmitter.Event;
import js.node.net.Socket;
import js.node.stream.Writable;
import js.lib.Error;

/**
	Events emitted by `Http2ServerResponse` in addition to its parent class events.
**/
enum abstract Http2ServerResponseEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Indicates that the underlying `Http2Stream` was terminated before `response.end()` was called or able to flush.
	**/
	var Close:Http2ServerResponseEvent<() -> Void> = "close";

	/**
		Emitted when the response has been sent.
	**/
	var Finish:Http2ServerResponseEvent<() -> Void> = "finish";
}

/**
	This object is created internally by an HTTP server — not by the user.
	It is passed as the second parameter to the `'request'` event.

	@see https://nodejs.org/api/http2.html#class-http2http2serverresponse
**/
@:jsRequire("http2", "Http2ServerResponse")
extern class Http2ServerResponse extends Writable<Http2ServerResponse> {
	/**
		This method adds HTTP trailing headers to the response.
	**/
	function addTrailers(headers:Http2Headers):Void;

	/**
		Append a single header value to the header object.
	**/
	@:overload(function(name:String, value:Array<String>):Void {})
	function appendHeader(name:String, value:String):Void;

	/**
		Flushes the response headers to the client.
	**/
	function flushHeaders():Void;

	/**
		See `response.socket`.
	**/
	@:deprecated("Use response.socket instead")
	var connection(default, null):Socket;

	/**
		Call `http2stream.pushStream()` with the given headers, and wrap the given `Http2Stream`
		on a newly created `Http2ServerResponse` as the callback parameter if successful.
	**/
	function createPushResponse(headers:Http2Headers, callback:(err:Null<Error>, res:Http2ServerResponse) -> Void):Void;

	/**
		Boolean value that indicates whether the response has completed.
	**/
	@:deprecated("Use response.writableEnded instead")
	var finished(default, null):Bool;

	/**
		Reads out a header that has already been queued but not sent to the client.
	**/
	function getHeader(name:String):EitherType<String, Array<String>>;

	/**
		Returns an array containing the unique names of the current outgoing headers.
	**/
	function getHeaderNames():Array<String>;

	/**
		Returns a shallow copy of the current outgoing headers.
	**/
	function getHeaders():DynamicAccess<EitherType<String, Array<String>>>;

	/**
		Returns `true` if the header identified by `name` is currently set in the outgoing headers.
	**/
	function hasHeader(name:String):Bool;

	/**
		True if headers were sent, false otherwise (read-only).
	**/
	var headersSent(default, null):Bool;

	/**
		Removes a header that has been queued for implicit sending.
	**/
	function removeHeader(name:String):Void;

	/**
		A reference to the original HTTP2 `request` object.
	**/
	var req(default, null):Http2ServerRequest;

	/**
		When true, the Date header will be automatically generated and sent in the response if it is not already present.
	**/
	var sendDate:Bool;

	/**
		Sets a single header value for implicit headers.
	**/
	@:overload(function(name:String, value:Array<String>):Void {})
	function setHeader(name:String, value:String):Void;

	/**
		Sets a single trailing header value.
		Must be called before the trailers are flushed.
	**/
	@:overload(function(name:String, value:Array<String>):Void {})
	function setTrailer(name:String, value:String):Void;

	/**
		Sets the `Http2Stream`'s timeout value to `msecs`.
	**/
	function setTimeout(msecs:Int, ?callback:() -> Void):Http2ServerResponse;

	/**
		Returns a `Proxy` object that acts as a `net.Socket` (or `tls.TLSSocket`)
		but applies getters, setters, and methods based on HTTP/2 logic.
	**/
	var socket(default, null):Socket;

	/**
		When using implicit headers, this property controls the status code that will be sent to the client.
	**/
	var statusCode:Int;

	/**
		Status message is not supported by HTTP/2. It returns an empty string.
	**/
	var statusMessage:String;

	/**
		The `Http2Stream` object backing the response.
	**/
	var stream(default, null):ServerHttp2Stream;

	/**
		Sends a status `100 Continue` to the client.
	**/
	function writeContinue():Void;

	/**
		Sends a status `103 Early Hints` to the client with a Link header.
	**/
	function writeEarlyHints(hints:DynamicAccess<EitherType<String, Array<String>>>):Void;

	/**
		Sends an arbitrary HTTP 1xx informational response.
		After final response headers are sent this is a no-op and returns `false`.
		Added in Node.js v24.18.0 (Active LTS); not available on Maintenance LTS 22.x.
	**/
	function writeInformation(statusCode:Int, ?headers:Http2Headers):Bool;

	/**
		Sends a response header to the request. Returns `this` for chaining with `end()`.
	**/
	@:overload(function(statusCode:Int, ?headers:Http2Headers):Http2ServerResponse {})
	@:overload(function(statusCode:Int, statusMessage:String, ?headers:Http2Headers):Http2ServerResponse {})
	function writeHead(statusCode:Int, ?headers:DynamicAccess<EitherType<String, Array<String>>>):Http2ServerResponse;
}
