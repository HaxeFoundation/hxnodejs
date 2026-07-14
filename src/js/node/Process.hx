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

import haxe.Constraints.Function;
import haxe.DynamicAccess;
import haxe.extern.EitherType;
import haxe.extern.Rest;
import js.lib.Error;
import js.lib.Promise;
import js.lib.Set;
import js.node.child_process.ChildProcess.ChildProcessChannel;
import js.node.child_process.ChildProcess.ChildProcessSendHandle;
import js.node.child_process.ChildProcess.ChildProcessSendOptions;
import js.node.events.EventEmitter;
import js.node.process.ProcessFinalization;
import js.node.process.ProcessPermission;
import js.node.stream.Readable.IReadable;
import js.node.stream.Writable.IWritable;
import js.node.worker_threads.Worker as WorkerThread;

/**
	Events emitted by the `process` object.

	POSIX signal events (`'SIGINT'`, `'SIGTERM'`, …) are also emitted; listen with
	`process.on('SIGINT', handler)` (listener receives the signal name).

	@see https://nodejs.org/api/process.html#process-events
**/
enum abstract ProcessEvent<T:Function>(Event<T>) to Event<T> {
	/**
		Emitted when the process is about to exit.
		There is no way to prevent the exiting of the event loop at this point,
		and once all `'exit'` listeners have finished running the process will exit.
		Therefore you must only perform synchronous operations in this handler.

		@see https://nodejs.org/api/process.html#event-exit
	**/
	var Exit:ProcessEvent<Int->Void> = "exit";

	/**
		Emitted when Node.js empties its event loop and has nothing else to schedule.
		Not emitted for conditions causing explicit termination such as `process.exit()`.

		@see https://nodejs.org/api/process.html#event-beforeexit
	**/
	var BeforeExit:ProcessEvent<Int->Void> = "beforeExit";

	/**
		Emitted when an exception bubbles all the way back to the event loop.
		If a listener is added for this exception, the default action
		(print a stack trace and exit) will not occur.

		`origin` is `'uncaughtException'` or `'unhandledRejection'`.

		@see https://nodejs.org/api/process.html#event-uncaughtexception
	**/
	var UncaughtException:ProcessEvent<(error:Error, origin:String) -> Void> = "uncaughtException";

	/**
		Emitted before an `'uncaughtException'` event is emitted or a hook installed via
		`process.setUncaughtExceptionCaptureCallback()` is called.
		Installing this listener does not change the default crash behavior.

		@see https://nodejs.org/api/process.html#event-uncaughtexceptionmonitor
	**/
	var UncaughtExceptionMonitor:ProcessEvent<(error:Error, origin:String) -> Void> = "uncaughtExceptionMonitor";

	/**
		Emitted whenever a `Promise` is rejected and no error handler is attached
		within a turn of the event loop.

		@see https://nodejs.org/api/process.html#event-unhandledrejection
	**/
	var UnhandledRejection:ProcessEvent<(reason:Any, promise:Promise<Any>) -> Void> = "unhandledRejection";

	/**
		Emitted whenever a `Promise` has been rejected and an error handler was attached
		to it later than after an event loop turn.

		@see https://nodejs.org/api/process.html#event-rejectionhandled
	**/
	var RejectionHandled:ProcessEvent<(promise:Promise<Any>) -> Void> = "rejectionHandled";

	/**
		Emitted whenever Node.js emits a process warning.

		@see https://nodejs.org/api/process.html#event-warning
	**/
	var Warning:ProcessEvent<(warning:Error) -> Void> = "warning";

	/**
		Emitted when a message is received over IPC. Available for child processes.

		@see https://nodejs.org/api/process.html#event-message
	**/
	var Message:ProcessEvent<(message:Any, sendHandle:Null<ChildProcessSendHandle>) -> Void> = "message";

	/**
		Emitted after calling `process.disconnect()` in a child process.

		@see https://nodejs.org/api/process.html#event-disconnect
	**/
	var Disconnect:ProcessEvent<Void->Void> = "disconnect";

	/**
		Emitted after a new worker thread has been created.

		@see https://nodejs.org/api/process.html#event-worker
	**/
	var Worker:ProcessEvent<(worker:WorkerThread) -> Void> = "worker";

	/**
		Emitted for messages sent with `worker_threads.postMessageToThread()`.

		@see https://nodejs.org/api/process.html#event-workermessage
	**/
	var WorkerMessage:ProcessEvent<(value:Any, source:Int) -> Void> = "workerMessage";

