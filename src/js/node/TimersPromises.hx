/*
 * Copyright (C)2014-2020 Haxe Foundation
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

import js.node.web.AbortSignal;
#if haxe4
import js.lib.Promise;
#else
import js.Promise;
#end

/**
	The `timers/promises` API provides an alternative set of timer functions that return `Promise` objects.

	@see https://nodejs.org/api/timers.html#timers-promises-api
**/
@:jsRequire("timers/promises")
extern class TimersPromises {
	/**
		Returns a Promise that is fulfilled with `value` after `delay` milliseconds.
	**/
	@:overload(function():Promise<Dynamic> {})
	@:overload(function(delay:Int):Promise<Dynamic> {})
	@:overload(function<T>(delay:Int, value:T):Promise<T> {})
	static function setTimeout<T>(delay:Int, value:T, options:TimersPromisesOptions):Promise<T>;

	/**
		Returns a Promise that is fulfilled with `value` in the next iteration of the event loop
		(after I/O events' callbacks).
	**/
	@:overload(function():Promise<Dynamic> {})
	@:overload(function<T>(value:T):Promise<T> {})
	static function setImmediate<T>(value:T, options:TimersPromisesOptions):Promise<T>;

	/**
		Returns an async iterator that generates values in an interval of `delay` ms.
	**/
	@:overload(function():TimersPromisesAsyncIterator<Dynamic> {})
	@:overload(function(delay:Int):TimersPromisesAsyncIterator<Dynamic> {})
	@:overload(function<T>(delay:Int, value:T):TimersPromisesAsyncIterator<T> {})
	static function setInterval<T>(delay:Int, value:T, options:TimersPromisesOptions):TimersPromisesAsyncIterator<T>;

	/**
		Experimental Scheduling APIs draft helpers (`scheduler.wait` / `scheduler.yield`).
	**/
	static var scheduler(default, null):TimersPromisesScheduler;
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
**/
typedef TimersPromisesScheduler = {
	/**
		Wait `delay` milliseconds before resolving.
		Equivalent to `setTimeout(delay, undefined, options)`.
	**/
	function wait(delay:Int, ?options:TimersPromisesOptions):Promise<Void>;

	/**
		Yield to the event loop.
		Equivalent to `setImmediate()` with no arguments.
	**/
	function yield():Promise<Void>;
}
