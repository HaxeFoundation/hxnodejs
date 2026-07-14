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
import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;
import js.lib.Error;
import js.node.child_process.ChildProcess.ChildProcessSendOptions;
import js.node.events.EventEmitter;
import js.node.process.ProcessFinalization;
import js.node.process.ProcessPermission;
import js.node.stream.Readable.IReadable;
import js.node.stream.Writable.IWritable;

/**
	Enumeration of events emitted by the Process class.
**/
enum abstract ProcessEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when the process is about to exit.
		There is no way to prevent the exiting of the event loop at this point,
		and once all exit listeners have finished running the process will exit.
		Therefore you must only perform synchronous operations in this handler.
		This is a good hook to perform checks on the module's state (like for unit tests).
		The callback takes one argument, the code the process is exiting with.
	**/
	var Exit:ProcessEvent<Int->Void> = "exit";

	/**
		Emitted when node empties its event loop and has nothing else to schedule.
	**/
	var BeforeExit:ProcessEvent<Int->Void> = "beforeExit";

	/**
		Emitted when an exception bubbles all the way back to the event loop.
		If a listener is added for this exception, the default action (which is to print a stack trace and exit)
		will not occur.
	**/
	var UncaughtException:ProcessEvent<Error->Void> = "uncaughtException";

	/**
		This event is emitted before an `'uncaughtException'` event is emitted or a hook installed via
		`process.setUncaughtExceptionCaptureCallback()` is called.
	**/
	var UncaughtExceptionMonitor:ProcessEvent<Error->Void> = "uncaughtExceptionMonitor";

	/**
		Emitted whenever a `Promise` is rejected and no error handler is attached to the promise within a turn of the event loop.
	**/
	var UnhandledRejection:ProcessEvent<(reason:Dynamic, promise:js.lib.Promise<Dynamic>) -> Void> = "unhandledRejection";

	/**
		Emitted whenever a `Promise` has been rejected and an error handler was attached to it later than after an event loop turn.
	**/
	var RejectionHandled:ProcessEvent<(promise:js.lib.Promise<Dynamic>) -> Void> = "rejectionHandled";

	/**
		The `process` object emits a `'warning'` event whenever Node.js emits a process warning.
	**/
	var Warning:ProcessEvent<(warning:Error) -> Void> = "warning";

	/**
		Emitted when a message is received over IPC. Available for child processes.
	**/
	var Message:ProcessEvent<(message:Dynamic, sendHandle:Dynamic) -> Void> = "message";

	/**
		Emitted after calling `process.disconnect()` in a child process.
	**/
	var Disconnect:ProcessEvent<Void->Void> = "disconnect";
}

