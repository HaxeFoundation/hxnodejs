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

package js.node.worker_threads;

import haxe.extern.EitherType;
import js.lib.Error;
import js.lib.Promise;
import js.node.PerfHooks.EventLoopUtilization;
import js.node.Process.CpuUsage;
import js.node.V8.V8HeapSnapshotOptions;
import js.node.V8.V8HeapStatistics;
import js.node.WorkerThreads.WorkerResourceLimits;
import js.node.events.EventEmitter;
import js.node.stream.Readable.IReadable;
import js.node.stream.Writable.IWritable;
import js.node.url.URL;

/**
	Events emitted by `Worker`.
**/
enum abstract WorkerEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted if the worker thread throws an uncaught exception.
		The worker is terminated in that case.
	**/
	var Error:WorkerEvent<(err:Error) -> Void> = "error";

	/**
		Emitted once the worker has stopped.
		Final event emitted by any `Worker` instance.
	**/
	var Exit:WorkerEvent<(exitCode:Int) -> Void> = "exit";

	/**
		Emitted when the worker invokes `parentPort.postMessage()`.
		// TODO(section-5): message value is structured-clone Dynamic
	**/
	var Message:WorkerEvent<(value:Dynamic) -> Void> = "message";

	/**
		Emitted when deserializing a message failed.
	**/
	var MessageError:WorkerEvent<(error:Error) -> Void> = "messageerror";

	/**
		Emitted when the worker thread has started executing JavaScript code.
	**/
	var Online:WorkerEvent<() -> Void> = "online";
}

/**
	The `Worker` class represents an independent JavaScript execution thread.

	Most Node.js APIs are available inside of it. Creating `Worker` instances
	inside other `Worker`s is supported.

	// TODO(section-5): `Symbol.asyncDispose` (`await using`) terminates the worker;
	// add when Disposable models are standardized in hxnodejs.

	@see https://nodejs.org/docs/latest-v24.x/api/worker_threads.html#class-worker
**/
@:jsRequire("worker_threads", "Worker")
extern class Worker extends EventEmitter<Worker> {
	/**
		@see https://nodejs.org/docs/latest-v24.x/api/worker_threads.html#new-workerfilename-options
	**/
	function new(filename:EitherType<String, URL>, ?options:WorkerOptions);

	/**
		Send a message to the worker that will be received via
		`require('worker_threads').parentPort.on('message')`.
		// TODO(section-5): value typing for structured clone remains application-defined Dynamic
	**/
	function postMessage(value:Dynamic, ?transferList:Array<Transferable>):Void;

	/**
		Opposite of `unref()`. Calling `ref()` on a previously `unref`ed worker
		does not let the program exit if it is the only active handle left.
	**/
	function ref():Void;

	/**
		Allows the thread to exit if this is the only active handle in the event system.
	**/
	function unref():Void;

	/**
		Stop all JavaScript execution in the worker thread as soon as possible.
		Returns a Promise for the exit code fulfilled when `'exit'` is emitted.
	**/
	function terminate():Promise<Int>;

	/**
		Returns thread CPU usage identical to `process.threadCpuUsage()`,
		or rejects with `ERR_WORKER_NOT_RUNNING` if the worker has stopped.
	**/
	function cpuUsage(?prev:CpuUsage):Promise<CpuUsage>;

	/**
		Returns a readable stream for a V8 snapshot of the current state of the Worker.
	**/
	function getHeapSnapshot(?options:V8HeapSnapshotOptions):Promise<IReadable>;

	/**
		Returns statistics identical to `V8.getHeapStatistics()`,
		or rejects with `ERR_WORKER_NOT_RUNNING` if the worker has stopped.
	**/
	function getHeapStatistics():Promise<V8HeapStatistics>;

	/**
		Starts a CPU profile. Supports `await using` to discard on scope exit.
		// TODO(section-5): refine profile-handle typing / Symbol.asyncDispose
	**/
	function startCpuProfile():Promise<WorkerCpuProfileHandle>;

	/**
		Starts a heap profile. Supports `await using` to discard on scope exit.
		// TODO(section-5): refine profile-handle typing / Symbol.asyncDispose
	**/
	function startHeapProfile():Promise<WorkerHeapProfileHandle>;

	/**
		An object that can be used to query performance information from a worker.
	**/
	var performance(default, null):WorkerPerformance;

	/**
		An integer identifier for the referenced thread. Identical to `threadId` inside the worker.
	**/
	var threadId(default, null):Int;

	/**
		Optional name assigned when creating the worker, or `null` if not running.
	**/
	var threadName(default, null):Null<String>;

	/**
		If `stdin: true` was passed to the constructor, a writable stream connected to the worker's `process.stdin`.
	**/
	var stdin(default, null):Null<IWritable>;

	/**
		A readable stream connected to the worker's `process.stdout`.
	**/
	var stdout(default, null):IReadable;

	/**
		A readable stream connected to the worker's `process.stderr`.
	**/
	var stderr(default, null):IReadable;

	/**
		JS engine resource constraints for this Worker.
		Empty object if the worker has stopped.
	**/
	var resourceLimits(default, null):Null<WorkerResourceLimits>;
}

/**
	Options for `new Worker(filename, options)`.

	@see https://nodejs.org/docs/latest-v24.x/api/worker_threads.html#new-workerfilename-options
**/
typedef WorkerOptions = {
	/**
		Additional data cloned into the worker as `workerData`.
		// TODO(section-5): workerData typing is application-defined
	**/
	@:optional var workerData:Dynamic;

	/**
		List of transferable objects to pass alongside `workerData`.
	**/
	@:optional var transferList:Array<Transferable>;

	/**
		Arguments stringified and appended to `process.argv` in the worker.
	**/
	@:optional var argv:Array<Dynamic>;

	/**
		If `true` and `filename` is a string, interpret it as a script to evaluate
		once the worker is online.
	**/
	@:optional var eval:Bool;

	@:optional var stdin:Bool;
	@:optional var stdout:Bool;
	@:optional var stderr:Bool;

	/**
		Node CLI options passed to the worker (available as `process.execArgv`).
		V8 / process-affecting flags are not supported. Default: inherit from parent.
	**/
	@:optional var execArgv:Array<String>;

	/**
		Initial `process.env` inside the Worker.
		Use `WorkerThreads.SHARE_ENV` to share the parent's environment.
	**/
	@:optional var env:EitherType<haxe.DynamicAccess<String>, js.lib.Symbol>;

	@:optional var resourceLimits:WorkerResourceLimits;

	/**
		Optional name for the thread / worker title (debugging). Default: `'WorkerThread'`.
	**/
	@:optional var name:String;

	/**
		If `true`, track unmanaged FDs opened via `fs.open` / `fs.close`. Default: `true`.
	**/
	@:optional var trackUnmanagedFds:Bool;
}

/**
	Worker-specific performance helpers.
**/
typedef WorkerPerformance = {
	/**
		Same as `PerfHooks.eventLoopUtilization`, but for this worker instance.
		Values are `0` before `'online'` or after `'exit'`.
	**/
	function eventLoopUtilization(?utilization1:EventLoopUtilization, ?utilization2:EventLoopUtilization):EventLoopUtilization;
}

/**
	Handle returned by `Worker.startCpuProfile`.
**/
typedef WorkerCpuProfileHandle = {
	function stop():Promise<String>;
}

/**
	Handle returned by `Worker.startHeapProfile`.
**/
typedef WorkerHeapProfileHandle = {
	function stop():Promise<String>;
}
