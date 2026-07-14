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
import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.web.AbortSignal;
import js.node.test.ItFunction;
import js.node.test.MockTracker;
import js.node.test.SuiteContext;
import js.node.test.SuiteFunction;
import js.node.test.TestContext;
import js.node.test.TestsStream;
import js.lib.Error;
import js.lib.Promise;
import js.lib.RegExp;

/**
	The `node:test` module facilitates the creation of JavaScript tests.

	This module is only available under the `node:` scheme.

	These externs target **Node.js 24+ Active LTS**. Newer APIs such as
	`expectFailure` (v24.14+), `run({ randomize })`, `TestContext.workerId`
	(v24.15+), `SuiteContext.passed` / `attempt` / `diagnostic` (v24.16+), and
	`TestContext.attempt` (v25+) are typed without version gates; older LTS
	releases may not provide them at runtime.

	`tags` / `context.tags` / `run({ testTagFilters })` are Node.js 26+ and are
	intentionally omitted.

	Built-in reporters live in `js.node.test.Reporters` (`node:test/reporters`).

	@see https://nodejs.org/docs/latest-v24.x/api/test.html
**/
@:jsRequire("node:test")
extern class Test {
	/**
		The `test()` function creates a test whose lifecycle is managed by the test runner.

		Each invocation results in reporting the test to the test runner.
		Returns a `Promise` that fulfills once the test completes (or immediately if
		called within a suite).

		Supports `.skip`, `.todo`, `.only`, and `.expectFailure` shorthands
		(same callables as the module-level helpers below; the module export is
		the `test` function).

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#testname-options-fn
	**/
	static var test(default, never):ItFunction;

	/**
		Shorthand for skipping a test: `test(name, { skip: true }[, fn])`.

		Same function as `test.skip` / `it.skip`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#testskipname-options-fn
	**/
	@:overload(function(fn:TestCallback):Promise<Void> {})
	@:overload(function(name:String, fn:TestCallback):Promise<Void> {})
	@:overload(function(options:TestOptions, fn:TestCallback):Promise<Void> {})
	static function skip(?name:String, ?options:TestOptions, ?fn:TestCallback):Promise<Void>;

	/**
		Shorthand for marking a test as `TODO`: `test(name, { todo: true }[, fn])`.

		Same function as `test.todo` / `it.todo`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#testtodoname-options-fn
	**/
	@:overload(function(fn:TestCallback):Promise<Void> {})
	@:overload(function(name:String, fn:TestCallback):Promise<Void> {})
	@:overload(function(options:TestOptions, fn:TestCallback):Promise<Void> {})
	static function todo(?name:String, ?options:TestOptions, ?fn:TestCallback):Promise<Void>;

	/**
		Shorthand for marking a test as `only`: `test(name, { only: true }[, fn])`.

		Same function as `test.only` / `it.only`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#testonlyname-options-fn
	**/
	@:overload(function(fn:TestCallback):Promise<Void> {})
	@:overload(function(name:String, fn:TestCallback):Promise<Void> {})
	@:overload(function(options:TestOptions, fn:TestCallback):Promise<Void> {})
	static function only(?name:String, ?options:TestOptions, ?fn:TestCallback):Promise<Void>;

	/**
		Shorthand for expecting a test to fail: `test(name, { expectFailure: true }[, fn])`.

		Same function as `test.expectFailure` / `it.expectFailure`.

		Added in: v24.14.0

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#expecting-tests-to-fail
	**/
	@:overload(function(fn:TestCallback):Promise<Void> {})
	@:overload(function(name:String, fn:TestCallback):Promise<Void> {})
	@:overload(function(options:TestOptions, fn:TestCallback):Promise<Void> {})
	static function expectFailure(?name:String, ?options:TestOptions, ?fn:TestCallback):Promise<Void>;

	/**
		Alias for `suite()`. Suites group related tests.

		Supports `.skip`, `.todo`, `.only`, and `.expectFailure` shorthands.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#describename-options-fn
	**/
	static var describe(default, never):SuiteFunction;

	/**
		Creates a suite whose lifecycle is managed by the test runner.

		Supports `.skip`, `.todo`, `.only`, and `.expectFailure` shorthands.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#suitename-options-fn
	**/
	static var suite(default, never):SuiteFunction;

	/**
		Alias for `test()`.

		Supports `.skip`, `.todo`, `.only`, and `.expectFailure` shorthands.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#itname-options-fn
	**/
	static var it(default, never):ItFunction;

	/**
		Creates a hook that runs before executing a suite.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#beforefn-options
	**/
	@:overload(function(fn:HookCallback):Void {})
	static function before(?fn:HookCallback, ?options:HookOptions):Void;

	/**
		Creates a hook that runs after executing a suite.
		Guaranteed to run even if tests within the suite fail.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#afterfn-options
	**/
	@:overload(function(fn:HookCallback):Void {})
	static function after(?fn:HookCallback, ?options:HookOptions):Void;

	/**
		Creates a hook that runs before each test in the current suite.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#beforeeachfn-options
	**/
	@:overload(function(fn:HookCallback):Void {})
	static function beforeEach(?fn:HookCallback, ?options:HookOptions):Void;

	/**
		Creates a hook that runs after each test in the current suite.
		Runs even if the test fails.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#aftereachfn-options
	**/
	@:overload(function(fn:HookCallback):Void {})
	static function afterEach(?fn:HookCallback, ?options:HookOptions):Void;

	/**
		Top-level `MockTracker` instance for the process.

		Each test also provides its own tracker via `TestContext.mock`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mocktracker
	**/
	static var mock(default, never):MockTracker;

	/**
		Object whose methods configure default snapshot settings in the current process.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#snapshot
	**/
	static var snapshot(default, never):Snapshot;

	/**
		Object whose methods configure available assertions on `TestContext` objects
		in the current process.

		Methods from `node:assert` and snapshot testing functions are available on
		`TestContext.assert` by default; see `js.node.Assert` for the assert API.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#assert
	**/
	static var assert(default, never):TestAssert;

	/**
		Programmatically run tests and return a stream of test reporter events.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#runoptions
	**/
	static function run(?options:RunOptions):TestsStream;
}