extern class Process extends EventEmitter<Process> {
	/**
		A Writable Stream to stdout.
	**/
	var stdout:IWritable;

	/**
		A writable stream to stderr.
	**/
	var stderr:IWritable;

	/**
		A Readable Stream for stdin.
	**/
	var stdin:IReadable;

	/**
		An array containing the command line arguments.
	**/
	var argv:Array<String>;

	/**
		The `process.argv0` property stores a read-only copy of the original value of `argv[0]`
		passed when Node.js starts.
	**/
	var argv0(default, null):String;

	/**
		This is the absolute pathname of the executable that started the process.
	**/
	var execPath:String;

	/**
		This is the set of node-specific command line options from the executable that started the process.
	**/
	var execArgv:Array<String>;

	/**
		If the Node.js process is spawned with an IPC channel, `process.connected` is `true` while connected.
	**/
	var connected(default, null):Bool;

	/**
		This causes node to emit an abort. This will cause node to exit and generate a core file.
	**/
	function abort():Void;

	/**
		Changes the current working directory of the process or throws an exception if that fails.
	**/
	function chdir(directory:String):Void;

	/**
		Returns the current working directory of the process.
	**/
	function cwd():String;

	/**
		An object containing the user environment. See environ(7).
	**/
	var env:DynamicAccess<String>;

	/**
		Ends the process with the specified `code`. If the `code` is omitted, exit uses either the
		'success' code `0` or the value of `process.exitCode` if specified.
	**/
	function exit(?code:Int):Void;

	/**
		A number which will be the process exit code, when the process either exits gracefully,
		or is exited via `process.exit()` without specifying a code.
	**/
	var exitCode:Null<Int>;

	/**
		Gets the group identity of the process. See getgid(2).
		Note: this function is only available on POSIX platforms (i.e. not Windows)
	**/
	function getgid():Int;

	/**
		Sets the group identity of the process. See setgid(2).
	**/
	@:overload(function(id:String):Void {})
	function setgid(id:Int):Void;

	/**
		Gets the user identity of the process. See getuid(2).
	**/
	function getuid():Int;

	/**
		Sets the user identity of the process. See setuid(2).
	**/
	@:overload(function(id:String):Void {})
	function setuid(id:Int):Void;

	/**
		Gets the effective group identity of the process. See getegid(2).
	**/
	function getegid():Int;

	/**
		Sets the effective group identity of the process. See setegid(2).
	**/
	@:overload(function(id:String):Void {})
	function setegid(id:Int):Void;

	/**
		Gets the effective user identity of the process. See geteuid(2).
	**/
	function geteuid():Int;

	/**
		Sets the effective user identity of the process. See seteuid(2).
	**/
	@:overload(function(id:String):Void {})
	function seteuid(id:Int):Void;

	/**
		Returns an array with the supplementary group IDs.
	**/
	function getgroups():Array<Int>;

	/**
		Sets the supplementary group IDs.
	**/
	function setgroups(groups:Array<EitherType<String, Int>>):Void;

	/**
		Reads /etc/group and initializes the group access list.
	**/
	function initgroups(user:EitherType<String, Int>, extra_group:EitherType<String, Int>):Void;

	/**
		A compiled-in property that exposes NODE_VERSION.
	**/
	var version(default, null):String;

	/**
		A property exposing version strings of node and its dependencies.
	**/
	var versions:DynamicAccess<String>;

	/**
		An Object containing the JavaScript representation of the configure options that were used to compile the current node executable.
	**/
	var config:DynamicAccess<Dynamic>;

	/**
		IPC channel reference for the process, if present.
		// TODO(section-5): refine IPC channel type when child_process IPC is audited.
	**/
	var channel(default, null):Null<Dynamic>;

	/**
		The debugger port of the Node.js process.
	**/
	var debugPort:Int;

	/**
		Send a signal to a process.
	**/
	function kill(pid:Int, ?signal:EitherType<String, Int>):Bool;

	/**
		The PID of the process.
	**/
	var pid(default, null):Int;

	/**
		Getter/setter to set what is displayed in 'ps'.
	**/
	var title:String;

	/**
		What processor architecture you're running on: 'arm', 'ia32', or 'x64'.
	**/
	var arch:String;

	/**
		What platform you're running on: 'darwin', 'freebsd', 'linux', 'sunos' or 'win32'
	**/
	var platform:String;

	/**
		The PID of the parent process
	**/
	var ppid:Int;

	/**
		The metadata of the current release
	**/
	var release:Release;

	/**
		Used for diagnostic reports
	**/
	var report:Report;

	/**
		Permission model API when the process is started with `--permission`.
		`null` / unavailable when the permission model is not enabled.
	**/
	var permission(default, null):Null<ProcessPermission>;

	/**
		Provides APIs for registering callbacks invoked during process finalization.
	**/
	var finalization(default, null):ProcessFinalization;

	/**
		A boolean reflecting whether the current Node.js process is running with `--pending-deprecation` enabled.
	**/
	var noDeprecation:Bool;

	/**
		Enable logging of deprecation warnings.
	**/
	var traceDeprecation:Bool;

	/**
		Throw on deprecated API usage.
	**/
	var throwDeprecation:Bool;

	/**
		A boolean value that indicates whether source maps are enabled for Node stacks.
	**/
	var sourceMapsEnabled(default, null):Bool;

	/**
		A set of flags from `NODE_OPTIONS` and command-line that Node.js allows.
	**/
	var allowedNodeEnvironmentFlags(default, null):js.lib.Set<String>;

	/**
		Provides a way to get available features known at compile/runtime.
	**/
	var features(default, null):ProcessFeatures;

	/**
		Returns an object describing the memory usage of the Node process measured in bytes.
	**/
	function memoryUsage():MemoryUsage;

	/**
		Returns the resident set size (RSS) used by the process in bytes.
	**/
	@:native("memoryUsage.rss")
	function memoryUsageRss():Float;

	/**
		Returns information about the V8 heap spaces and usage of process resources.
	**/
	function resourceUsage():ResourceUsage;

	/**
		Returns the user and system CPU time usage of the current process, in microseconds.
	**/
	function cpuUsage(?previousValue:CpuUsage):CpuUsage;

	/**
		Gets the amount of free memory that is still available to the process, in bytes.
		May return `undefined`/`0` if not supported.
	**/
	function availableMemory():Float;

	/**
		Gets the amount of memory available to the process (based on cgroup / ulimit etc.).
		May return `undefined` if not constrained.
	**/
	function constrainedMemory():Float;

	/**
		Returns an array of strings naming active resources currently keeping the event loop alive.
	**/
	function getActiveResourcesInfo():Array<String>;

	/**
		On the next loop around the event loop call this callback.
	**/
	function nextTick(callback:Void->Void, args:Rest<Dynamic>):Void;

	/**
		Sets or reads the process's file mode creation mask.
	**/
	function umask(?mask:Int):Int;

	/**
		Number of seconds Node has been running.
	**/
	function uptime():Float;

	/**
		Returns the current high-resolution real time in a `[seconds, nanoseconds]` tuple Array.
	**/
	@:overload(function(prev:Array<Float>):Array<Float> {})
	function hrtime():Array<Float>;

	/**
		The `bigint` version of `process.hrtime()` that returns nanoseconds as a `bigint`.
		Typed as `Dynamic` for Haxe 4.0.5 compatibility (no `js.lib.BigInt` there).
	**/
	@:native("hrtime.bigint")
	function hrtimeBigint():Dynamic;

	/**
		Alternate way to retrieve require.main.
		@deprecated Use `Require.main` instead.
	**/
	@:deprecated
	var mainModule(default, null):Module;

	/**
		Send a message to the parent process.
		Only available for child processes. See `ChildProcess.send`.
		// TODO(section-5): type `sendHandle` with net.Socket / net.Server / dgram.Socket.
	**/
	@:overload(function(message:Dynamic, sendHandle:Dynamic, options:ChildProcessSendOptions, ?callback:Null<Error>->Void):Bool {})
	@:overload(function(message:Dynamic, sendHandle:Dynamic, ?callback:Null<Error>->Void):Bool {})
	function send(message:Dynamic, ?callback:Null<Error>->Void):Bool;

	/**
		Close the IPC channel to parent process.
	**/
	function disconnect():Void;

	/**
		The `process.emitWarning()` method can be used to emit custom or application specific process warnings.
	**/
	@:overload(function(warning:String, ?type:String, ?code:String, ?ctor:Function):Void {})
	@:overload(function(warning:String, options:EmitWarningOptions):Void {})
	function emitWarning(warning:EitherType<String, Error>, ?type:String, ?code:String, ?ctor:Function):Void;

	/**
		Loads environment variables from a `.env` file into `process.env`.
	**/
	function loadEnvFile(?path:String):Void;

	/**
		Returns the built-in module with the given `id`, or `undefined` if not found.
	**/
	function getBuiltinModule(id:String):Dynamic;

	/**
		Sets a user-provided function as the uncaughtException capture callback.
	**/
	function setUncaughtExceptionCaptureCallback(fn:Null<Error->Void>):Void;

	/**
		Indicates whether a callback has been set using `setUncaughtExceptionCaptureCallback`.
	**/
	function hasUncaughtExceptionCaptureCallback():Bool;

	/**
		Enable or disable Source Map v3 support for stack traces.
	**/
	function setSourceMapsEnabled(value:Bool):Void;

	/**
		Reference a value that implements `Symbol.dispose` / ref counting so it keeps the event loop alive.
	**/
	function ref(maybeRefable:Dynamic):Void;

	/**
		Unreference a previously referenced value.
	**/
	function unref(maybeRefable:Dynamic):Void;

	/**
		Returns the CPU usage statistics of the current worker thread.
	**/
	function threadCpuUsage(?previousValue:CpuUsage):CpuUsage;
}