	/**
		Emitted when a `Promise` is resolved or rejected more than once.
		Unreliable (e.g. with `Promise.race`); prefer not to rely on this event.

		@see https://nodejs.org/api/process.html#event-multipleresolves
	**/
	@:deprecated("Deprecated since Node 17; unreliable for Promise.race and similar")
	var MultipleResolves:ProcessEvent<(type:String, promise:Promise<Any>, value:Any) -> Void> = "multipleResolves";
}

/**
	The `process` object — information about and control over the current Node.js process.

	@see https://nodejs.org/api/process.html
**/
extern class Process extends EventEmitter<Process> {
	/**
		A writable stream to stdout.

		@see https://nodejs.org/api/process.html#processstdout
	**/
	var stdout:IWritable;

	/**
		A writable stream to stderr.

		@see https://nodejs.org/api/process.html#processstderr
	**/
	var stderr:IWritable;

	/**
		A readable stream for stdin.

		@see https://nodejs.org/api/process.html#processstdin
	**/
	var stdin:IReadable;

	/**
		An array containing the command-line arguments.

		@see https://nodejs.org/api/process.html#processargv
	**/
	var argv:Array<String>;

	/**
		A read-only copy of the original value of `argv[0]` passed when Node.js starts.

		@see https://nodejs.org/api/process.html#processargv0
	**/
	var argv0(default, null):String;

	/**
		Absolute pathname of the executable that started the process.

		@see https://nodejs.org/api/process.html#processexecpath
	**/
	var execPath:String;

	/**
		Node-specific command-line options from the executable that started the process.

		@see https://nodejs.org/api/process.html#processexecargv
	**/
	var execArgv:Array<String>;

	/**
		`true` while an IPC channel to the parent exists and is connected.

		@see https://nodejs.org/api/process.html#processconnected
	**/
	var connected(default, null):Bool;

	/**
		Causes the Node.js process to emit an abort and generate a core file.

		@see https://nodejs.org/api/process.html#processabort
	**/
	function abort():Void;

	/**
		Changes the current working directory of the process or throws if that fails.

		@see https://nodejs.org/api/process.html#processchdirdirectory
	**/
	function chdir(directory:String):Void;

	/**
		Returns the current working directory of the process.

		@see https://nodejs.org/api/process.html#processcwd
	**/
	function cwd():String;

	/**
		User environment. See environ(7).

		@see https://nodejs.org/api/process.html#processenv
	**/
	var env:DynamicAccess<String>;

	/**
		Ends the process with the specified `code`. If omitted, uses `0` or `process.exitCode`.
		String values must be integer strings (e.g. `'1'`).

		@see https://nodejs.org/api/process.html#processexitcode
	**/
	function exit(?code:EitherType<Int, String>):Void;

	/**
		Process exit code used when the process exits gracefully or via `process.exit()`
		without a code argument. Integer strings are allowed.

		@see https://nodejs.org/api/process.html#processexitcode_1
	**/
	var exitCode:Null<EitherType<Int, String>>;

	/**
		Gets the group identity of the process. See getgid(2).
		Only available on POSIX platforms (not Windows).

		@see https://nodejs.org/api/process.html#processgetgid
	**/
	function getgid():Int;

	/**
		Sets the group identity of the process. See setgid(2).

		@see https://nodejs.org/api/process.html#processsetgidid
	**/
	@:overload(function(id:String):Void {})
	function setgid(id:Int):Void;

	/**
		Gets the user identity of the process. See getuid(2).

		@see https://nodejs.org/api/process.html#processgetuid
	**/
	function getuid():Int;

	/**
		Sets the user identity of the process. See setuid(2).

		@see https://nodejs.org/api/process.html#processsetuidid
	**/
	@:overload(function(id:String):Void {})
	function setuid(id:Int):Void;

	/**
		Gets the effective group identity of the process. See getegid(2).

		@see https://nodejs.org/api/process.html#processgetegid
	**/
	function getegid():Int;

	/**
		Sets the effective group identity of the process. See setegid(2).

		@see https://nodejs.org/api/process.html#processsetegidid
	**/
	@:overload(function(id:String):Void {})
	function setegid(id:Int):Void;

	/**
		Gets the effective user identity of the process. See geteuid(2).

		@see https://nodejs.org/api/process.html#processgeteuid
	**/
	function geteuid():Int;

	/**
		Sets the effective user identity of the process. See seteuid(2).

		@see https://nodejs.org/api/process.html#processseteuidid
	**/
	@:overload(function(id:String):Void {})
	function seteuid(id:Int):Void;

	/**
		Returns an array with the supplementary group IDs.

		@see https://nodejs.org/api/process.html#processgetgroups
	**/
	function getgroups():Array<Int>;

	/**
		Sets the supplementary group IDs.

		@see https://nodejs.org/api/process.html#processsetgroupsgroups
	**/
	function setgroups(groups:Array<EitherType<String, Int>>):Void;

	/**
		Reads `/etc/group` and initializes the group access list.

		@see https://nodejs.org/api/process.html#processinitgroupsuser-extragroup
	**/
	function initgroups(user:EitherType<String, Int>, extraGroup:EitherType<String, Int>):Void;

	/**
		Compiled-in Node.js version string (`NODE_VERSION`).

		@see https://nodejs.org/api/process.html#processversion
	**/
	var version(default, null):String;

	/**
		Version strings of Node.js and its dependencies.

		@see https://nodejs.org/api/process.html#processversions
	**/
	var versions:DynamicAccess<String>;

	/**
		JavaScript representation of the configure options used to compile the current Node.js executable.

		@see https://nodejs.org/api/process.html#processconfig
	**/
	var config:DynamicAccess<Any>;

	/**
		IPC channel reference for the process, if present.

		@see https://nodejs.org/api/process.html#processchannel
	**/
	var channel(default, null):Null<ChildProcessChannel>;

	/**
		Debugger port of the Node.js process.

		@see https://nodejs.org/api/process.html#processdebugport
	**/
	var debugPort:Int;

	/**
		Sends a signal to a process. Returns `true` if successful.

		@see https://nodejs.org/api/process.html#processkillpid-signal
	**/
	function kill(pid:Int, ?signal:EitherType<String, Int>):Bool;

	/**
		PID of the process.

		@see https://nodejs.org/api/process.html#processpid
	**/
	var pid(default, null):Int;

	/**
		Getter/setter for what is displayed in `ps`.

		@see https://nodejs.org/api/process.html#processtitle
	**/
	var title:String;

	/**
		CPU architecture: `'arm'`, `'arm64'`, `'ia32'`, `'x64'`, etc.

		@see https://nodejs.org/api/process.html#processarch
	**/
	var arch:String;

	/**
		Operating system platform: `'darwin'`, `'linux'`, `'win32'`, etc.

		@see https://nodejs.org/api/process.html#processplatform
	**/
	var platform:String;

	/**
		PID of the parent process.

		@see https://nodejs.org/api/process.html#processppid
	**/
	var ppid:Int;

	/**
		Metadata about the current Node.js release.

		@see https://nodejs.org/api/process.html#processrelease
	**/
	var release:Release;

	/**
		Diagnostic report API.

		@see https://nodejs.org/api/process.html#processreport
	**/
	var report:Report;

	/**
		Permission model API when started with `--permission`.
		`null` / unavailable when the permission model is not enabled.

		@see https://nodejs.org/api/process.html#processpermission
	**/
	var permission(default, null):Null<ProcessPermission>;

	/**
		APIs for registering callbacks invoked during process finalization.

		@see https://nodejs.org/api/process.html#processfinalization
	**/
	var finalization(default, null):ProcessFinalization;

	/**
		Whether the process is running with `--pending-deprecation` / related flags
		that suppress reporting of certain deprecations.

		@see https://nodejs.org/api/process.html#processnodeprecation
	**/
	var noDeprecation:Bool;

	/**
		Whether `--trace-deprecation` is set.

		@see https://nodejs.org/api/process.html#processtracedeprecation
	**/
	var traceDeprecation:Bool;

	/**
		Whether `--trace-warnings` is set. Can be toggled at runtime.

		@see https://nodejs.org/api/process.html#processtraceprocesswarnings
	**/
	var traceProcessWarnings:Bool;

	/**
		Whether deprecated API usage should throw.

		@see https://nodejs.org/api/process.html#processthrowdeprecation
	**/
	var throwDeprecation:Bool;

	/**
		Whether Source Map v3 support for stack traces is enabled.

		@see https://nodejs.org/api/process.html#processsourcemapsenabled
	**/
	var sourceMapsEnabled(default, null):Bool;

	/**
		Flags from `NODE_OPTIONS` and the command line that Node.js allows.

		@see https://nodejs.org/api/process.html#processallowednodeenvironmentflags
	**/
	var allowedNodeEnvironmentFlags(default, null):Set<String>;

	/**
		Compile/runtime feature availability flags.

		@see https://nodejs.org/api/process.html#processfeatures
	**/
	var features(default, null):ProcessFeatures;

	/**
		Memory usage of the Node.js process measured in bytes.

		@see https://nodejs.org/api/process.html#processmemoryusage
	**/
	function memoryUsage():MemoryUsage;

	/**
		Resident set size (RSS) used by the process in bytes.

		@see https://nodejs.org/api/process.html#processmemoryusagerss
	**/
	@:native("memoryUsage.rss")
	function memoryUsageRss():Float;

	/**
		V8 heap / resource usage statistics for the process.

		@see https://nodejs.org/api/process.html#processresourceusage
	**/
	function resourceUsage():ResourceUsage;

	/**
		User and system CPU time usage of the current process, in microseconds.

		@see https://nodejs.org/api/process.html#processcpuusagepreviousvalue
	**/
	function cpuUsage(?previousValue:CpuUsage):CpuUsage;

	/**
		Amount of free memory still available to the process, in bytes.

		@see https://nodejs.org/api/process.html#processavailablememory
	**/
	function availableMemory():Float;

	/**
		Memory available to the process based on cgroup / ulimit constraints, in bytes.
		May be unconstrained on some platforms.

		@see https://nodejs.org/api/process.html#processconstrainedmemory
	**/
	function constrainedMemory():Float;

	/**
		Names of active resources currently keeping the event loop alive.

		@see https://nodejs.org/api/process.html#processgetactiveresourcesinfo
	**/
	function getActiveResourcesInfo():Array<String>;

	/**
		Schedules `callback` to run on the next iteration of the event loop.

		@see https://nodejs.org/api/process.html#processnexttickcallback-args
	**/
	function nextTick(callback:Function, args:Rest<Any>):Void;

	/**
		Sets or reads the process file mode creation mask.
		Calling with no arguments is deprecated since Node 14.

		@see https://nodejs.org/api/process.html#processumask
	**/
	function umask(?mask:Int):Int;

	/**
		Number of seconds the Node.js process has been running.

		@see https://nodejs.org/api/process.html#processuptime
	**/
	function uptime():Float;

	/**
		Current high-resolution real time as a `[seconds, nanoseconds]` tuple.

		@see https://nodejs.org/api/process.html#processhrtimetime
	**/
	@:overload(function(prev:Array<Float>):Array<Float> {})
	function hrtime():Array<Float>;

	/**
		`bigint` form of `process.hrtime()`, returning nanoseconds as a JavaScript bigint.
		Typed as `Dynamic` until hxnodejs exposes a dedicated BigInt type.

		@see https://nodejs.org/api/process.html#processhrtimebigint
	**/
	@:native("hrtime.bigint")
	function hrtimeBigint():Dynamic;

	/**
		Alternate way to retrieve `require.main`.

		@see https://nodejs.org/api/process.html#processmainmodule
	**/
	@:deprecated("Use Require.main instead")
	var mainModule(default, null):Module;

	/**
		Sends a message to the parent process. Only available when spawned with an IPC channel.

		@see https://nodejs.org/api/process.html#processsendmessage-sendhandle-options-callback
	**/
	@:overload(function(message:Any, sendHandle:ChildProcessSendHandle, options:ChildProcessSendOptions, ?callback:Null<Error>->Void):Bool {})
	@:overload(function(message:Any, sendHandle:ChildProcessSendHandle, ?callback:Null<Error>->Void):Bool {})
	function send(message:Any, ?callback:Null<Error>->Void):Bool;

	/**
		Closes the IPC channel to the parent process.

		@see https://nodejs.org/api/process.html#processdisconnect
	**/
	function disconnect():Void;

	/**
		Emits a custom or application-specific process warning.

		@see https://nodejs.org/api/process.html#processemitwarningwarning-options
	**/
	@:overload(function(warning:String, ?type:String, ?code:String, ?ctor:Function):Void {})
	@:overload(function(warning:String, options:EmitWarningOptions):Void {})
	function emitWarning(warning:EitherType<String, Error>, ?type:String, ?code:String, ?ctor:Function):Void;

	/**
		Loads environment variables from a `.env` file into `process.env`.

		@see https://nodejs.org/api/process.html#processloadenvfilepath
	**/
	function loadEnvFile(?path:String):Void;

	/**
		Returns the built-in module with the given `id`, or `undefined` if not found.

		@see https://nodejs.org/api/process.html#processgetbuiltinmoduleid
	**/
	function getBuiltinModule(id:String):Any;

	/**
		Dynamically loads a shared object Addon. Prefer `require()` unless custom `flags` are needed.
		`module` must be an object with an `exports` property.

		@see https://nodejs.org/api/process.html#processdlopenmodule-filename-flags
	**/
	function dlopen(module:{exports:Any}, filename:String, ?flags:Int):Void;

	/**
		Replaces the current process using `execve(2)`. Does not return on success.
		Not available on Windows or IBM i. Experimental.

		@see https://nodejs.org/api/process.html#processexecvefile-args-env
	**/
	function execve(file:String, ?args:Array<String>, ?env:DynamicAccess<String>):Void;

	/**
		Sets a user-provided function as the uncaught-exception capture callback.
		Pass `null` to clear.

		@see https://nodejs.org/api/process.html#processsetuncaughtexceptioncapturecallbackfn
	**/
	function setUncaughtExceptionCaptureCallback(fn:Null<Error->Void>):Void;

	/**
		Whether a capture callback is currently set.

		@see https://nodejs.org/api/process.html#processhasuncaughtexceptioncapturecallback
	**/
	function hasUncaughtExceptionCaptureCallback():Bool;

	/**
		Enables or disables Source Map v3 support for stack traces.

		@see https://nodejs.org/api/process.html#processsetsourcemapsenabledval
	**/
	function setSourceMapsEnabled(value:Bool):Void;

	/**
		References a value that implements `Symbol.dispose` / ref counting so it keeps the event loop alive.

		@see https://nodejs.org/api/process.html#processrefmayberefable
	**/
	function ref(maybeRefable:Any):Void;

	/**
		Unreferences a previously referenced value.

		@see https://nodejs.org/api/process.html#processunrefmayberefable
	**/
	function unref(maybeRefable:Any):Void;

	/**
		CPU usage statistics of the current worker thread.

		@see https://nodejs.org/api/process.html#processthreadcpuusagepreviousvalue
	**/
	function threadCpuUsage(?previousValue:CpuUsage):CpuUsage;
}

