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

package js.node;

import js.lib.Promise;
import js.node.web.AbortSignal;

/**
	The `timers/promises` API provides an alternative set of timer functions that return `Promise` objects.

	Accessible via `require('node:timers/promises')` or `require('node:timers').promises`.

	@see https://nodejs.org/docs/latest-v24.x/api/timers.html#timers-promises-api
**/
@:jsRequire("timers/promises")
extern class TimersPromises {
	/**
		Returns a Promise that is fulfilled with `value` after `delay` milliseconds.
		Default `delay`: `1`.

		@see https://nodejs.org/docs/latest-v24.x/api/timers.html#timerspromisessettimeoutdelay-value-options
	**/
	@:overload(function():Promise<Dynamic> {})
	@:overload(function(delay:Float):Promise<Dynamic> {})
	@:overload(function<T>(delay:Float, value:T):Promise<T> {})
	static function setTimeout<T>(delay:Float, value:T, ?options:TimersPromisesOptions):Promise<T>;

	/**
		Returns a Promise that is fulfilled with `value` in the next iteration of the event loop
		(after I/O events' callbacks).

		@see https://nodejs.org/docs/latest-v24.x/api/timers.html#timerspromisessetimmediatevalue-options
	**/
	@:overload(function():Promise<Dynamic> {})
	@:overload(function<T>(value:T):Promise<T> {})
	static function setImmediate<T>(value:T, ?options:TimersPromisesOptions):Promise<T>;

	/**
		Returns an async iterator that generates values in an interval of `delay` ms.
		Default `delay`: `1`.

		@see https://nodejs.org/docs/latest-v24.x/api/timers.html#timerspromisessetintervaldelay-value-options
	**/
	@:overload(function():TimersPromisesAsyncIterator<Dynamic> {})
	@:overload(function(delay:Float):TimersPromisesAsyncIterator<Dynamic> {})
	@:overload(function<T>(delay:Float, value:T):TimersPromisesAsyncIterator<T> {})
	static function setInterval<T>(delay:Float, value:T, ?options:TimersPromisesOptions):TimersPromisesAsyncIterator<T>;

	/**
		Experimental Scheduling APIs draft helpers (`scheduler.wait` / `scheduler.yield`).

		Stability: 1 - Experimental.

		@see https://nodejs.org/docs/latest-v24.x/api/timers.html#timerspromisesschedulerwaitdelay-options
	**/
	static final scheduler:TimersPromisesScheduler;
}

/**
	Options shared by `TimersPromises` scheduling methods.
**/
typedef TimersPromisesOptions = {
	/**
		Set to `false` so the scheduled timer does not require the event loop to remain active.
		Default: `true`.
	**/
	@:optional var ref:Bool;

	/**
		An optional `AbortSignal` that can be used to cancel the scheduled timer.
	**/
	@:optional var signal:AbortSignal;
}

/**
	Minimal async iterator surface used by `setInterval` (for `for await...of`).
**/
typedef TimersPromisesAsyncIterator<T> = {
	function next():Promise<{done:Bool, ?value:T}>;
}

/**
	Experimental `scheduler` helpers from `timers/promises`.

	Stability: 1 - Experimental.
**/
typedef TimersPromisesScheduler = {
	/**
		Wait `delay` milliseconds before resolving.
		Equivalent to `setTimeout(delay, undefined, options)`.
	**/
	function wait(delay:Float, ?options:TimersPromisesOptions):Promise<Void>;

	/**
		Yield to the event loop.
		Equivalent to `setImmediate()` with no arguments.
	**/
	function yield():Promise<Void>;
}
