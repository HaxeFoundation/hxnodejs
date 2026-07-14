/*
 * Copyright (C)2014-2025 Haxe Foundation
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
import js.node.WorkerThreads.WorkerResourceLimits;
import js.node.events.EventEmitter;
import js.node.stream.Readable.IReadable;
import js.node.stream.Writable.IWritable;
import js.node.url.URL;

/**
	Events emitted by `Worker`.
**/
enum abstract WorkerEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	var Error:WorkerEvent<Error->Void> = "error";
	var Exit:WorkerEvent<Int->Void> = "exit";
	// TODO(section-5): message value is structured-clone Dynamic
	var Message:WorkerEvent<Dynamic->Void> = "message";
	var MessageError:WorkerEvent<Error->Void> = "messageerror";
	var Online:WorkerEvent<Void->Void> = "online";
}

/**
	The `Worker` class represents an independent JavaScript execution thread.

	@see https://nodejs.org/docs/latest-v24.x/api/worker_threads.html#class-worker
**/
@:jsRequire("worker_threads", "Worker")
extern class Worker extends EventEmitter<Worker> {
	/**
		@see https://nodejs.org/docs/latest-v24.x/api/worker_threads.html#new-workerfilename-options
	**/
	function new(filename:EitherType<String, URL>, ?options:WorkerOptions);

	/**
		Send a message to the worker that will be received via `require('worker_threads').parentPort.on('message')`.
		// TODO(section-5): transferList / value typing for structured clone
	**/
	function postMessage(value:Dynamic, ?transferList:Array<Dynamic>):Void;

	/**
		Opposite of `unref()`. Calls will take effect if the Worker previously was `unref`ed.
	**/
	function ref():Void;

	/**
		Calling `unref` on a worker allows the thread to exit if this is the only active handle in the event system.
	**/
	function unref():Void;

	/**
		Stop all JavaScript execution in the worker thread as soon as possible.
		Returns a Promise for the exit code.
	**/
	function terminate():Promise<Int>;

	/**
		Returns a readable stream for a V8 snapshot of the current state of the Worker.
	**/
	function getHeapSnapshot():Promise<IReadable>;

	/**
		Returns statistics about the worker's V8 heap.
		// TODO(section-5): align with V8HeapStatistics once shared typing is practical
	**/
	function getHeapStatistics():Promise<Dynamic>;

	/**
		An integer identifier for the referenced thread. Identical to `threadId` inside the worker.
	**/
	var threadId(default, null):Int;

	/**
		Optional name assigned when creating the worker.
	**/
	var threadName(default, null):Null<String>;

	/**
		If `stdin: true` was passed to the constructor, this is a writable stream connected to worker's `process.stdin`.
	**/
	var stdin(default, null):Null<IWritable>;

	/**
		A readable stream connected to worker's `process.stdout`.
	**/
	var stdout(default, null):IReadable;

	/**
		A readable stream connected to worker's `process.stderr`.
	**/
	var stderr(default, null):IReadable;

	/**
		An object containing information about the resource limits of the Worker.
	**/
	var resourceLimits(default, null):Null<WorkerResourceLimits>;
}

typedef WorkerOptions = {
	/**
		Additional data to send in parallel.
		// TODO(section-5): workerData typing is application-defined
	**/
	@:optional var workerData:Dynamic;

	/**
		List of transferable objects to pass alongside `workerData`.
	**/
	@:optional var transferList:Array<Dynamic>;

	@:optional var stdin:Bool;
	@:optional var stdout:Bool;
	@:optional var stderr:Bool;

	/**
		Executable used to create the worker.
	**/
	@:optional var execArgv:Array<String>;

	/**
		An optional environment object keyed like `process.env`.
		Use `WorkerThreads.SHARE_ENV` to share the env.
	**/
	@:optional var env:EitherType<haxe.DynamicAccess<String>, js.lib.Symbol>;

	@:optional var resourceLimits:WorkerResourceLimits;
	@:optional var name:String;

	/**
		If `true`, track unmanaged resources managed by the worker.
	**/
	@:optional var trackUnmanagedFds:Bool;
}
