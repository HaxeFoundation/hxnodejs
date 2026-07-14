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

import haxe.extern.EitherType;
import js.lib.Promise;
import js.lib.Symbol;
import js.node.Vm.VmContext;
import js.node.web.LockManager;
import js.node.worker_threads.BroadcastChannel;
import js.node.worker_threads.MessagePort;
import js.node.worker_threads.Transferable;

/**
	The `node:worker_threads` module enables the use of threads that execute JavaScript in parallel.

	Stability: 2 - Stable.

	Core surface for Node.js 24+. Posted message values remain loosely typed
	because structured clone accepts many object graphs; transfer lists use `Transferable`.

	@see https://nodejs.org/docs/latest-v24.x/api/worker_threads.html
**/
@:jsRequire("worker_threads")
extern class WorkerThreads {
	/**
		If this thread was not created as a `Worker`, `null`.
		Otherwise, a `MessagePort` allowing communication with the parent.
	**/
	static final parentPort:Null<MessagePort>;

	/**
		Arbitrary clone of data passed to this thread's `Worker` constructor.
		// TODO(section-5): workerData is application-defined; typed as Dynamic
	**/
	static final workerData:Dynamic;

	/**
		`true` if this code is not running inside of a `Worker` thread.
	**/
	static final isMainThread:Bool;

	/**
		`true` if this code is running inside an internal `Worker` thread
		(for example the loader thread).
	**/
	static final isInternalThread:Bool;

	/**
		Integer identifier for the current thread.
	**/
	static final threadId:Int;

	/**
		String identifier for the current thread, or `null` if the thread is not running.
	**/
	static final threadName:Null<String>;

	/**
		Special value for `Worker` `env` so parent and worker share `process.env`.
	**/
	static final SHARE_ENV:Symbol;

	/**
		JS engine resource constraints inside this Worker thread.
		Empty object when read from the main thread.
	**/
	static final resourceLimits:WorkerResourceLimits;

	/**
		Web Locks API manager for coordinating access across threads in this process.
		Stability: 1 - Experimental.
	**/
	static final locks:LockManager;

	/**
		Returns a clone of data set by `setEnvironmentData` in the spawning thread.
		// TODO(section-5): environment data value typing is application-defined
	**/
	static function getEnvironmentData(key:Dynamic):Dynamic;

	/**
		Sets environment data cloned into all new `Worker` instances from this context.
		Passing `value` as `undefined` deletes any previously set value for `key`.
	**/
	static function setEnvironmentData(key:Dynamic, ?value:Dynamic):Void;

	/**
		Marks an object as not transferable. Occurrence in a transfer list throws.
	**/
	static function markAsUntransferable(object:Dynamic):Void;

	/**
		Returns `true` if the object has been marked as untransferable.
	**/
	static function isMarkedAsUntransferable(object:Dynamic):Bool;

	/**
		Marks an object as not cloneable for structured clone / `postMessage`.
	**/
	static function markAsUncloneable(object:Dynamic):Void;

	/**
		Sends a value to another worker identified by `threadId`.
		`transferList` uses `js.node.worker_threads.Transferable`.

		Stability: 1.1 - Active development.
	**/
	static function postMessageToThread(threadId:Int, value:Dynamic, ?transferList:Array<Transferable>, ?timeout:Int):Promise<Void>;

	/**
		Receive a single queued message from `port` without emitting `'message'`.
		Returns `undefined` when the queue is empty.
	**/
	static function receiveMessageOnPort(port:EitherType<MessagePort, BroadcastChannel>):Null<{message:Dynamic}>;

	/**
		Transfers `port` into `contextifiedSandbox`, returning a port that inherits
		from the target context's `Object`.
	**/
	static function moveMessagePortToContext(port:MessagePort, contextifiedSandbox:VmContext<Dynamic>):MessagePort;
}

/**
	Resource limits for the JS engine in a `Worker`.

	@see https://nodejs.org/docs/latest-v24.x/api/worker_threads.html#workerresourcelimits
**/
typedef WorkerResourceLimits = {
	/**
		Maximum size of the main heap in MB.
	**/
	@:optional var maxOldGenerationSizeMb:Float;

	/**
		Maximum size of a heap space for recently created objects.
	**/
	@:optional var maxYoungGenerationSizeMb:Float;

	/**
		Size of a pre-allocated memory range used for generated code.
	**/
	@:optional var codeRangeSizeMb:Float;

	/**
		Default maximum stack size for the thread. Default: `4`.
	**/
	@:optional var stackSizeMb:Float;
}
