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
import js.lib.Error;

/**
	Indicates the failure of an assertion. All errors thrown by the `assert`
	module will be instances of the `AssertionError` class.

	@see https://nodejs.org/docs/latest-v24.x/api/assert.html#class-assertassertionerror
**/
@:jsRequire("assert", "AssertionError")
extern class AssertionError extends Error {
	/**
		A subclass of `Error` that indicates the failure of an assertion.
	**/
	function new(options:AssertionErrorOptions);

	/**
		Set to the `actual` argument for methods such as `Assert.strictEqual()`.
	**/
	final actual:Any;

	/**
		Set to the `expected` value for methods such as `Assert.strictEqual()`.
	**/
	final expected:Any;

	/**
		Indicates if the message was auto-generated (`true`) or not.
	**/
	final generatedMessage:Bool;

	/**
		Value is always `ERR_ASSERTION` to show that the error is an assertion error.
	**/
	final code:String;

	/**
		Set to the passed in operator value.
	**/
	@:native("operator") final operator_:String;
}

/**
	Options for `new AssertionError()`.
**/
typedef AssertionErrorOptions = {
	/**
		If provided, the error message is set to this value.
	**/
	@:optional var message:String;

	/**
		The `actual` property on the error instance.
	**/
	@:optional var actual:Any;

	/**
		The `expected` property on the error instance.
	**/
	@:optional var expected:Any;

	/**
		The `operator` property on the error instance.
	**/
	@:optional @:native("operator") var operator_:String;

	/**
		If provided, the generated stack trace omits frames before this function.
	**/
	@:optional var stackStartFn:Function;

	/**
		If set to `'full'`, shows the full diff in assertion errors.
		Defaults to `'simple'`.
	**/
	@:optional var diff:AssertDiff;
}