/**
	Callback for a test created with `test()` / `it()` / `TestContext.test()`.

	May be synchronous, return a `Promise`, or accept a Node-style `done` callback
	as the second argument.
**/
typedef TestCallback = EitherType<TestContext->Dynamic, TestContext->(Null<Error>->Void)->Dynamic>;

/**
	Callback for a suite created with `suite()` / `describe()`.
**/
typedef SuiteCallback = EitherType<SuiteContext->Dynamic, SuiteContext->(Null<Error>->Void)->Dynamic>;

/**
	Callback for `before` / `after` / `beforeEach` / `afterEach` hooks.
**/
typedef HookCallback = Function;

/**
	Configuration options for a test or suite.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#testname-options-fn
**/
typedef TestOptions = {
	/**
		If a number is provided, that many tests run asynchronously.
		If `true`, all scheduled asynchronous tests run concurrently.
		If `false`, only one test runs at a time.
		Default: `false` (subtests inherit from parent when unspecified).
	**/
	@:optional var concurrency:EitherType<Int, Bool>;

	/**
		If truthy, the test is expected to fail.
		A string is shown as the reason; a `RegExp` / function / object / `Error`
		is matched like `Assert.throws`. Use `{ label, match }` for both.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#expecting-tests-to-fail
	**/
	@:optional var expectFailure:EitherType<Bool, EitherType<String, EitherType<RegExp, EitherType<Function, EitherType<{}, ExpectFailureOptions>>>>>;

	/**
		If truthy, and the test context is configured to run `only` tests, this test runs.
		Otherwise it is skipped. Default: `false`.
	**/
	@:optional var only:Bool;

	/**
		Allows aborting an in-progress test.
	**/
	@:optional var signal:AbortSignal;

	/**
		If truthy, the test is skipped. A string is shown as the skip reason. Default: `false`.
	**/
	@:optional var skip:EitherType<Bool, String>;

	/**
		If truthy, the test is marked `TODO`. A string is shown as the reason. Default: `false`.
	**/
	@:optional var todo:EitherType<Bool, String>;

	/**
		Milliseconds after which the test fails. Default: `Infinity`.
	**/
	@:optional var timeout:Float;

	/**
		Number of assertions and subtests expected to run. Default: `undefined`.
	**/
	@:optional var plan:Int;
}

