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

package js.node.test;

import haxe.extern.EitherType;
#if haxe4
import js.lib.Date as JsDate;
#else
import js.Date as JsDate;
#end

/**
	Timer / Date APIs that can be mocked via `MockTimers.enable()`.
**/
enum abstract MockTimerApi(String) from String to String {
	var SetInterval = "setInterval";
	var SetTimeout = "setTimeout";
	var SetImmediate = "setImmediate";
	var Date = "Date";
}

/**
	Options for `MockTimers.enable()`.
**/
typedef MockTimersEnableOptions = {
	/**
		Timers to mock. Default mocks all time-related APIs including `Date`.
	**/
	@:optional var apis:Array<MockTimerApi>;

	/**
		Initial time (ms) or `Date` used as the value for `Date.now()`. Default: `0`.
	**/
	@:optional var now:EitherType<Float, JsDate>;
};

/**
	Mocking timers simulates and controls `setInterval` / `setTimeout` / `setImmediate`
	and optionally the `Date` object without waiting for real time.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mocktimers
**/
extern class MockTimers {
	/**
		Enable timer mocking for the specified timers.
	**/
	function enable(?enableOptions:MockTimersEnableOptions):Void;

	/**
		Restore default behavior of all mocks created by this instance.
	**/
	function reset():Void;

	/**
		Advance time for all mocked timers by `milliseconds` (default: `1`).
	**/
	function tick(?milliseconds:Float):Void;

	/**
		Trigger all pending mocked timers immediately.
	**/
	function runAll():Void;

	/**
		Set the current Unix timestamp used as reference for mocked `Date` objects.
	**/
	function setTime(milliseconds:Float):Void;
}
