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

import haxe.Constraints.Function;
import haxe.extern.EitherType;

/**
	A browser-compatible implementation of the `EventTarget` class.

	@see https://nodejs.org/api/events.html#class-eventtarget
	@see https://nodejs.org/api/globals.html#class-eventtarget
**/
@:native("EventTarget")
extern class EventTarget {
	function new():Void;

	/**
		Adds a new handler for the `type` event.
		Any given `listener` is added only once per `type` and per `capture` option value.
	**/
	@:overload(function(type:String, listener:EventListener, ?options:EitherType<AddEventListenerOptions, Bool>):Void {})
	function addEventListener(type:String, listener:Function, ?options:EitherType<AddEventListenerOptions, Bool>):Void;

	/**
		Removes the `listener` from the list of handlers for event `type`.
	**/
	@:overload(function(type:String, listener:EventListener, ?options:EitherType<EventListenerOptions, Bool>):Void {})
	function removeEventListener(type:String, listener:Function, ?options:EitherType<EventListenerOptions, Bool>):Void;

	/**
		Dispatches the `event` to the list of handlers for `event.type`.

		@return `true` if either event's `cancelable` attribute value is false
			or its `preventDefault()` method was not invoked, otherwise `false`.
	**/
	function dispatchEvent(event:Event):Bool;
}

/**
	An object with a `handleEvent` method, usable as an event listener.
**/
typedef EventListener = {
	function handleEvent(event:Event):Void;
}

/**
	Options for `EventTarget.removeEventListener`.
**/
typedef EventListenerOptions = {
	/**
		Not directly used by Node.js except as part of the listener registration key.
		Default: `false`.
	**/
	@:optional var capture:Bool;
}

/**
	Options for `EventTarget.addEventListener`.
**/
typedef AddEventListenerOptions = {
	/**
		Not directly used by Node.js except as part of the listener registration key.
		Default: `false`.
	**/
	@:optional var capture:Bool;

	/**
		When `true`, the listener is automatically removed when it is first invoked.
		Default: `false`.
	**/
	@:optional var once:Bool;

	/**
		When `true`, serves as a hint that the listener will not call `preventDefault()`.
		Default: `false`.
	**/
	@:optional var passive:Bool;

	/**
		The listener will be removed when the given `AbortSignal` object's `abort()` method is called.
	**/
	@:optional var signal:AbortSignal;
}
