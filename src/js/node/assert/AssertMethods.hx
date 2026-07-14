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

import js.lib.Error;
import js.lib.Promise;
import js.lib.RegExp;

/**
	Instance-oriented surface matching `js.node.Assert` method signatures.

	Used for bound assert objects such as `TestContext.assert` and `Assert.strict`,
	and as the base of constructible `js.node.assert.Assert` instances.
	Keep in sync with the static methods on `js.node.Assert`.

	@see https://nodejs.org/docs/latest-v24.x/api/assert.html
**/
extern class AssertMethods {
	/**
		An alias of `deepStrictEqual`.
	**/
	@:deprecated("Use deepStrictEqual instead")
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	function deepEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Tests for deep equality between `actual` and `expected`.
	**/
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	function deepStrictEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Expects `string` not to match `regexp`.
	**/
	@:overload(function(string:String, regexp:RegExp, ?message:Error):Void {})
	function doesNotMatch(string:String, regexp:RegExp, ?message:String):Void;

	/**
		Awaits `asyncFn` and checks that the promise is not rejected.
	**/
	@:overload(function(asyncFn:() -> Promise<Any>, ?error:Class<Any>, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:() -> Promise<Any>, ?error:RegExp, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:() -> Promise<Any>, ?error:(error:Any) -> Bool, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:Promise<Any>, ?error:Class<Any>, ?message:String):Promise<Void> {})
	@:overload(function(asyncFn:Promise<Any>, ?error:RegExp, ?message:String):Promise<Void> {})
	function doesNotReject(asyncFn:Promise<Any>, ?error:(error:Any) -> Bool, ?message:String):Promise<Void>;

	/**
		Asserts that `fn` does not throw.
	**/
	@:overload(function(fn:() -> Void, ?error:Class<Any>, ?message:String):Void {})
	@:overload(function(fn:() -> Void, ?error:RegExp, ?message:String):Void {})
	function doesNotThrow(fn:() -> Void, ?error:(error:Any) -> Bool, ?message:String):Void;

	/**
		An alias of `strictEqual`.
	**/
	@:deprecated("Use strictEqual instead")
	@:overload(function<T>(actual:T, expected:T, ?message:String):Void {})
	function equal<T>(actual:T, expected:T, ?message:Error):Void;

	/**
		Throws an `AssertionError` with the provided message.
	**/
	@:overload(function(?message:String):Void {})
	function fail(?message:Error):Void;

	/**
		Throws `value` if `value` is not `undefined` or `null`.
	**/
	function ifError(value:Any):Void;

	/**
		Expects `string` to match `regexp`.
	**/
	@:overload(function(string:String, regexp:RegExp, ?message:Error):Void {})
	function match(string:String, regexp:RegExp, ?message:String):Void;

	/**
		An alias of `notDeepStrictEqual`.
	**/
	@:deprecated("Use notDeepStrictEqual instead")
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	function notDeepEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Tests for deep strict inequality.
	**/
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	function notDeepStrictEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		An alias of `notStrictEqual`.
	**/
	@:deprecated("Use notStrictEqual instead")
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	function notEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Tests strict inequality between `actual` and `expected`.
	**/
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	function notStrictEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Tests if `value` is truthy.
	**/
	@:overload(function(value:Any, ?message:Error):Void {})
	function ok(value:Any, ?message:String):Void;

	/**
		Tests for partial deep equality between `actual` and `expected`.
	**/
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	function partialDeepStrictEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Awaits `asyncFn` and checks that the promise is rejected.
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
	function rejects(asyncFn:Promise<Any>, ?error:Error, ?message:String):Promise<Void>;

	/**
		Tests strict equality between `actual` and `expected`.
	**/
	@:overload(function<T>(actual:T, expected:T, ?message:Error):Void {})
	function strictEqual<T>(actual:T, expected:T, ?message:String):Void;

	/**
		Expects `fn` to throw an error.
	**/
	@:overload(function(fn:() -> Void, ?error:Class<Any>, ?message:String):Void {})
	@:overload(function(fn:() -> Void, ?error:RegExp, ?message:String):Void {})
	@:overload(function(fn:() -> Void, ?error:(error:Any) -> Bool, ?message:String):Void {})
	@:overload(function(fn:() -> Void, ?error:Any, ?message:String):Void {})
	function throws(fn:() -> Void, ?error:Error, ?message:String):Void;
}