/**
	@see https://nodejs.org/api/process.html#processmemoryusage
**/
typedef MemoryUsage = {
	var rss:Float;
	var heapTotal:Float;
	var heapUsed:Float;
	var external:Float;
	var arrayBuffers:Float;
}

/**
	@see https://nodejs.org/api/process.html#processcpuusagepreviousvalue
**/
typedef CpuUsage = {
	var user:Float;
	var system:Float;
}

/**
	@see https://nodejs.org/api/process.html#processresourceusage
**/
typedef ResourceUsage = {
	var userCPUTime:Float;
	var systemCPUTime:Float;
	var maxRSS:Float;
	var sharedMemorySize:Float;
	var unsharedDataSize:Float;
	var unsharedStackSize:Float;
	var minorPageFault:Float;
	var majorPageFault:Float;
	var swappedOut:Float;
	var fsRead:Float;
	var fsWrite:Float;
	var ipcSent:Float;
	var ipcReceived:Float;
	var signalsCount:Float;
	var voluntaryContextSwitches:Float;
	var involuntaryContextSwitches:Float;
}

/**
	@see https://nodejs.org/api/process.html#processrelease
**/
typedef Release = {
	var name:String;
	@:optional var sourceUrl:String;
	@:optional var headersUrl:String;
	@:optional var libUrl:String;
	@:optional var lts:String;
}

typedef EmitWarningOptions = {
	@:optional var type:String;
	@:optional var code:String;
	@:optional var detail:String;
	@:optional var ctor:Function;
}

/**
	Boolean (and related) flags describing process feature availability.

	@see https://nodejs.org/api/process.html#processfeatures
**/
typedef ProcessFeatures = {
	var inspector(default, null):Bool;
	var debug(default, null):Bool;
	@:deprecated("Always true; redundant")
	var uv(default, null):Bool;
	@:deprecated("Always true; redundant")
	var ipv6(default, null):Bool;
	var tls(default, null):Bool;
	@:deprecated("Use process.features.tls instead")
	var tls_alpn(default, null):Bool;
	@:deprecated("Use process.features.tls instead")
	var tls_ocsp(default, null):Bool;
	@:deprecated("Use process.features.tls instead")
	var tls_sni(default, null):Bool;
	/**
		`"strip"` by default, `"transform"` with `--experimental-transform-types`,
		or `false` with `--no-strip-types`.
	**/
	var typescript(default, null):EitherType<Bool, String>;
	var require_module(default, null):Bool;
	var cached_builtins(default, null):Bool;
}
