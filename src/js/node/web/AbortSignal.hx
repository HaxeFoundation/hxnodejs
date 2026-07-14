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
	Used to notify observers when `AbortController.abort()` is called.

	Extends `js.node.web.EventTarget`. Prefer these Node web externs over the
	incomplete Haxe standard library `js.html.AbortSignal`.

	@see https://nodejs.org/api/globals.html#class-abortsignal
**/
@:native("AbortSignal")
extern class AbortSignal extends EventTarget {
	/**
		Returns a new already aborted `AbortSignal`.
	**/
	static function abort(?reason:Any):AbortSignal;

	/**
		Returns a new `AbortSignal` which will be aborted in `delay` milliseconds.
	**/
	static function timeout(delay:Float):AbortSignal;

	/**
		Returns a new `AbortSignal` which will be aborted if any of the provided
		signals are aborted. Its `reason` will be set to whichever signal caused the abort.
	**/
	static function any(signals:Array<AbortSignal>):AbortSignal;

	/**
		True after the associated `AbortController` has been aborted.
	**/
	var aborted(default, null):Bool;

	/**
		An optional reason specified when the `AbortSignal` was triggered.
	**/
	var reason(default, null):Any;

	/**
		An optional callback function that may be set by user code to be notified
		when `AbortController.abort()` has been called.
	**/
	var onabort:Null<Event->Void>;

	/**
		If `aborted` is `true`, throws `reason`.
	**/
	function throwIfAborted():Void;
}
