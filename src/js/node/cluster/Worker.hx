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

package js.node.cluster;

import js.lib.Error;
import js.node.Cluster.ListeningEventAddress;
import js.node.child_process.ChildProcess;
import js.node.child_process.ChildProcess.ChildProcessSendHandle;
import js.node.child_process.ChildProcess.ChildProcessSendOptions;
import js.node.events.EventEmitter;

/**
	Events emitted by a `Worker`.

	@see https://nodejs.org/docs/latest-v24.x/api/cluster.html#class-worker
**/
enum abstract WorkerEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Similar to the cluster `'message'` event, but specific to this worker.

		Within a worker, `process.on('message')` may also be used.
	**/
	var Message:WorkerEvent<(message:Dynamic, handle:Null<ChildProcessSendHandle>) -> Void> = "message";

	/**
		Similar to the cluster `'online'` event, but specific to this worker.
		Not emitted in the worker itself.
	**/
	var Online:WorkerEvent<() -> Void> = "online";

	/**
		Similar to the cluster `'listening'` event, but specific to this worker.
		Not emitted in the worker itself.
	**/
	var Listening:WorkerEvent<(address:ListeningEventAddress) -> Void> = "listening";

	/**
		Similar to the cluster `'disconnect'` event, but specific to this worker.
	**/
	var Disconnect:WorkerEvent<() -> Void> = "disconnect";

	/**
		Similar to the cluster `'exit'` event, but specific to this worker.

		`code` is the exit code if it exited normally; `signal` is the signal name
		if it was killed (the other is then `null`).
	**/
	var Exit:WorkerEvent<(code:Null<Int>, signal:Null<String>) -> Void> = "exit";

	/**
		Same as the `'error'` event from `ChildProcess.fork`.

		Within a worker, `process.on('error')` may also be used.
	**/
	var Error:WorkerEvent<(error:Error) -> Void> = "error";
}

/**
	A `Worker` object contains all public information and methods about a worker.

	In the primary it can be obtained using `Cluster.workers`.
	In a worker it can be obtained using `Cluster.worker`.

	@see https://nodejs.org/docs/latest-v24.x/api/cluster.html#class-worker
**/
@:jsRequire("cluster", "Worker")
extern class Worker extends EventEmitter<Worker> {
	/**
		Unique id for this worker.

		While the worker is alive, this is the key that indexes it in `Cluster.workers`.
	**/
	var id(default, null):Int;

	/**
		Underlying process from `ChildProcess.fork`.

		In a worker, the global `process` is stored here.

		Workers call `process.exit(0)` if `'disconnect'` occurs on `process`
		and `exitedAfterDisconnect` is not `true`.
	**/
	var process:ChildProcess;

	/**
		Deprecated alias for `exitedAfterDisconnect`.

		Removed from modern Node.js docs; retained for older runtimes and existing Haxe code.
	**/
	@:deprecated("Use exitedAfterDisconnect instead")
	var suicide:Null<Bool>;

	/**
		`true` if the worker exited due to `disconnect`.
		`false` if it exited any other way.
		`undefined` if it has not exited.

		Lets the primary distinguish voluntary vs accidental exit when deciding whether to respawn.
	**/
	var exitedAfterDisconnect:Null<Bool>;

	/**
		Send a message to a worker or primary, optionally with a handle.

		In the primary this targets a specific worker (same as `ChildProcess.send`).
		In a worker this sends to the primary (same as `process.send`).
	**/
	@:overload(function(message:Dynamic, sendHandle:ChildProcessSendHandle, options:ChildProcessSendOptions, ?callback:(error:Null<Error>) -> Void):Bool {})
	@:overload(function(message:Dynamic, sendHandle:ChildProcessSendHandle, ?callback:(error:Null<Error>) -> Void):Bool {})
	function send(message:Dynamic, ?callback:(error:Null<Error>) -> Void):Bool;

	/**
		Kill the worker.

		In the primary: disconnects `worker.process`, then kills with `signal`.
		In the worker: kills the process with `signal`.

		Does not wait for a graceful disconnect (same behavior as `worker.process.kill()`).
		Default signal: `'SIGTERM'`.
	**/
	function kill(?signal:String):Void;

	/**
		Alias for `kill` (backwards compatibility).
	**/
	function destroy(?signal:String):Void;

	/**
		In a worker: close all servers, wait for `'close'`, then disconnect the IPC channel.

		In the primary: sends an internal message causing the worker to call `disconnect` on itself.

		Sets `exitedAfterDisconnect`.
		Returns a reference to this worker.
	**/
	function disconnect():Worker;

	/**
		`true` if connected to the primary via IPC, `false` otherwise.

		Connected after creation; disconnected after the `'disconnect'` event.
	**/
	function isConnected():Bool;

	/**
		`true` if the worker's process has terminated (exit or signal), else `false`.
	**/
	function isDead():Bool;
}
