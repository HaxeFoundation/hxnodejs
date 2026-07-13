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
import js.node.Test;
#if haxe4
import js.lib.Error;
import js.lib.Promise;
#else
import js.Error;
import js.Promise;
#end

/**
	Options for `TestContext.plan()`.
**/
typedef PlanOptions = {
	/**
		Wait behavior for the plan:
		- `true`: wait indefinitely
		- `false`: check immediately after the test function completes
		- number: maximum wait time in milliseconds
		Default: `false`.
	**/
	@:optional var wait:EitherType<Bool, Float>;
};

/**
	Options for `TestContext.waitFor()`.
**/
typedef WaitForOptions = {
	/**
		Milliseconds to wait after an unsuccessful invocation before trying again.
		Default: `50`.
	**/
	@:optional var interval:Float;

	/**
		Poll timeout in milliseconds. Default: `1000`.
	**/
	@:optional var timeout:Float;
};

/**
	Runner-specific assertion helpers on `TestContext`, plus commonly used
	`node:assert` methods bound to the context for test plans.

	For the full assert API, see `js.node.Assert`.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextassert
**/
typedef TestContextAssert = {
	/**
		Serialize `value` and compare/write it against the snapshot file for this test.
	**/
	function snapshot(value:Dynamic, ?options:SnapshotAssertionOptions):Void;

	/**
		Serialize `value` and compare/write it to an explicit snapshot file path.
	**/
	function fileSnapshot(value:Dynamic, path:String, ?options:SnapshotAssertionOptions):Void;

	function ok(value:Dynamic, ?message:EitherType<String, Error>):Void;
	function equal<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;
	function notEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;
	function strictEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;
	function notStrictEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;
	function deepEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;
	function notDeepEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;
	function deepStrictEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;
	function notDeepStrictEqual<T>(actual:T, expected:T, ?message:EitherType<String, Error>):Void;
	function match(string:String, regexp:Dynamic, ?message:EitherType<String, Error>):Void;
	function doesNotMatch(string:String, regexp:Dynamic, ?message:EitherType<String, Error>):Void;
	function throws(block:haxe.Constraints.Function, ?error:Dynamic, ?message:String):Void;
	function doesNotThrow(block:haxe.Constraints.Function, ?error:Dynamic, ?message:String):Void;
	function ifError(value:Dynamic):Void;
	function fail(?message:EitherType<String, Error>):Void;
	function rejects(asyncFn:Dynamic, ?error:Dynamic, ?message:String):Promise<Void>;
	function doesNotReject(asyncFn:Dynamic, ?error:Dynamic, ?message:String):Promise<Void>;
};

/**
	An instance of `TestContext` is passed to each test function in order to
	interact with the test runner. The constructor is not exposed as part of the API.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-testcontext
**/
extern class TestContext {
	/**
		Creates a hook running before subtests of the current test.
	**/
	function before(?fn:HookFn, ?options:HookOptions):Void;

	/**
		Creates a hook running before each subtest of the current test.
	**/
	function beforeEach(?fn:HookFn, ?options:HookOptions):Void;

	/**
		Creates a hook that runs after the current test finishes.
	**/
	function after(?fn:HookFn, ?options:HookOptions):Void;

	/**
		Creates a hook running after each subtest of the current test.
	**/
	function afterEach(?fn:HookFn, ?options:HookOptions):Void;

	/**
		Assertion methods bound to this context (for plans and snapshots).
	**/
	var assert(default, never):TestContextAssert;

	/**
		Write a diagnostic message included at the end of the test's results.
	**/
	function diagnostic(message:String):Void;

	/**
		Absolute path of the test file that created the current test.
	**/
	var filePath(default, never):Null<String>;

	/**
		Name of the test and each of its ancestors, separated by `>`.
	**/
	var fullName(default, never):String;

	/**
		Name of the test.
	**/
	var name(default, never):String;

	/**
		Whether the test succeeded (`false` before the test is executed).
	**/
	var passed(default, never):Bool;

	/**
		Failure reason for the test; wrapped and available via `error.cause`.
	**/
	var error(default, never):Null<Error>;

	/**
		Zero-based attempt number of the test (useful with `--test-rerun-failures`).
	**/
	var attempt(default, never):Int;

	/**
		Unique identifier of the worker running the current test file, or `undefined`
		when not running in a test context.
	**/
	var workerId(default, never):Null<Int>;

	/**
		Set the number of assertions and subtests expected to run within the test.
	**/
	function plan(count:Int, ?options:PlanOptions):Void;

	/**
		If truthy, only run subtests that have the `only` option set.
	**/
	function runOnly(shouldRunOnlyTests:Bool):Void;

	/**
		AbortSignal that can be used to abort test subtasks when the test is aborted.
	**/
	var signal(default, never):Dynamic;

	/**
		Cause the test's output to indicate the test as skipped.
	**/
	function skip(?message:String):Void;

	/**
		Add a `TODO` directive to the test's output.
	**/
	function todo(?message:String):Void;

	/**
		Create a subtest under the current test.
	**/
	@:overload(function(?name:String, ?fn:TestFn):Promise<Void> {})
	@:overload(function(?options:TestOptions, ?fn:TestFn):Promise<Void> {})
	@:overload(function(?fn:TestFn):Promise<Void> {})
	function test(?name:String, ?options:TestOptions, ?fn:TestFn):Promise<Void>;

	/**
		Poll `condition` until it succeeds or the operation times out.
	**/
	function waitFor<T>(condition:Void->T, ?options:WaitForOptions):Promise<T>;

	/**
		`MockTracker` instance for this test. Restored automatically when the test finishes.
	**/
	var mock(default, never):MockTracker;
}
