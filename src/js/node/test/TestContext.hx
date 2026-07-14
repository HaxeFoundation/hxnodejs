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
import js.node.assert.AssertMethods;
import js.node.web.AbortSignal;
import js.node.Test.HookCallback;
import js.node.Test.HookOptions;
import js.node.Test.PlanOptions;
import js.node.Test.SnapshotAssertionOptions;
import js.node.Test.TestCallback;
import js.node.Test.TestOptions;
import js.node.Test.WaitForOptions;
import js.lib.Error;
import js.lib.Promise;

/**
	Passed to each test function to interact with the test runner.

	The `TestContext` constructor is not part of the public API.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-testcontext
**/
extern class TestContext {
	/**
		Create a hook that runs before subtests of the current test.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextbeforefn-options
	**/
	@:overload(function(fn:HookCallback):Void {})
	function before(?fn:HookCallback, ?options:HookOptions):Void;

	/**
		Create a hook that runs before each subtest of the current test.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextbeforeeachfn-options
	**/
	@:overload(function(fn:HookCallback):Void {})
	function beforeEach(?fn:HookCallback, ?options:HookOptions):Void;

	/**
		Create a hook that runs after the current test finishes.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextafterfn-options
	**/
	@:overload(function(fn:HookCallback):Void {})
	function after(?fn:HookCallback, ?options:HookOptions):Void;

	/**
		Create a hook that runs after each subtest of the current test.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextaftereachfn-options
	**/
	@:overload(function(fn:HookCallback):Void {})
	function afterEach(?fn:HookCallback, ?options:HookOptions):Void;

	/**
		Assertion methods bound to this context, used for test plans.

		Includes the usual `node:assert` methods (see `js.node.Assert`) plus
		runner-specific snapshot helpers.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextassert
	**/
	var assert(default, null):TestContextAssert;

	/**
		Write a diagnostic message included at the end of the test's results.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextdiagnosticmessage
	**/
	function diagnostic(message:String):Void;

	/**
		Absolute path of the test file that created the current test.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextfilepath
	**/
	var filePath(default, null):Null<String>;

	/**
		Name of the test and each of its ancestors, separated by `>`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextfullname
	**/
	var fullName(default, null):String;

	/**
		Name of the test.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextname
	**/
	var name(default, null):String;

	/**
		Whether the test succeeded. `false` before the test has executed
		(e.g. in a `beforeEach` hook).

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextpassed
	**/
	var passed(default, null):Bool;

	/**
		Failure reason for the test when it did not pass; wrapped with `cause`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contexterror
	**/
	var error(default, null):Null<Error>;

	/**
		Zero-based attempt number when using `--test-rerun-failures`.

		Added in: v25.0.0

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextattempt
	**/
	var attempt(default, null):Int;

	/**
		Unique worker id for the current test file process, or `undefined`
		outside a test context.

		Added in: v24.15.0

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextworkerid
	**/
	var workerId(default, null):Null<Int>;

	/**
		Set the number of assertions and subtests expected to run.
		Use `t.assert` (not bare `assert`) so assertions are tracked.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextplancountoptions
	**/
	function plan(count:Int, ?options:PlanOptions):Void;

	/**
		When `true`, only subtests with the `only` option set are run.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextrunonlyshouldrunonlytests
	**/
	function runOnly(shouldRunOnlyTests:Bool):Void;

	/**
		Abort signal for cancelling test subtasks when the test is aborted.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextsignal
	**/
	var signal(default, null):AbortSignal;

	/**
		Mark the test as skipped. Does not terminate the test function.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextskipmessage
	**/
	function skip(?message:String):Void;

	/**
		Mark the test as `TODO`. Does not terminate the test function.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contexttodomessage
	**/
	function todo(?message:String):Void;

	/**
		Create a subtest under the current test.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contexttestname-options-fn
	**/
	@:overload(function(fn:TestCallback):Promise<Void> {})
	@:overload(function(name:String, fn:TestCallback):Promise<Void> {})
	@:overload(function(options:TestOptions, fn:TestCallback):Promise<Void> {})
	function test(?name:String, ?options:TestOptions, ?fn:TestCallback):Promise<Void>;

	/**
		Poll `condition` until it succeeds or the timeout elapses.

		`condition` may return a value or a `Promise` of that value; the returned
		promise fulfills with the awaited successful result.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextwaitforcondition-options
	**/
	function waitFor<T>(condition:Void->EitherType<T, Promise<T>>, ?options:WaitForOptions):Promise<T>;

	/**
		`MockTracker` instance for this test.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mocktracker
	**/
	var mock(default, null):MockTracker;
}

/**
	Assertion helpers on `TestContext.assert`.

	Composes the bound `node:assert` method surface (`js.node.assert.AssertMethods`,
	matching `js.node.Assert`) with runner-specific snapshot helpers.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextassert
**/
extern class TestContextAssert extends AssertMethods {
	/**
		Serialize `value` and write/compare against the snapshot file at `path`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextassertfilesnapshotvalue-path-options
	**/
	function fileSnapshot(value:Dynamic, path:String, ?options:SnapshotAssertionOptions):Void;

	/**
		Assert against (or update) a snapshot entry for this test.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextassertsnapshotvalue-options
	**/
	function snapshot(value:Dynamic, ?options:SnapshotAssertionOptions):Void;
}
