/*
 * Copyright (C)2014-2019 Haxe Foundation
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

import haxe.extern.EitherType;
#if haxe4
import js.lib.RegExp;
import js.lib.Promise;
import js.lib.Error;
#else
import js.RegExp;
import js.Promise;
import js.Error;
#end

/**
	This module is used for writing unit tests for your applications

	@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert
**/
@:jsRequire("assert")
extern class Assert {
	/**
		An alias of `ok`.

		@see https://nodejs.org/api/assert.html#assert_assert_value_message
	**/
	@:selfCall
	static function assert(value:Dynamic, ?message:EitherType<String, Error>):Void;

	/**
		An alias of `assert.deepStrictEqual()`.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_deepequal_actual_expected_message
	**/
	static function deepEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;

	/**
		Tests for deep equality between the `actual` and `expected` parameters.
		"Deep" equality means that the enumerable "own" properties of child objects

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_deepstrictequal_actual_expected_message
	**/
	static function deepStrictEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;

	/**
		Awaits the `asyncFn` promise or, if `asyncFn` is a function, immediately calls the function and awaits the returned promise to complete.
		It will then check that the promise is not rejected.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_doesnotreject_asyncfn_error_message
	**/
	@:overload(function(asyncFn:RejectsAsyncFn, ?message:String):Void {})
	static function doesNotReject(asyncFn:RejectsAsyncFn, error:ThrowsExpectedError, ?message:EitherType<String, Error>):Void;

	/**
		Asserts that the function `fn` does not throw an error.

		 		Using assert.doesNotThrow() is actually not useful because there is no benefit in catching an error and then rethrowing it. Instead, consider adding a comment next to the specific code path that should not throw and keep error messages as expressive as possible.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_doesnotthrow_fn_error_message
	**/
	@:overload(function(fn:EitherType<Void->Void, Void->Dynamic>, ?message:String):Void {})
	static function doesNotThrow(fn:EitherType<Void->Void, Void->Dynamic>, error:ThrowsExpectedError, ?message:String):Void;

	/**
		An alias of `strictEqual`.

		@see https://nodejs.org/api/assert.html#assert_assert_doesnotthrow_fn_error_message
	**/
	static function equal<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;

	/**
		Throws an `AssertionError` with the provided error message or a default error message.
		If the `message` parameter is an instance of an `Error` then it will be thrown instead of the `AssertionError`.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_fail_message
	**/
	static function fail(?message:EitherType<String>):Void;

	/**
		Throws an `AssertionError`. If `message` is falsy, the error message is set as the values of `actual` and `expected` separated by the provided `operator`.
		Otherwise, the error message is the value of `message`.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_fail_actual_expected_message_operator_stackstartfn
	**/
	@:deprecated @:native("fail")
	static function fail_<T>(actual:T, expected:T, message:EitherType<String, Error>, operator_:String):Void;

	/**
		Throws `value` if `value` is not `undefined` or `null`.
		This is useful when testing the `error` argument in callbacks.
		The stack trace contains all frames from the error passed to `ifError()` including the potential new frames for `ifError()` itself.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_iferror_value
	**/
	static function ifError(value:Dynamic):Void;

	/**
		An alias of `notDeepStrictEqual`

		@see https://nodejs.org/api/assert.html#assert_assert_notdeepequal_actual_expected_message
	**/
	static function notDeepEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;

	/**
		Tests for deep strict inequality. Opposite of `deepStrictEqual`.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_notdeepstrictequal_actual_expected_message
	**/
	static function notDeepStrictEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;

	/**
		An alias of `notStrictEqual`.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_notequal_actual_expected_message
	**/
	static function notEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;

	/**
		Tests strict inequality between the `actual` and `expected` parameters as determined by the SameValue Comparison.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_notstrictequal_actual_expected_message
	**/
	static function notStrictEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;

	/**
		Tests if `value` is truthy.
		It is equivalent to `assert.equal(!!value, true, message)`.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_ok_value_message
	**/
	static function ok(value:Dynamic, ?message:EitherType<String, Error>):Void;

	/**
		Awaits the `asyncFn` promise or, if `asyncFn` is a function, immediately calls the function and awaits the returned promise to complete. It will then check that the promise is rejected.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_rejects_asyncfn_error_message
	**/
	@:overload(function(asyncFn:RejectsAsyncFn, ?message:String):Void {})
	static function rejects(asyncFn:RejectsAsyncFn, error:ThrowsExpectedError, ?message:String):Void;

	/**
		Tests strict equality between the `actual` and `expected` parameter as
		determined by the SameValue Comparison.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_strictequal_actual_expected_message
	**/
	static function strictEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;

	/**
		Expects the function `fn` to throw an error.

		@see https://nodejs.org/dist/latest-v12.x/docs/api/assert.html#assert_assert_throws_fn_error_message
	**/
	@:overload(function(fn:EitherType<Void->Void, Void->Dynamic>, ?message:String):Void {})
	static function throws(fn:EitherType<Void->Void, Void->Dynamic>, error:ThrowsExpectedError, ?message:String):Void;
}

/**
	a class, RegExp or function.
**/
private typedef ThrowsExpectedError = EitherType<Class<Dynamic>, EitherType<RegExp, Dynamic->Bool>>;

private typedef RejectsAsyncFn = EitherType<Void->Promise<Dynamic>, Promise<Dynamic>>;
