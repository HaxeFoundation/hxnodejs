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

package js.node;

import js.lib.Promise;
import js.lib.Symbol;
import js.node.Vm.VmContext;
import js.node.worker_threads.MessagePort;
import js.node.worker_threads.Transferable;
import js.node.worker_threads.Worker;

/**
	The `node:worker_threads` module enables the use of threads that execute JavaScript in parallel.

	Core surface for Node.js 24+. Posted message values remain loosely typed
	because structured clone accepts many object graphs; transfer lists use `Transferable`.

	@see https://nodejs.org/docs/latest-v24.x/api/worker_threads.html
**/
@:jsRequire("worker_threads")
extern class WorkerThreads {
	static final parentPort:Null<MessagePort>;

	/**
		// TODO(section-5): workerData is application-defined; typed as Dynamic
	**/
	static final workerData:Dynamic;

	static final isMainThread:Bool;
	static final isInternalThread:Bool;
	static final threadId:Int;
	static final threadName:Null<String>;
	static final SHARE_ENV:Symbol;
	static final resourceLimits:WorkerResourceLimits;

	/**
		// TODO(section-5): environment data value typing is application-defined
	**/
	static function getEnvironmentData(key:Dynamic):Dynamic;

	static function setEnvironmentData(key:Dynamic, ?value:Dynamic):Void;
	static function markAsUntransferable(object:Dynamic):Void;
	static function isMarkedAsUntransferable(object:Dynamic):Bool;
	static function markAsUncloneable(object:Dynamic):Void;

	/**
		Posts a value to another thread. `transferList` uses `js.node.worker_threads.Transferable`.
	**/
	static function postMessageToThread(threadId:Int, value:Dynamic, ?transferList:Array<Transferable>, ?timeout:Int):Promise<Void>;

	static function receiveMessageOnPort(port:MessagePort):Null<{message:Dynamic}>;
	static function moveMessagePortToContext(port:MessagePort, contextifiedSandbox:VmContext<Dynamic>):MessagePort;
}

typedef WorkerResourceLimits = {
	@:optional var maxOldGenerationSizeMb:Float;
	@:optional var maxYoungGenerationSizeMb:Float;
	@:optional var codeRangeSizeMb:Float;
	@:optional var stackSizeMb:Float;
}

// TODO(section-5): BroadcastChannel / locks / Worker performance profiling APIs
