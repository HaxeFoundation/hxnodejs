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

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import js.node.events.EventEmitter.Event;
import js.node.stream.Readable;
import js.lib.Error;

/**
	Events emitted by `TestsStream`.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-testsstream
**/
enum abstract TestsStreamEvent<T:Function>(Event<T>) to Event<T> {
	/**
		Emitted when code coverage is enabled and all tests have completed.
	**/
	var TestCoverage:TestsStreamEvent<TestsStreamCoverageEvent->Void> = "test:coverage";

	/**
		Emitted when a test completes (execution order; see also `test:pass` / `test:fail`).
	**/
	var TestComplete:TestsStreamEvent<TestsStreamTestEvent->Void> = "test:complete";

	/**
		Emitted when a test is dequeued, right before it is executed.
	**/
	var TestDequeue:TestsStreamEvent<TestsStreamTestEvent->Void> = "test:dequeue";

	/**
		Emitted when `context.diagnostic` is called (declaration order).
	**/
	var TestDiagnostic:TestsStreamEvent<TestsStreamDiagnosticEvent->Void> = "test:diagnostic";

	/**
		Emitted when a test is enqueued for execution.
	**/
	var TestEnqueue:TestsStreamEvent<TestsStreamTestEvent->Void> = "test:enqueue";

	/**
		Emitted when a test fails (declaration order).
	**/
	var TestFail:TestsStreamEvent<TestsStreamTestEvent->Void> = "test:fail";

	/**
		Emitted when the runner is interrupted by `SIGINT`.
	**/
	var TestInterrupted:TestsStreamEvent<TestsStreamInterruptedEvent->Void> = "test:interrupted";

	/**
		Emitted when a test passes (declaration order).
	**/
	var TestPass:TestsStreamEvent<TestsStreamTestEvent->Void> = "test:pass";

	/**
		Emitted when all subtests have completed for a given test.
	**/
	var TestPlan:TestsStreamEvent<TestsStreamPlanEvent->Void> = "test:plan";

	/**
		Emitted when a test starts reporting status (declaration order).
	**/
	var TestStart:TestsStreamEvent<TestsStreamTestEvent->Void> = "test:start";

	/**
		Emitted when a running test writes to `stderr` (only with `--test`).
	**/
	var TestStderr:TestsStreamEvent<TestsStreamStdioEvent->Void> = "test:stderr";

	/**
		Emitted when a running test writes to `stdout` (only with `--test`).
	**/
	var TestStdout:TestsStreamEvent<TestsStreamStdioEvent->Void> = "test:stdout";

	/**
		Emitted when a test run completes, with aggregate counts.
	**/
	var TestSummary:TestsStreamEvent<TestsStreamSummaryEvent->Void> = "test:summary";

	/**
		Emitted when no more tests are queued in watch mode.
	**/
	var TestWatchDrained:TestsStreamEvent<Void->Void> = "test:watch:drained";

	/**
		Emitted when tests are restarted due to a file change in watch mode.
	**/
	var TestWatchRestarted:TestsStreamEvent<Void->Void> = "test:watch:restarted";
}

/**
	Readable stream of test reporter events returned by `Test.run()`.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-testsstream
**/
extern class TestsStream extends Readable<TestsStream> {}

/**
	Payload for most test lifecycle events (`data` field shape varies slightly by event).
**/
typedef TestsStreamTestEvent = {
	var data:TestsStreamTestData;
}

typedef TestsStreamTestData = {
	@:optional var column:Null<Int>;
	@:optional var details:TestsStreamTestDetails;
	@:optional var file:Null<String>;
	@:optional var line:Null<Int>;
	var name:String;
	var nesting:Int;
	@:optional var testId:Int;
	@:optional var testNumber:Int;
	@:optional var type:String;
	@:optional var todo:EitherType<Bool, String>;
	@:optional var skip:EitherType<Bool, String>;
	@:optional var attempt:Int;
	@:optional var passed_on_attempt:Int;
}

typedef TestsStreamTestDetails = {
	@:optional var passed:Bool;
	@:optional var duration_ms:Float;
	@:optional var error:Error;
	@:optional var type:String;
}

typedef TestsStreamDiagnosticEvent = {
	var data:TestsStreamDiagnosticData;
}

typedef TestsStreamDiagnosticData = {
	@:optional var column:Null<Int>;
	@:optional var file:Null<String>;
	@:optional var line:Null<Int>;
	var message:String;
	var nesting:Int;
	var level:String;
}

typedef TestsStreamPlanEvent = {
	var data:TestsStreamPlanData;
}

typedef TestsStreamPlanData = {
	@:optional var column:Null<Int>;
	@:optional var file:Null<String>;
	@:optional var line:Null<Int>;
	var nesting:Int;
	var count:Int;
}

typedef TestsStreamStdioEvent = {
	var data:TestsStreamStdioData;
}

typedef TestsStreamStdioData = {
	var file:String;
	var message:String;
}

typedef TestsStreamInterruptedEvent = {
	var data:TestsStreamInterruptedData;
}

typedef TestsStreamInterruptedData = {
	var tests:Array<TestsStreamInterruptedTest>;
}

typedef TestsStreamInterruptedTest = {
	@:optional var column:Null<Int>;
	@:optional var file:Null<String>;
	@:optional var line:Null<Int>;
	var name:String;
	var nesting:Int;
}

typedef TestsStreamSummaryEvent = {
	var data:TestsStreamSummaryData;
}

typedef TestsStreamSummaryData = {
	var counts:TestsStreamSummaryCounts;
	var duration_ms:Float;
	@:optional var file:Null<String>;
	var success:Bool;
}

typedef TestsStreamSummaryCounts = {
	var cancelled:Int;
	var failed:Int;
	var passed:Int;
	var skipped:Int;
	var suites:Int;
	var tests:Int;
	var todo:Int;
	var topLevel:Int;
}

typedef TestsStreamCoverageEvent = {
	var data:TestsStreamCoverageData;
}

typedef TestsStreamCoverageData = {
	var summary:Dynamic;
	var nesting:Int;
}