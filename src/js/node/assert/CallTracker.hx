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

package js.node.assert;

import haxe.Constraints.Function;

/**
	Deprecated tracking helper for verifying that functions were called the
	expected number of times.

	Stability: 0 - Deprecated since Node.js v20.1.0. Prefer `node:test` mock helpers.

	@see https://nodejs.org/docs/latest-v24.x/api/assert.html#class-assertcalltracker
**/
@:deprecated("Use node:test mock helpers instead")
@:jsRequire("assert", "CallTracker")
extern class CallTracker {
	function new();

	/**
		Returns a wrapper function that tracks calls to `fn`.
		Must be called exactly `exact` times before `verify()`.
	**/
	@:overload(function(?exact:Int):() -> Void {})
	@:overload(function(fn:Function, ?exact:Int):Function {})
	function calls(?fn:Function, ?exact:Int):Function;

	/**
		Returns an array with information for all calls of the tracked function.
	**/
	function getCalls(fn:Function):Array<CallTrackerCall>;

	/**
		Reset call counts for a tracked function (or all if omitted).
	**/
	function reset(?fn:Function):Void;

	/**
		Report the number of times the tracked functions have been called.
	**/
	function report():Array<CallTrackerReportInformation>;

	/**
		Throw an error if expectations for tracked functions are not met.
	**/
	function verify():Void;
}

/**
	A recorded call for `CallTracker.getCalls`.
**/
typedef CallTrackerCall = {
	var thisArg:Any;
	var arguments:Array<Any>;
}

/**
	Report information from `CallTracker.report`.
**/
typedef CallTrackerReportInformation = {
	var actual:Int;
	var expected:Int;
	var message:String;
	@:optional @:native("operator") var operator_:String;
	@:optional var stack:Any;
}
