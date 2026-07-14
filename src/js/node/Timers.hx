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

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;

/**
	The `timers` module exposes a global API for scheduling functions to be called at some future period of time.
	Because the timer functions are globals, there is no need to call `require('node:timers')` to use the API.

	The timer functions within Node.js implement a similar API as the timers API provided by Web Browsers
	but use a different internal implementation that is built around the Node.js Event Loop.

	@see https://nodejs.org/docs/latest-v24.x/api/timers.html
**/
@:jsRequire("timers")
extern class Timers {
	/**
		Schedules the "immediate" execution of the callback after I/O events' callbacks.

		When multiple calls to `setImmediate()` are made, the `callback` functions are queued for execution
		in the order in which they are created. The entire callback queue is processed every event loop iteration.
		If an immediate timer is queued from inside an executing callback, that timer will not be triggered until
		the next event loop iteration.

		If `callback` is not a function, a `TypeError` will be thrown.

		This method has a custom variant for promises that is available using `TimersPromises.setImmediate()`.

		@see https://nodejs.org/docs/latest-v24.x/api/timers.html#setimmediatecallback-args
	**/
	static function setImmediate(callback:Function, args:Rest<Dynamic>):Immediate;

	/**
		Schedules repeated execution of `callback` every `delay` milliseconds.

		When `delay` is larger than `2147483647` or less than `1` or `NaN`, the `delay` will be set to `1`.
		Non-integer delays are truncated to an integer. Default: `1`.

		If `callback` is not a function, a `TypeError` will be thrown.

		This method has a custom variant for promises that is available using `TimersPromises.setInterval()`.

		@see https://nodejs.org/docs/latest-v24.x/api/timers.html#setintervalcallback-delay-args
	**/
	@:overload(function(callback:Function, args:Rest<Dynamic>):Timeout {})
	static function setInterval(callback:Function, delay:Float, args:Rest<Dynamic>):Timeout;

	/**
		Schedules execution of a one-time `callback` after `delay` milliseconds.

		The `callback` will likely not be invoked in precisely `delay` milliseconds.
		Node.js makes no guarantees about the exact timing of when callbacks will fire, nor of their ordering.
		The callback will be called as close as possible to the time specified.

		When `delay` is larger than `2147483647` or less than `1` or `NaN`, the delay will be set to `1`.
		Non-integer delays are truncated to an integer. Default: `1`.

		If `callback` is not a function, a `TypeError` will be thrown.

		This method has a custom variant for promises that is available using `TimersPromises.setTimeout()`.

		@see https://nodejs.org/docs/latest-v24.x/api/timers.html#settimeoutcallback-delay-args
	**/
	@:overload(function(callback:Function, args:Rest<Dynamic>):Timeout {})
	static function setTimeout(callback:Function, delay:Float, args:Rest<Dynamic>):Timeout;

	/**
		Cancels an `Immediate` object created by `setImmediate()`.

		@see https://nodejs.org/docs/latest-v24.x/api/timers.html#clearimmediateimmediate
	**/
	static function clearImmediate(immediate:Immediate):Void;

	/**
		Cancels a `Timeout` object created by `setInterval()`, or the primitive returned by `timeout[Symbol.toPrimitive]()`.

		@see https://nodejs.org/docs/latest-v24.x/api/timers.html#clearintervaltimeout
	**/
	static function clearInterval(timeout:EitherType<Timeout, EitherType<Float, String>>):Void;

	/**
		Cancels a `Timeout` object created by `setTimeout()`, or the primitive returned by `timeout[Symbol.toPrimitive]()`.

		@see https://nodejs.org/docs/latest-v24.x/api/timers.html#cleartimeouttimeout
	**/
	static function clearTimeout(timeout:EitherType<Timeout, EitherType<Float, String>>):Void;

	/**
		Promise-based timer APIs (`timers/promises`).

		@see https://nodejs.org/docs/latest-v24.x/api/timers.html#timers-promises-api
	**/
	static final promises:TimersPromises;
}

/**
	This object is created internally and is returned from `setImmediate()`.
	It can be passed to `clearImmediate()` in order to cancel the scheduled actions.

	@see https://nodejs.org/docs/latest-v24.x/api/timers.html#class-immediate
**/
extern class Immediate {
	/**
		If true, the `Immediate` object will keep the Node.js event loop active.
	**/
	function hasRef():Bool;

	/**
		When called, requests that the Node.js event loop not exit so long as the `Immediate` is active.
		Calling `immediate.ref()` multiple times will have no effect.

		By default, all `Immediate` objects are "ref'ed", making it normally unnecessary to call `immediate.ref()`
		unless `immediate.unref()` had been called previously.
	**/
	function ref():Immediate;

	/**
		When called, the active `Immediate` object will not require the Node.js event loop to remain active.
		If there is no other activity keeping the event loop running, the process may exit before the `Immediate` object's
		callback is invoked. Calling `immediate.unref()` multiple times will have no effect.
	**/
	function unref():Immediate;

	/**
		Cancels the immediate. This is similar to calling `clearImmediate()`.

		Maps to `[Symbol.dispose]()` (stable as of Node.js v24.2.0).
	**/
	@:native("@@dispose")
	function dispose():Void;
}

/**
	This object is created internally and is returned from `setTimeout()` and `setInterval()`.
	It can be passed to either `clearTimeout()` or `clearInterval()` in order to cancel the scheduled actions.

	@see https://nodejs.org/docs/latest-v24.x/api/timers.html#class-timeout
**/
extern class Timeout {
	/**
		If true, the `Timeout` object will keep the Node.js event loop active.
	**/
	function hasRef():Bool;

	/**
		When called, requests that the Node.js event loop not exit so long as the `Timeout` is active.
		Calling `timeout.ref()` multiple times will have no effect.

		By default, all `Timeout` objects are "ref'ed", making it normally unnecessary to call `timeout.ref()`
		unless `timeout.unref()` had been called previously.
	**/
	function ref():Timeout;

	/**
		Sets the timer's start time to the current time, and reschedules the timer to call its callback at the previously
		specified duration adjusted to the current time. This is useful for refreshing a timer without allocating
		a new JavaScript object.

		Using this on a timer that has already called its callback will reactivate the timer.
	**/
	function refresh():Timeout;

	/**
		When called, the active `Timeout` object will not require the Node.js event loop to remain active.
		If there is no other activity keeping the event loop running, the process may exit before the `Timeout` object's
		callback is invoked. Calling `timeout.unref()` multiple times will have no effect.

		Calling `timeout.unref()` creates an internal timer that will wake the Node.js event loop.
		Creating too many of these can adversely impact performance of the Node.js application.
	**/
	function unref():Timeout;

	/**
		Cancels the timeout.

		Stability: 3 - Legacy: Use `clearTimeout()` instead.
	**/
	function close():Timeout;

	/**
		Coerce a `Timeout` to a primitive number that can be used with `clearTimeout` / `clearInterval`.

		Maps to `[Symbol.toPrimitive]()`.
	**/
	@:native("@@toPrimitive")
	function toPrimitive():Float;

	/**
		Cancels the timeout. This is similar to calling `clearTimeout()`.

		Maps to `[Symbol.dispose]()` (stable as of Node.js v24.2.0).
	**/
	@:native("@@dispose")
	function dispose():Void;
}
