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
import haxe.extern.EitherType;
import js.node.net.Socket;
import js.node.stream.Writable;
import js.node.web.Headers;

/**
	This class serves as the parent class of `http.ClientRequest` and `http.ServerResponse`.
	It is an abstract outgoing message from the perspective of the participants of an HTTP transaction.

	@see https://nodejs.org/docs/latest-v24.x/api/http.html#class-httpoutgoingmessage
**/
@:jsRequire("http", "OutgoingMessage")
extern class OutgoingMessage extends Writable<OutgoingMessage> {
	/**
		Adds HTTP trailers (headers at the end of the message) to the message.

		Trailers will only be emitted if the message is chunked encoded.
	**/
	@:overload(function(headers:Array<Array<String>>):Void {})
	function addTrailers(headers:DynamicAccess<String>):Void;

	/**
		Append a single header value for the header object.

		If the value is an array, this is equivalent to calling this method multiple times.
	**/
	@:overload(function(name:String, value:Array<String>):OutgoingMessage {})
	function appendHeader(name:String, value:String):OutgoingMessage;

	/**
		Flushes the message headers.
	**/
	function flushHeaders():Void;

	/**
		Reads out a header that's already been queued but not sent.
		The name is case-insensitive.
	**/
	function getHeader(name:String):EitherType<String, Array<String>>;

	/**
		Returns an array containing the unique names of the current outgoing headers.
		All header names are lowercase.
	**/
	function getHeaderNames():Array<String>;

	/**
		Returns a shallow copy of the current outgoing headers.
	**/
	function getHeaders():DynamicAccess<EitherType<String, Array<String>>>;

	/**
		Returns an array containing the unique names of the current outgoing raw headers.
		Header names are returned with their exact casing being set.
	**/
	function getRawHeaderNames():Array<String>;

	/**
		Returns `true` if the header identified by `name` is currently set in the outgoing headers.
	**/
	function hasHeader(name:String):Bool;

	/**
		Boolean (read-only). `true` if headers were sent, otherwise `false`.
	**/
	var headersSent(default, null):Bool;

	/**
		Removes a header that's queued for implicit sending.
	**/
	function removeHeader(name:String):Void;

	/**
		Sets a single header value. If the header already exists in the to-be-sent headers, its value will be replaced.
	**/
	@:overload(function(name:String, value:Array<String>):Void {})
	function setHeader(name:String, value:String):Void;

	/**
		Sets multiple header values for implicit headers.

		`headers` must be an instance of `Headers` or a key/value map-like object.
	**/
	@:overload(function(headers:DynamicAccess<EitherType<String, Array<String>>>):Void {})
	function setHeaders(headers:Headers):Void;

	/**
		Once a socket is associated with the message and is connected,
		`socket.setTimeout()` will be called with `msecs` as the first parameter.
	**/
	function setTimeout(msecs:Int, ?callback:Void->Void):OutgoingMessage;

	/**
		Reference to the underlying socket.
	**/
	var socket(default, null):Socket;

	/**
		Alias of `socket`.

		Deprecated since Node.js v16.0.0.
	**/
	@:deprecated("Use socket instead")
	var connection(default, null):Socket;
}
