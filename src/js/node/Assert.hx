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
import js.lib.Error;
import js.lib.Promise;
import js.lib.RegExp;
import js.node.assert.AssertMethods;

/**
	The `assert` module provides a set of assertion functions for verifying invariants.
	The module provides a recommended [strict mode](https://nodejs.org/docs/latest-v24.x/api/assert.html#strict-assertion-mode)
	and a more lenient legacy mode.

	For independent assertion instances with custom options (`diff`, `strict`,
	`skipPrototype`), see `js.node.assert.Assert`.

	@see https://nodejs.org/docs/latest-v24.x/api/assert.html
**/
@:jsRequire("assert")
extern class Assert {
	/**
		In strict assertion mode, non-strict methods behave like their corresponding
		strict methods. For example, `Assert.deepEqual()` behaves like `Assert.deepStrictEqual()`.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#strict-assertion-mode
	**/
	static final strict:AssertMethods;

	/**
		An alias of `Assert.ok()`.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertvalue-message
	**/
	@:selfCall
	@:overload(function(value:Any, ?message:Error):Void {})
	static function assert(value:Any, ?message:String):Void;

	/**
		An alias of `Assert.deepStrictEqual()`.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertdeepequalactual-expected-message
	**/
	@:deprecated("Use deepStrictEqual instead")
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	static function deepEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Tests for deep equality between the `actual` and `expected` parameters.
		"Deep" equality means that the enumerable "own" properties of child objects
		are recursively evaluated also by the following rules.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertdeepstrictequalactual-expected-message
	**/
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	static function deepStrictEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Expects the `string` input not to match the regular expression.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertdoesnotmatchstring-regexp-message
	**/
	@:overload(function(string:String, regexp:RegExp, ?message:Error):Void {})
	static function doesNotMatch(string:String, regexp:RegExp, ?message:String):Void;

	/**
		Awaits the `asyncFn` promise or, if `asyncFn` is a function,
		immediately calls the function and awaits the returned promise to complete.
		It will then check that the promise is not rejected.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertdoesnotrejectasyncfn-error-message
	**/
	@:overload(function(asyncFn:() -> Promise<Any>, ?error:Class<Any>, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:() -> Promise<Any>, ?error:RegExp, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:() -> Promise<Any>, ?error:(error:Any) -> Bool, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:Promise<Any>, ?error:Class<Any>, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:Promise<Any>, ?error:RegExp, ?message:String):Promise<Void> {})
	static function doesNotReject(asyncFn:Promise<Any>, ?error:(error:Any) -> Bool, ?message:String):Promise<Void>;

	/**
		Asserts that the function `fn` does not throw an error.

		Using `Assert.doesNotThrow()` is actually not useful because there is no benefit
		in catching an error and then rethrowing it.
		Instead, consider adding a comment next to the specific code path that should not throw
		and keep error messages as expressive as possible.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertdoesnotthrowfn-error-message
	**/
	@:overload(function(fn:() -> Void, ?error:Class<Any>, ?message:String):Void {})
	@:overload(function(fn:() -> Void, ?error:RegExp, ?message:String):Void {})
	static function doesNotThrow(fn:() -> Void, ?error:(error:Any) -> Bool, ?message:String):Void;

	/**
		An alias of `strictEqual`.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertequalactual-expected-message
	**/
	@:deprecated("Use strictEqual instead")
	@:overload(function<T>(actual:T, expected:T, ?message:String):Void {})
	static function equal<T>(actual:T, expected:T, ?message:Error):Void;

	/**
		Throws an `AssertionError` with the provided error message or a default error message.
		If the `message` parameter is an instance of an `Error` then it will be thrown instead of the `AssertionError`.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertfailmessage
	**/
	@:overload(function(?message:String):Void {})
	static function fail(?message:Error):Void;

	/**
		Throws an `AssertionError`. If `message` is falsy, the error message is set as the values
		of `actual` and `expected` separated by the provided `operator`.
		Otherwise, the error message is the value of `message`.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertfailactual-expected-message-operator-stackstartfn
	**/
	@:deprecated("Use fail with a message or Error instead")
	@:native("fail")
	@:overload(function<T>(actual:T, expected:T, ?message:String, ?operator_:String, ?stackStartFn:Function):Void {})
	static function fail_<T>(actual:T, expected:T, ?message:Error, ?operator_:String, ?stackStartFn:Function):Void;

	/**
		Throws `value` if `value` is not `undefined` or `null`.
		This is useful when testing the `error` argument in callbacks.
		The stack trace contains all frames from the error passed to `ifError()` including the potential new frames for `ifError()` itself.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertiferrorvalue
	**/
	static function ifError(value:Any):Void;

	/**
		Expects the `string` input to match the regular expression.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertmatchstring-regexp-message
	**/
	@:overload(function(string:String, regexp:RegExp, ?message:Error):Void {})
	static function match(string:String, regexp:RegExp, ?message:String):Void;

	/**
		An alias of `Assert.notDeepStrictEqual()`.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertnotdeepequalactual-expected-message
	**/
	@:deprecated("Use notDeepStrictEqual instead")
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	static function notDeepEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Tests for deep strict inequality. Opposite of `Assert.deepStrictEqual()`.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertnotdeepstrictequalactual-expected-message
	**/
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	static function notDeepStrictEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		An alias of `Assert.notStrictEqual()`.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertnotequalactual-expected-message
	**/
	@:deprecated("Use notStrictEqual instead")
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	static function notEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Tests strict inequality between the `actual` and `expected` parameters as determined by the SameValue Comparison.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertnotstrictequalactual-expected-message
	**/
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	static function notStrictEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Tests if `value` is truthy.
		It is equivalent to `Assert.equal(!!value, true, message)`.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertokvalue-message
	**/
	@:overload(function(value:Any, ?message:Error):Void {})
	static function ok(value:Any, ?message:String):Void;

	/**
		Tests for partial deep equality between the `actual` and `expected` parameters.
		"Partial" equality means that only properties that exist on the `expected`
		parameter are compared.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertpartialdeepstrictequalactual-expected-message
	**/
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	static function partialDeepStrictEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Awaits the `asyncFn` promise or, if `asyncFn` is a function,
		immediately calls the function and awaits the returned promise to complete.
		It will then check that the promise is rejected.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertrejectsasyncfn-error-message
	**/
	@:overload(function(asyncFn:() -> Promise<Any>, ?error:Class<Any>, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:() -> Promise<Any>, ?error:RegExp, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:() -> Promise<Any>, ?error:(error:Any) -> Bool, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:() -> Promise<Any>, ?error:Any, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:() -> Promise<Any>, ?error:Error, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:Promise<Any>, ?error:Class<Any>, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:Promise<Any>, ?error:RegExp, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:Promise<Any>, ?error:(error:Any) -> Bool, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:Promise<Any>, ?error:Any, ?message:String):Promise<Void> {})
	static function rejects(asyncFn:Promise<Any>, ?error:Error, ?message:String):Promise<Void>;

	/**
		Tests strict equality between the `actual` and `expected` parameter as
		determined by the SameValue Comparison.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertstrictequalactual-expected-message
	**/
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	static function strictEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Expects the function `fn` to throw an error.

		@see https://nodejs.org/docs/latest-v24.x/api/assert.html#assertthrowsfn-error-message
	**/
	@:overload(function(fn:() -> Void, ?error:Class<Any>, ?message:String):Void {})
	@:overload(function(fn:() -> Void, ?error:RegExp, ?message:String):Void {})
	@:overload(function(fn:() -> Void, ?error:(error:Any) -> Bool, ?message:String):Void {})
	@:overload(function(fn:() -> Void, ?error:Any, ?message:String):Void {})
	static function throws(fn:() -> Void, ?error:Error, ?message:String):Void;
}
