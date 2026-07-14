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

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.ChildProcess.ChildProcessSerialization;
import js.node.ChildProcess.ChildProcessSpawnOptionsStdio;
import js.node.child_process.ChildProcess.ChildProcessSendHandle;
import js.node.cluster.Worker;
import js.node.events.EventEmitter;

/**
	Events emitted by the `cluster` module.

	@see https://nodejs.org/docs/latest-v24.x/api/cluster.html
**/
enum abstract ClusterEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when a new worker is forked.
		Useful for logging worker activity or creating a custom timeout.
	**/
	var Fork:ClusterEvent<(worker:Worker) -> Void> = "fork";

	/**
		Emitted when the primary receives an online message from a worker.

		The difference between `'fork'` and `'online'` is that `'fork'` is emitted
		when the primary forks a worker, and `'online'` when the worker is running.
	**/
	var Online:ClusterEvent<(worker:Worker) -> Void> = "online";

	/**
		Emitted on the primary after a worker's server emits `'listening'`.

		`address` contains `address`, `port`, and `addressType`.
	**/
	var Listening:ClusterEvent<(worker:Worker, address:ListeningEventAddress) -> Void> = "listening";

	/**
		Emitted after the worker IPC channel has disconnected.

		There may be a delay between `'disconnect'` and `'exit'`.
	**/
	var Disconnect:ClusterEvent<(worker:Worker) -> Void> = "disconnect";

	/**
		Emitted when any worker dies.

		`code` is the exit code if it exited normally; `signal` is the signal name
		if it was killed (the other is then `null`).

		Can be used to restart the worker by calling `fork` again.
	**/
	var Exit:ClusterEvent<(worker:Worker, code:Null<Int>, signal:Null<String>) -> Void> = "exit";

	/**
		Emitted every time `setupPrimary` is called.

		`settings` is advisory only; prefer reading `Cluster.settings` for accuracy
		when multiple calls happen in a single tick.
	**/
	var Setup:ClusterEvent<(settings:ClusterSettings) -> Void> = "setup";

	/**
		Emitted when the cluster primary receives a message from any worker.

		@see https://nodejs.org/docs/latest-v24.x/api/cluster.html#event-message
	**/
	var Message:ClusterEvent<(worker:Worker, message:Dynamic, handle:Null<ChildProcessSendHandle>) -> Void> = "message";
}

/**
	Connection properties passed with the `'listening'` event.

	@see https://nodejs.org/docs/latest-v24.x/api/cluster.html#event-listening
**/
typedef ListeningEventAddress = {
	var address:String;
	var port:Int;
	var addressType:ListeningEventAddressType;
}

/**
	`addressType` for `ListeningEventAddress`:
	- `4` / `6` — TCPv4 / TCPv6
	- `-1` — Unix domain socket
	- `"udp4"` / `"udp6"` — UDPv4 / UDPv6
**/
enum abstract ListeningEventAddressType(EitherType<Int, String>) to EitherType<Int, String> {
	var TCPv4 = 4;
	var TCPv6 = 6;
	var Unix = -1;
	var UDPv4 = "udp4";
	var UDPv6 = "udp6";
}

/**
	Scheduling policy for distributing connections across workers.

	`SCHED_RR` is the default on all platforms except Windows.
	Can also be set via `NODE_CLUSTER_SCHED_POLICY` (`rr` / `none`).

	@see https://nodejs.org/docs/latest-v24.x/api/cluster.html#clusterschedulingpolicy
**/
@:jsRequire("cluster")
extern enum abstract ClusterSchedulingPolicy(Int) {
	var SCHED_NONE;
	var SCHED_RR;
}

