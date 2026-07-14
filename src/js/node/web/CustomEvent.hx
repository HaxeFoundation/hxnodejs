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
	A browser-compatible implementation of `CustomEvent`.

	@see https://nodejs.org/api/events.html#class-customevent
	@see https://nodejs.org/api/globals.html#class-customevent
**/
@:native("CustomEvent")
extern class CustomEvent extends Event {
	/**
		Custom data passed when initializing the event.
	**/
	var detail(default, null):Any;

	function new(type:String, ?eventInitDict:CustomEventInit):Void;
}

/**
	Options passed to the `CustomEvent` constructor.
**/
typedef CustomEventInit = {
	/**
		Not used in Node.js. Default: `false`.
	**/
	@:optional var bubbles:Bool;

	/**
		When `true`, `preventDefault()` can cancel the event. Default: `false`.
	**/
	@:optional var cancelable:Bool;

	/**
		Not used in Node.js. Default: `false`.
	**/
	@:optional var composed:Bool;

	/**
		Custom data exposed as `detail`.
	**/
	@:optional var detail:Any;
}
