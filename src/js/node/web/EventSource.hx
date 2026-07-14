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

import js.node.url.URL;

/**
	A browser-compatible `EventSource` (Server-Sent Events) implementation.

	Stability: 1 - Experimental. Enable with the `--experimental-eventsource` CLI flag.

	@see https://nodejs.org/api/globals.html#class-eventsource
**/
@:native("EventSource")
extern class EventSource extends EventTarget {
	static inline var CONNECTING:Int = 0;
	static inline var OPEN:Int = 1;
	static inline var CLOSED:Int = 2;

	var readyState(default, null):Int;
	var url(default, null):String;
	var withCredentials(default, null):Bool;

	var onopen:Null<Event->Void>;
	var onmessage:Null<MessageEvent->Void>;
	var onerror:Null<Event->Void>;

	@:overload(function(url:URL, ?eventSourceInitDict:EventSourceInit):Void {})
	function new(url:String, ?eventSourceInitDict:EventSourceInit):Void;

	function close():Void;
}

/**
	Options for the `EventSource` constructor.
**/
typedef EventSourceInit = {
	@:optional var withCredentials:Bool;
	/**
		Undici-specific custom dispatcher. Left as `Any` until an undici `Dispatcher` extern exists.
	**/
	@:optional var dispatcher:Any;
}
