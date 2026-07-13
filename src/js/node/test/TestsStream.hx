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

import js.node.events.EventEmitter.Event;
import js.node.stream.Readable;
#if haxe4
import js.lib.Error;
#else
import js.Error;
#end

/**
	Events emitted by `TestsStream`.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-testsstream
**/
enum abstract TestsStreamEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	var TestCoverage:TestsStreamEvent<TestCoverageEvent->Void> = "test:coverage";
	var TestComplete:TestsStreamEvent<TestCompleteEvent->Void> = "test:complete";
	var TestDequeue:TestsStreamEvent<TestDequeueEvent->Void> = "test:dequeue";
	var TestDiagnostic:TestsStreamEvent<TestDiagnosticEvent->Void> = "test:diagnostic";
	var TestEnqueue:TestsStreamEvent<TestEnqueueEvent->Void> = "test:enqueue";
	var TestFail:TestsStreamEvent<TestFailEvent->Void> = "test:fail";
	var TestInterrupted:TestsStreamEvent<TestInterruptedEvent->Void> = "test:interrupted";
	var TestPass:TestsStreamEvent<TestPassEvent->Void> = "test:pass";
	var TestPlan:TestsStreamEvent<TestPlanEvent->Void> = "test:plan";
	var TestStart:TestsStreamEvent<TestStartEvent->Void> = "test:start";
	var TestStderr:TestsStreamEvent<TestStdioEvent->Void> = "test:stderr";
	var TestStdout:TestsStreamEvent<TestStdioEvent->Void> = "test:stdout";
	var TestSummary:TestsStreamEvent<TestSummaryEvent->Void> = "test:summary";
	var TestWatchDrained:TestsStreamEvent<Void->Void> = "test:watch:drained";
	var TestWatchRestarted:TestsStreamEvent<Void->Void> = "test:watch:restarted";
}

/**
	Location fields shared by several test stream events.
**/
typedef TestLocationInfo = {
	@:optional var column:Int;
	@:optional var file:String;
	@:optional var line:Int;
};

typedef EitherBoolOrString = haxe.extern.EitherType<Bool, String>;

typedef TestCoverageEvent = {
	var summary:Dynamic;
	var nesting:Int;
};

typedef TestCompleteEvent = {
	> TestLocationInfo,
	var details:{
		var passed:Bool;
		var duration_ms:Float;
		@:optional var error:Error;
		@:optional var type:String;
	};
	var name:String;
	var nesting:Int;
	var testId:Float;
	var testNumber:Int;
	@:optional var todo:EitherBoolOrString;
	@:optional var skip:EitherBoolOrString;
};
typedef TestDequeueEvent = {
	> TestLocationInfo,
	var name:String;
	var nesting:Int;
	var testId:Float;
	var type:String;
};

typedef TestDiagnosticEvent = {
	> TestLocationInfo,
	var message:String;
	var nesting:Int;
	var level:String;
};

typedef TestEnqueueEvent = {
	> TestLocationInfo,
	var name:String;
	var nesting:Int;
	var testId:Float;
	var type:String;
};

typedef TestFailEvent = {
	> TestLocationInfo,
	var details:{
		var duration_ms:Float;
		var error:Error;
		@:optional var type:String;
	};
	@:optional var attempt:Int;
	var name:String;
	var nesting:Int;
	var testId:Float;
	var testNumber:Int;
	@:optional var todo:EitherBoolOrString;
	@:optional var skip:EitherBoolOrString;
};

typedef TestInterruptedEvent = {
	var tests:Array<{
		> TestLocationInfo,
		var name:String;
		var nesting:Int;
	}>;
};

typedef TestPassEvent = {
	> TestLocationInfo,
	var details:{
		var duration_ms:Float;
		@:optional var type:String;
	};
	@:optional var attempt:Int;
	@:optional var passed_on_attempt:Int;
	var name:String;
	var nesting:Int;
	var testId:Float;
	var testNumber:Int;
	@:optional var todo:EitherBoolOrString;
	@:optional var skip:EitherBoolOrString;
};

typedef TestPlanEvent = {
	> TestLocationInfo,
	var nesting:Int;
	var count:Int;
};

typedef TestStartEvent = {
	> TestLocationInfo,
	var name:String;
	var nesting:Int;
	var testId:Float;
};

typedef TestStdioEvent = {
	var file:String;
	var message:String;
};

typedef TestSummaryEvent = {
	var counts:{
		var cancelled:Int;
		var failed:Int;
		var passed:Int;
		var skipped:Int;
		var suites:Int;
		var tests:Int;
		var todo:Int;
		var topLevel:Int;
	};
	var duration_ms:Float;
	@:optional var file:String;
	var success:Bool;
};

/**
	A successful call to `Test.run()` returns a `TestsStream`, streaming events
	representing the execution of the tests.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-testsstream
**/
extern class TestsStream extends Readable<TestsStream> {}