/**
	The `node:cluster` module allows easy creation of child processes that all share server ports.

	Stability: 2 - Stable

	@see https://nodejs.org/docs/latest-v24.x/api/cluster.html
**/
@:jsRequire("cluster")
extern class Cluster extends EventEmitter<Cluster> {
	/**
		A reference to the `Cluster` object returned by the Node.js module.

		Import into a local name with: `import js.node.Cluster.instance in cluster`
	**/
	public static inline final instance:Cluster = cast Cluster;

	/**
		The scheduling policy, either `SCHED_RR` for round-robin
		or `SCHED_NONE` to leave it to the operating system.

		Global setting; frozen once the first worker is spawned or `setupPrimary`
		is called, whichever comes first.
	**/
	var schedulingPolicy:ClusterSchedulingPolicy;

	/**
		Settings after `setupPrimary` (or `fork`), including defaults.

		Not intended to be changed or set manually.
	**/
	var settings(default, null):ClusterSettings;

	/**
		Deprecated alias for `isPrimary`.

		@since v0.8.1
		@deprecated since v16.0.0
	**/
	@:deprecated("Use isPrimary instead")
	var isMaster(default, null):Bool;

	/**
		`true` if the process is a primary.

		Determined by `process.env.NODE_UNIQUE_ID`.
		If that variable is undefined, then `isPrimary` is `true`.
	**/
	var isPrimary(default, null):Bool;

	/**
		`true` if the process is not a primary (negation of `isPrimary`).
	**/
	var isWorker(default, null):Bool;

	/**
		Deprecated alias for `setupPrimary`.

		@since v0.7.1
		@deprecated since v16.0.0
	**/
	@:deprecated("Use setupPrimary instead")
	function setupMaster(?settings:ClusterSettings):Void;

	/**
		Change the default `fork` behavior. After calling, values are present in `settings`.

		Only affects future `fork` calls; already-running workers are unchanged.
		The only worker attribute that cannot be set here is the `env` passed to `fork`.

		Can only be called from the primary process.
	**/
	function setupPrimary(?settings:ClusterSettings):Void;

	/**
		Spawn a new worker process.

		Can only be called from the primary process.
	**/
	function fork(?env:DynamicAccess<String>):Worker;

	/**
		Calls `disconnect` on each worker in `workers`.

		When they are disconnected, internal handles close so the primary can exit
		gracefully if nothing else is waiting.

		Can only be called from the primary process.
	**/
	function disconnect(?callback:() -> Void):Void;

	/**
		Reference to the current worker object.

		Not available in the primary process.
	**/
	var worker(default, null):Worker;

	/**
		Active worker objects keyed by `id`.

		Only available in the primary process.
		A worker is removed after it has disconnected and exited.
	**/
	var workers(default, null):DynamicAccess<Worker>;
}

/**
	Options for `setupPrimary` / reflected in `Cluster.settings`.

	@see https://nodejs.org/docs/latest-v24.x/api/cluster.html#clustersettings
**/
typedef ClusterSettings = {
	/**
		Arguments passed to the Node.js executable.
		Default: `process.execArgv`
	**/
	@:optional var execArgv:Array<String>;

	/**
		File path to the worker file.
		Default: `process.argv[1]`
	**/
	@:optional var exec:String;

	/**
		Arguments passed to the worker.
		Default: `process.argv.slice(2)`
	**/
	@:optional var args:Array<String>;

	/**
		Current working directory of the worker process.
		Default: `undefined` (inherits from parent).
	**/
	@:optional var cwd:String;

	/**
		Serialization used for IPC messages (`json` or `advanced`).
	**/
	@:optional var serialization:ChildProcessSerialization;

	/**
		Whether to send worker output to the parent's stdio.
		Default: `false`
	**/
	@:optional var silent:Bool;

	/**
		Stdio configuration for forked processes.

		Must contain an `'ipc'` entry. When provided, overrides `silent`.
	**/
	@:optional var stdio:ChildProcessSpawnOptionsStdio;

	/**
		User identity of the process (`setuid(2)`).
	**/
	@:optional var uid:Int;

	/**
		Group identity of the process (`setgid(2)`).
	**/
	@:optional var gid:Int;

	/**
		Inspector port of the worker.

		A number, or a zero-argument function that returns a number.
		Default: each worker gets its own port, incremented from the primary's `process.debugPort`.
	**/
	@:optional var inspectPort:EitherType<Int, () -> Int>;

	/**
		Hide the forked process console window on Windows.
		Default: `false`
	**/
	@:optional var windowsHide:Bool;
}