/**
	Object form of `expectFailure` providing both a label and a matcher.
**/
typedef ExpectFailureOptions = {
	/**
		Reason displayed in the test results.
	**/
	@:optional var label:String;

	/**
		Matcher for the thrown value (same forms as `Assert.throws`).
	**/
	@:optional var match:EitherType<RegExp, EitherType<Function, EitherType<{}, Error>>>;
}

/**
	Configuration options for hooks.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#beforefn-options
**/
typedef HookOptions = {
	/**
		Allows aborting an in-progress hook.
	**/
	@:optional var signal:AbortSignal;

	/**
		Milliseconds after which the hook fails. Default: `Infinity`.
	**/
	@:optional var timeout:Float;
}

/**
	Options for `TestContext.plan()`.
**/
typedef PlanOptions = {
	/**
		If `true`, wait indefinitely for planned assertions/subtests.
		If `false`, check immediately when the test function completes.
		If a number, maximum wait time in milliseconds. Default: `false`.
	**/
	@:optional var wait:EitherType<Bool, Float>;
}

/**
	Options for `TestContext.waitFor()`.
**/
typedef WaitForOptions = {
	/**
		Milliseconds to wait after an unsuccessful `condition` before retrying. Default: `50`.
	**/
	@:optional var interval:Float;

	/**
		Poll timeout in milliseconds. Default: `1000`.
	**/
	@:optional var timeout:Float;
}

/**
	Options for snapshot assertions on `TestContext.assert`.
**/
typedef SnapshotAssertionOptions = {
	/**
		Serializers applied in order; final result is coerced to a string.
	**/
	@:optional var serializers:Array<Dynamic->Dynamic>;
}

