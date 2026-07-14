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

import js.node.Test.TestCallback;
import js.node.Test.TestOptions;
import js.lib.Promise;

/**
	Callable test entry used by `it`, with suite-style shorthands plus `expectFailure`.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#itname-options-fn
**/
extern class ItFunction {
	/**
		Create a test (alias of `test()`).
	**/
	@:selfCall
	@:overload(function(fn:TestCallback):Promise<Void> {})
	@:overload(function(name:String, fn:TestCallback):Promise<Void> {})
	@:overload(function(options:TestOptions, fn:TestCallback):Promise<Void> {})
	function call(?name:String, ?options:TestOptions, ?fn:TestCallback):Promise<Void>;

	/**
		Shorthand for skipping a test.
	**/
	@:overload(function(fn:TestCallback):Promise<Void> {})
	@:overload(function(name:String, fn:TestCallback):Promise<Void> {})
	@:overload(function(options:TestOptions, fn:TestCallback):Promise<Void> {})
	function skip(?name:String, ?options:TestOptions, ?fn:TestCallback):Promise<Void>;

	/**
		Shorthand for marking a test as `TODO`.
	**/
	@:overload(function(fn:TestCallback):Promise<Void> {})
	@:overload(function(name:String, fn:TestCallback):Promise<Void> {})
	@:overload(function(options:TestOptions, fn:TestCallback):Promise<Void> {})
	function todo(?name:String, ?options:TestOptions, ?fn:TestCallback):Promise<Void>;

	/**
		Shorthand for marking a test as `only`.
	**/
	@:overload(function(fn:TestCallback):Promise<Void> {})
	@:overload(function(name:String, fn:TestCallback):Promise<Void> {})
	@:overload(function(options:TestOptions, fn:TestCallback):Promise<Void> {})
	function only(?name:String, ?options:TestOptions, ?fn:TestCallback):Promise<Void>;

	/**
		Shorthand for expecting a test to fail (`expectFailure: true`).

		Added in: v24.14.0

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#expecting-tests-to-fail
	**/
	@:overload(function(fn:TestCallback):Promise<Void> {})
	@:overload(function(name:String, fn:TestCallback):Promise<Void> {})
	@:overload(function(options:TestOptions, fn:TestCallback):Promise<Void> {})
	function expectFailure(?name:String, ?options:TestOptions, ?fn:TestCallback):Promise<Void>;
}
