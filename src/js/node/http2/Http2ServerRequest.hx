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
import js.node.Http2.Http2Headers;
import js.node.events.EventEmitter.Event;
import js.node.net.Socket;
import js.node.stream.Readable;
import js.lib.Error;

/**
	Events emitted by `Http2ServerRequest` in addition to its parent class events.
**/
enum abstract Http2ServerRequestEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted whenever a `Http2ServerRequest` instance is abnormally aborted in mid-communication.
	**/
	var Aborted:Http2ServerRequestEvent<() -> Void> = "aborted";

	/**
		Indicates that the underlying `Http2Stream` was closed.
	**/
	var Close:Http2ServerRequestEvent<() -> Void> = "close";
}

/**
	A `Http2ServerRequest` object is created by `http2.Server` or `http2.SecureServer`
	and passed as the first argument to the `'request'` event.

	@see https://nodejs.org/api/http2.html#class-http2http2serverrequest
**/
@:jsRequire("http2", "Http2ServerRequest")
extern class Http2ServerRequest extends Readable<Http2ServerRequest> {
	/**
		The `request.aborted` property will be `true` if the request has been aborted.
	**/
	var aborted(default, null):Bool;

	/**
		The request authority pseudo header field.
	**/
	var authority(default, null):String;

	/**
		The `request.complete` property will be `true` if the request has been completed, aborted, or destroyed.
	**/
	var complete(default, null):Bool;

	/**
		See `request.socket`.
	**/
	@:deprecated("Use request.socket instead")
	var connection(default, null):Socket;

	/**
		Calls `destroy()` on the `Http2Stream` that received the `Http2ServerRequest`.
	**/
	override function destroy(?error:Error):Http2ServerRequest;

	/**
		The request/response headers object.
	**/
	var headers(default, null):Http2Headers;

	/**
		In case of server request, the HTTP version sent by the client. Returns `'2.0'`.
	**/
	var httpVersion(default, null):String;

	/**
		HTTP Version first integer.
	**/
	var httpVersionMajor(default, null):Int;

	/**
		HTTP Version second integer.
	**/
	var httpVersionMinor(default, null):Int;

	/**
		The request method as a string. Read-only.
	**/
	var method(default, null):String;

	/**
		The raw request/response headers list exactly as they were received.
	**/
	var rawHeaders(default, null):Array<String>;

	/**
		The raw request/response trailer keys and values exactly as they were received.
	**/
	var rawTrailers(default, null):Array<String>;

	/**
		The request scheme pseudo header field.
	**/
	var scheme(default, null):String;

	/**
		Sets the `Http2Stream`'s timeout value to `msecs`.
	**/
	function setTimeout(msecs:Int, ?callback:() -> Void):Http2ServerRequest;

	/**
		Returns a `Proxy` object that acts as a `net.Socket` (or `tls.TLSSocket`)
		but applies getters, setters, and methods based on HTTP/2 logic.
	**/
	var socket(default, null):Socket;

	/**
		The `Http2Stream` object backing the request.
	**/
	var stream(default, null):ServerHttp2Stream;

	/**
		The request/response trailers object. Only populated at the `'end'` event.
	**/
	var trailers(default, null):DynamicAccess<String>;

	/**
		Request URL string. Contains only the URL present in the actual HTTP request.
	**/
	var url:String;
}
