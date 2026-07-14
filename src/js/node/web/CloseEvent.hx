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

/**
	An event that fires when a `WebSocket` connection closes.

	@see https://nodejs.org/api/globals.html#class-closeevent
**/
@:native("CloseEvent")
extern class CloseEvent extends Event {
	/**
		Whether the connection closed cleanly.
	**/
	var wasClean(default, null):Bool;

	/**
		The WebSocket connection close code.
	**/
	var code(default, null):Int;

	/**
		The reason the WebSocket connection closed.
	**/
	var reason(default, null):String;

	function new(type:String, ?eventInitDict:CloseEventInit):Void;
}

/**
	Options for the `CloseEvent` constructor.
**/
typedef CloseEventInit = {
	@:optional var bubbles:Bool;
	@:optional var cancelable:Bool;
	@:optional var composed:Bool;
	@:optional var wasClean:Bool;
	@:optional var code:Int;
	@:optional var reason:String;
}
