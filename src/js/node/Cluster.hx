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

package js.node;

import haxe.DynamicAccess;
import js.node.ChildProcess.ChildProcessSerialization;
import js.node.ChildProcess.ChildProcessSpawnOptionsStdio;
import js.node.cluster.Worker;
import js.node.events.EventEmitter;

/**
	@see https://nodejs.org/docs/latest-v24.x/api/cluster.html
**/
enum abstract ClusterEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		When a new worker is forked the cluster module will emit a 'fork' event.
		This can be used to log worker activity, and create your own timeout.
	**/
	var Fork:ClusterEvent<Worker->Void> = "fork";

	/**
		After forking a new worker, the worker should respond with an online message.
		When the primary receives an online message it will emit this event.
	**/
	var Online:ClusterEvent<Worker->Void> = "online";

	/**
		After calling `listen` from a worker, when the 'listening' event is emitted on the server,
		a listening event will also be emitted on cluster in the primary.
	**/
	var Listening:ClusterEvent<Worker->ListeningEventAddress->Void> = "listening";

	/**
		Emitted after the worker IPC channel has disconnected.
	**/
	var Disconnect:ClusterEvent<Worker->Void> = "disconnect";

	/**
		When any of the workers die the cluster module will emit the 'exit' event.
	**/
	var Exit:ClusterEvent<Worker->Int->String->Void> = "exit";

	/**
		Emitted every time `setupPrimary` is called.
	**/
	var Setup:ClusterEvent<ClusterSettings->Void> = "setup";

	/**
		Emitted when any worker receives a message.

		// TODO(section-5): tighten message/handle typing beyond Dynamic
	**/
	var Message:ClusterEvent<Worker->Dynamic->Dynamic->Void> = "message";
}

/**
	Structure emitted by 'listening' event.
**/
typedef ListeningEventAddress = {
	var address:String;
	var port:Int;
	var addressType:ListeningEventAddressType;
}

enum abstract ListeningEventAddressType(haxe.extern.EitherType<Int, String>) to haxe.extern.EitherType<Int, String> {
	var TCPv4 = 4;
	var TCPv6 = 6;
	var Unix = -1;
	var UDPv4 = "udp4";
	var UDPv6 = "udp6";
}

@:jsRequire("cluster")
extern enum abstract ClusterSchedulingPolicy(Int) {
	var SCHED_NONE;
	var SCHED_RR;
}

/**
	The cluster module allows easy creation of child processes that all share server ports.

	@see https://nodejs.org/docs/latest-v24.x/api/cluster.html
**/
@:jsRequire("cluster")
extern class Cluster extends EventEmitter<Cluster> {
	/**
		A reference to the `Cluster` object returned by node.js module.

		It can be imported into module namespace by using: "import js.node.Cluster.instance in cluster"
	**/
	public static inline var instance:Cluster = cast Cluster;

	/**
		The scheduling policy, either `SCHED_RR` for round-robin
		or `SCHED_NONE` to leave it to the operating system.
	**/
	var schedulingPolicy:ClusterSchedulingPolicy;

	/**
		After calling `setupPrimary` (or `fork`) this settings object will contain the settings,
		including the default values.
	**/
	var settings(default, null):ClusterSettings;

	/**
		True if the process is a primary.
		Deprecated alias for `isPrimary`.
	**/
	@:deprecated("Use isPrimary instead")
	var isMaster(default, null):Bool;

	/**
		True if the process is a primary.
		This is determined by the process.env.NODE_UNIQUE_ID.
		If process.env.NODE_UNIQUE_ID is undefined, then `isPrimary` is true.
	**/
	var isPrimary(default, null):Bool;

	/**
		True if the process is not a primary (it is the negation of `isPrimary`).
	**/
	var isWorker(default, null):Bool;

	/**
		Deprecated alias for `setupPrimary`.
	**/
	@:deprecated("Use setupPrimary instead")
	function setupMaster(?settings:ClusterSettings):Void;

	/**
		Used to change the default `fork` behavior. Once called, the settings will be present in `settings`.
	**/
	function setupPrimary(?settings:ClusterSettings):Void;

	/**
		Spawn a new worker process. This can only be called from the primary process.
	**/
	function fork(?env:DynamicAccess<String>):Worker;

	/**
		Calls `disconnect` on each worker in `workers`.
	**/
	function disconnect(?callback:Void->Void):Void;

	/**
		A reference to the current worker object. Not available in the primary process.
	**/
	var worker(default, null):Worker;

	/**
		A hash that stores the active worker objects, keyed by `id` field.
		It is only available in the primary process.
	**/
	var workers(default, null):DynamicAccess<Worker>;
}

typedef ClusterSettings = {
	/**
		list of string arguments passed to the node executable.
		Default: process.execArgv
	**/
	@:optional var execArgv:Array<String>;

	/**
		file path to worker file.
		Default: process.argv[1]
	**/
	@:optional var exec:String;

	/**
		string arguments passed to worker.
		Default: process.argv.slice(2)
	**/
	@:optional var args:Array<String>;

	/**
		Current working directory of the worker process.
		Default: `undefined` (inherits from parent process).
	**/
	@:optional var cwd:String;

	/**
		Specify the kind of serialization used for sending messages between processes.
	**/
	@:optional var serialization:ChildProcessSerialization;

	/**
		whether or not to send output to parent's stdio.
		Default: false
	**/
	@:optional var silent:Bool;

	/**
		Configures the stdio of forked processes.
		Must contain an `'ipc'` entry. When provided, overrides `silent`.
	**/
	@:optional var stdio:ChildProcessSpawnOptionsStdio;

	/**
		Sets the user identity of the process.
	**/
	@:optional var uid:Int;

	/**
		Sets the group identity of the process.
	**/
	@:optional var gid:Int;

	/**
		Sets inspector port of worker. Can be a number, or a function that returns a number.
	**/
	// TODO(section-5): model inspectPort callback `() -> Int` without losing Int assignability
	@:optional var inspectPort:haxe.extern.EitherType<Int, Void->Int>;

	/**
		Hide the forked processes console window that would normally be created on Windows.
		Default: `false`.
	**/
	@:optional var windowsHide:Bool;
}