typedef MemoryUsage = {
	rss:Float,
	heapTotal:Float,
	heapUsed:Float,
	?external:Float,
	?arrayBuffers:Float
}

typedef CpuUsage = {
	user:Float,
	system:Float
}

typedef ResourceUsage = {
	userCPUTime:Float,
	systemCPUTime:Float,
	maxRSS:Float,
	sharedMemorySize:Float,
	unsharedDataSize:Float,
	unsharedStackSize:Float,
	minorPageFault:Float,
	majorPageFault:Float,
	swappedOut:Float,
	fsRead:Float,
	fsWrite:Float,
	ipcSent:Float,
	ipcReceived:Float,
	signalsCount:Float,
	voluntaryContextSwitches:Float,
	involuntaryContextSwitches:Float
}

typedef Release = {
	name:String,
	?sourceUrl:String,
	?headersUrl:String,
	?libUrl:String,
	?lts:String
}

typedef EmitWarningOptions = {
	@:optional var type:String;
	@:optional var code:String;
	@:optional var detail:String;
	@:optional var ctor:Function;
}

/**
	Boolean flags describing process feature availability.

	@see https://nodejs.org/api/process.html#processfeatures
**/
typedef ProcessFeatures = {
	var inspector(default, null):Bool;
	var debug(default, null):Bool;
	var uv(default, null):Bool;
	var ipv6(default, null):Bool;
	var tls(default, null):Bool;
	var tls_alpn(default, null):Bool;
	var tls_ocsp(default, null):Bool;
	var tls_sni(default, null):Bool;
	@:optional var typescript(default, null):EitherType<Bool, String>;
	@:optional var require_module(default, null):Bool;
	@:optional var cached_builtins(default, null):Bool;
}
