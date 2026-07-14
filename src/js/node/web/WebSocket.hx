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

package js.node.web;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.lib.ArrayBuffer;
import js.lib.ArrayBufferView;
import js.node.url.URL;

/**
	A browser-compatible `WebSocket` implementation (undici).

	Stable since Node.js v22.4.0. Disable with `--no-experimental-websocket`.

	@see https://nodejs.org/api/globals.html#class-websocket
**/
@:native("WebSocket")
extern class WebSocket extends EventTarget {
	static inline var CONNECTING:Int = 0;
	static inline var OPEN:Int = 1;
	static inline var CLOSING:Int = 2;
	static inline var CLOSED:Int = 3;

	var binaryType:String;
	var bufferedAmount(default, null):Int;
	var extensions(default, null):String;
	var protocol(default, null):String;
	var readyState(default, null):Int;
	var url(default, null):String;

	var onopen:Null<Event->Void>;
	var onerror:Null<Event->Void>;
	var onclose:Null<CloseEvent->Void>;
	var onmessage:Null<MessageEvent->Void>;

	@:overload(function(url:URL, ?protocols:EitherType<String, Array<String>>):Void {})
	@:overload(function(url:String, ?options:WebSocketInit):Void {})
	@:overload(function(url:URL, ?options:WebSocketInit):Void {})
	function new(url:String, ?protocols:EitherType<String, Array<String>>):Void;

	function close(?code:Int, ?reason:String):Void;

	@:overload(function(data:ArrayBuffer):Void {})
	@:overload(function(data:ArrayBufferView):Void {})
	@:overload(function(data:Blob):Void {})
	function send(data:String):Void;
}

/**
	Undici / Node `WebSocket` constructor options (headers, protocols, etc.).
**/
typedef WebSocketInit = {
	@:optional var protocols:EitherType<String, Array<String>>;
	@:optional var headers:EitherType<Headers, EitherType<Array<Array<String>>, DynamicAccess<String>>>;
	/**
		Undici-specific custom dispatcher. Left as `Any` until an undici `Dispatcher` extern exists.
	**/
	@:optional var dispatcher:Any;
}
