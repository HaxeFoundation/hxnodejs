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

package js.node.test;

import haxe.extern.EitherType;
import js.lib.Date as JsDate;

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
		Initial epoch as a Unix timestamp (ms) or a JS `Date`. Default: `0`.

		Matches Node's `number | Date`.
	**/
	@:optional var now:EitherType<Float, JsDate>;
}

/**
	Mocking timers simulates and controls `setInterval` / `setTimeout` / `setImmediate`
	and optionally the `Date` object without waiting for real time.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mocktimers
**/
extern class MockTimers {
	/**
		Enable timer mocking for the specified timers.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#timersenableenableoptions
	**/
	function enable(?enableOptions:MockTimersEnableOptions):Void;

	/**
		Restore default behavior of all mocks created by this instance.

		Also available as `Symbol.dispose` (aliases this method). Disposable
		typing is not modeled yet; call `reset()` explicitly in Haxe.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#timersreset
		@see https://nodejs.org/docs/latest-v24.x/api/test.html#timerssymboldispose
	**/
	function reset():Void;

	/**
		Advance time for all mocked timers by `milliseconds` (default: `1`).

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#timerstickmilliseconds
	**/
	function tick(?milliseconds:Float):Void;

	/**
		Trigger all pending mocked timers immediately.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#timersrunall
	**/
	function runAll():Void;

	/**
		Set the current Unix timestamp used as reference for mocked `Date` objects.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#timerssettimemilliseconds
	**/
	function setTime(milliseconds:Float):Void;
}