/**
	Configuration options for `Test.run()`.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#runoptions
**/
typedef RunOptions = {
	/**
		Parallelism for test files. Number of processes, or `true`/`false`. Default: `false`.
	**/
	@:optional var concurrency:EitherType<Int, Bool>;

	/**
		Working directory used as the base path for resolving files. Default: `process.cwd()`.
	**/
	@:optional var cwd:String;

	/**
		List of files to run. Default: same as CLI.
	**/
	@:optional var files:Array<String>;

	/**
		Exit the process once all known tests finished even if the event loop remains active.
		Default: `false`.
	**/
	@:optional var forceExit:Bool;

	/**
		Glob patterns to match test files. Cannot be used with `files`.
	**/
	@:optional var globPatterns:Array<String>;

	/**
		Inspector port for test child processes, or a function returning a port.
	**/
	@:optional var inspectPort:EitherType<Int, Void->Int>;

	/**
		Test isolation. Default: `Process`.
	**/
	@:optional var isolation:RunIsolation;

	/**
		If truthy, only run tests with the `only` option set.
	**/
	@:optional var only:Bool;

	/**
		Setup listeners on the returned `TestsStream` before tests run.
	**/
	@:optional var setup:TestsStream->Any;

	/**
		CLI flags passed to the `node` executable when spawning subprocesses.
	**/
	@:optional var execArgv:Array<String>;

	/**
		CLI flags passed to each test file when spawning subprocesses.
	**/
	@:optional var argv:Array<String>;

	/**
		Allows aborting an in-progress test execution.
	**/
	@:optional var signal:AbortSignal;

	/**
		Only run tests whose names match these pattern(s).
	**/
	@:optional var testNamePatterns:EitherType<String, EitherType<RegExp, Array<EitherType<String, RegExp>>>>;

	/**
		Skip tests whose names match these pattern(s).
	**/
	@:optional var testSkipPatterns:EitherType<String, EitherType<RegExp, Array<EitherType<String, RegExp>>>>;

	/**
		Fail the run after this many milliseconds. Default: `Infinity`.
	**/
	@:optional var timeout:Float;

	/**
		Whether to run in watch mode. Default: `false`.
	**/
	@:optional var watch:Bool;

	/**
		Shard configuration for horizontal parallelization.
	**/
	@:optional var shard:RunShardOptions;

	/**
		Randomize execution order for test files and queued tests. Default: `false`.
	**/
	@:optional var randomize:Bool;

	/**
		Seed for deterministic randomization (`0`..`4294967295`). Enables randomization.
	**/
	@:optional var randomSeed:Int;

	/**
		File path where the runner stores state for `--test-rerun-failures`.
	**/
	@:optional var rerunFailuresFilePath:String;

	/**
		Enable code coverage collection. Default: `false`.
	**/
	@:optional var coverage:Bool;

	/**
		Exclude files from coverage via glob(s).
	**/
	@:optional var coverageExcludeGlobs:EitherType<String, Array<String>>;

	/**
		Include files in coverage via glob(s).
	**/
	@:optional var coverageIncludeGlobs:EitherType<String, Array<String>>;

	/**
		Require a minimum percent of covered lines. Default: `0`.
	**/
	@:optional var lineCoverage:Float;

	/**
		Require a minimum percent of covered branches. Default: `0`.
	**/
	@:optional var branchCoverage:Float;

	/**
		Require a minimum percent of covered functions. Default: `0`.
	**/
	@:optional var functionCoverage:Float;

	/**
		Environment variables for test processes (not merged with `process.env`).
		Incompatible with `isolation: 'none'`.
	**/
	@:optional var env:DynamicAccess<String>;
}

/**
	Process isolation mode for `RunOptions.isolation`.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#runoptions
**/
enum abstract RunIsolation(String) from String to String {
	/**
		Each test file runs in a separate child process (default).
	**/
	var Process = "process";

	/**
		All test files run in the current process.
	**/
	var None = "none";
}

/**
	Shard selection for `RunOptions.shard`.
**/
typedef RunShardOptions = {
	/**
		Shard index between `1` and `total` (required).
	**/
	var index:Int;

	/**
		Total number of shards (required).
	**/
	var total:Int;
}

/**
	Module-level snapshot configuration (`Test.snapshot`).
**/
typedef Snapshot = {
	/**
		Customize the default serializers used by snapshot tests.
		Default serialization is `JSON.stringify(value, null, 2)`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#snapshotsetdefaultsnapshotserializersserializers
	**/
	function setDefaultSnapshotSerializers(serializers:Array<Dynamic->Dynamic>):Void;

	/**
		Customize where snapshot files are written.
		`fn` receives the test file path (or `undefined` in the REPL) and must return a path string.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#snapshotsetresolvesnapshotpathfn
	**/
	function setResolveSnapshotPath(fn:Null<String>->String):Void;
}

/**
	Module-level assert configuration (`Test.assert`).

	Does not re-export `node:assert`; see `js.node.Assert` for assertions.
	`TestContext.assert` exposes assert methods bound to the test context for planning.
**/
typedef TestAssert = {
	/**
		Defines a new assertion function available on `TestContext.assert`.
		Overwrites an existing assertion with the same name.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#assertregistername-fn
	**/
	function register(name:String, fn:Function):Void;
}
