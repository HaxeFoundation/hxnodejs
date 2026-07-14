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
	A browser-compatible implementation of the `Event` class.

	@see https://nodejs.org/api/events.html#class-event
	@see https://nodejs.org/api/globals.html#class-event
**/
@:native("Event")
extern class Event {
	static inline var NONE:Int = 0;
	static inline var CAPTURING_PHASE:Int = 1;
	static inline var AT_TARGET:Int = 2;
	static inline var BUBBLING_PHASE:Int = 3;

	/**
		The event type identifier.
	**/
	var type(default, null):String;

	/**
		The `EventTarget` dispatching the event.
	**/
	var target(default, null):EventTarget;

	/**
		Alias for `target`.
	**/
	var currentTarget(default, null):EventTarget;

	/**
		Returns `0` while an event is not being dispatched, `2` while it is being dispatched.
		This is not used in Node.js and is provided purely for completeness.
	**/
	var eventPhase(default, null):Int;

	/**
		Always returns `false` in Node.js. Provided purely for completeness.
	**/
	var bubbles(default, null):Bool;

	/**
		True if the event was created with the `cancelable` option.
	**/
	var cancelable(default, null):Bool;

	/**
		True if the event has not been canceled.

		Stability: 3 - Legacy.
	**/
	@:deprecated("Use defaultPrevented instead")
	var returnValue:Bool;

	/**
		Is `true` if `cancelable` is `true` and `preventDefault()` has been called.
	**/
	var defaultPrevented(default, null):Bool;

	/**
		Always returns `false` in Node.js. Provided purely for completeness.
	**/
	var composed(default, null):Bool;

	/**
		The `"abort"` event is emitted with `isTrusted` set to `true`.
		The value is `false` in all other cases.
	**/
	var isTrusted(default, null):Bool;

	/**
		The millisecond timestamp when the `Event` object was created.
	**/
	var timeStamp(default, null):Float;

	/**
		Alias for `stopPropagation()` if set to `true`.

		Stability: 3 - Legacy.
	**/
	@:deprecated("Use stopPropagation() instead")
	var cancelBubble:Bool;

	/**
		Alias for `target`.

		Stability: 3 - Legacy.
	**/
	@:deprecated("Use target instead")
	var srcElement(default, null):EventTarget;

	function new(type:String, ?eventInitDict:EventInit):Void;

	/**
		Returns an array containing the current `EventTarget` as the only entry,
		or empty if the event is not being dispatched.
		This is not used in Node.js and is provided purely for completeness.
	**/
	function composedPath():Array<EventTarget>;

	/**
		Sets the `defaultPrevented` property to `true` if `cancelable` is `true`.
	**/
	function preventDefault():Void;

	/**
		Stops the invocation of event listeners after the current one completes.
	**/
	function stopImmediatePropagation():Void;

	/**
		This is not used in Node.js and is provided purely for completeness.
	**/
	function stopPropagation():Void;

	/**
		Redundant with event constructors and incapable of setting `composed`.

		Stability: 3 - Legacy. The WHATWG spec considers it deprecated.
	**/
	@:deprecated("Use the Event constructor instead")
	function initEvent(type:String, ?bubbles:Bool, ?cancelable:Bool):Void;
}

/**
	Options passed to the `Event` constructor.
**/
typedef EventInit = {
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
}
