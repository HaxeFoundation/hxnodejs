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
import js.lib.Error;
import js.node.child_process.ChildProcess as ChildProcessObject;
import js.node.web.AbortSignal;
import js.node.url.URL;

/**
	Serialization mode for IPC messages between processes.

	@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#advanced-serialization
**/
enum abstract ChildProcessSerialization(String) from String to String {
	var Json = "json";
	var Advanced = "advanced";
}

/**
	Common options for all `ChildProcess` methods.

	@see https://nodejs.org/docs/latest-v24.x/api/child_process.html
**/
private typedef ChildProcessCommonOptions = {
	/**
		Current working directory of the child process.
		Accepts a path string or WHATWG `URL` object with `file:` protocol.
	**/
	@:optional var cwd:EitherType<String, URL>;

	/**
		Environment key-value pairs.
	**/
	@:optional var env:DynamicAccess<String>;

	/**
		Sets the user identity of the process. See setuid(2).
	**/
	@:optional var uid:Int;

	/**
		Sets the group identity of the process. See setgid(2).
	**/
	@:optional var gid:Int;

	/**
		No quoting or escaping of arguments is done on Windows.
		Ignored on Unix. Default: `false`.
	**/
	@:optional var windowsVerbatimArguments:Bool;

	/**
		Allows aborting the child process using an `AbortSignal`.
	**/
	@:optional var signal:AbortSignal;

	/**
		Maximum amount of time in milliseconds the process is allowed to run.
	**/
	@:optional var timeout:Int;

	/**
		The signal value to be used when the spawned process will be killed
		by timeout or abort signal. Default: `'SIGTERM'`.
	**/
	@:optional var killSignal:EitherType<String, Int>;
}

/**
	Common options for `spawn` and `spawnSync` methods.
**/
private typedef ChildProcessSpawnOptionsBase = {
	> ChildProcessCommonOptions,

	/**
		Child's stdio configuration.
	**/
	@:optional var stdio:ChildProcessSpawnOptionsStdio;

	/**
		Specify the kind of serialization used for sending messages between processes.
		Possible values are `'json'` and `'advanced'`. Default: `'json'`.
	**/
	@:optional var serialization:ChildProcessSerialization;

	/**
		If `true`, runs `command` inside a shell.
		Uses `'/bin/sh'` on Unix and `process.env.ComSpec` on Windows.
		A different shell can be specified as a string.
		Default: `false` (no shell).
	**/
	@:optional var shell:EitherType<Bool, String>;

	/**
		Hide the subprocess console window that would normally be created on Windows.
		Default: `false`.
	**/
	@:optional var windowsHide:Bool;

	/**
		The child will be a process group leader / can keep running after parent exits.
	**/
	@:optional var detached:Bool;

	/**
		Explicitly set the value of `argv[0]` sent to the child process.
		This will be set to `command` if not specified.
	**/
	@:optional var argv0:String;
}

/**
	Options for the `spawn` method.
**/
typedef ChildProcessSpawnOptions = {
	> ChildProcessSpawnOptionsBase,
}

/**
	Options for the `spawnSync` method.
**/
typedef ChildProcessSpawnSyncOptions = {
	> ChildProcessSpawnOptionsBase,
	> ChildProcessExecOptionsBase,

	/**
		The value passed as stdin to the spawned process.
		Supplying this value overrides `stdio[0]`.
		Accepts a string or `ArrayBufferView` (Buffer, TypedArray, or DataView).
	**/
	@:optional var input:EitherType<String, js.lib.ArrayBufferView>;
}

/**
	The `stdio` option is an array where each index corresponds to a fd in the child.
	The value is one of the following:

		* 'pipe' - Create a pipe between the child process and the parent process.
		* 'ipc' - Create an IPC channel for passing messages/file descriptors.
		* 'ignore' - Do not set this file descriptor in the child.
		* 'inherit' - Pass through the corresponding stdio stream to/from the parent.
		* Stream object - Share a readable or writable stream with the child process.
		* Positive integer - A file descriptor that is currently open in the parent.
		* null / undefined - Use default value.

	 As a shorthand, the stdio argument may also be one of the following strings:
		ignore - ['ignore', 'ignore', 'ignore']
		pipe - ['pipe', 'pipe', 'pipe']
		overlapped - ['overlapped', 'overlapped', 'overlapped']
		inherit - [process.stdin, process.stdout, process.stderr] or [0,1,2]
**/
typedef ChildProcessSpawnOptionsStdio = EitherType<ChildProcessSpawnOptionsStdioSimple, ChildProcessSpawnOptionsStdioFull>;

/**
	A shorthand for the `stdio` argument in `ChildProcessSpawnOptions`
**/
enum abstract ChildProcessSpawnOptionsStdioSimple(String) from String to String {
	/**
		Equivalent to `['ignore', 'ignore', 'ignore']`
	**/
	var Ignore = "ignore";

	/**
		Equivalent to `['pipe', 'pipe', 'pipe']`
	**/
	var Pipe = "pipe";

	/**
		Equivalent to `[process.stdin, process.stdout, process.stderr]` or `[0,1,2]`
	**/
	var Inherit = "inherit";

	/**
		Equivalent to `['overlapped', 'overlapped', 'overlapped']`
	**/
	var Overlapped = "overlapped";
}

/**
	Enumeration of possible `stdio` behaviours.
**/
enum abstract ChildProcessSpawnOptionsStdioBehaviour(String) from String to String {
	/**
		Create a pipe between the child process and the parent process.
	**/
	var Pipe = "pipe";

	/**
		Same as `'pipe'` with overlapped I/O on Windows.
	**/
	var Overlapped = "overlapped";

	/**
		Create an IPC channel for passing messages/file descriptors between parent and child.
	**/
	var Ipc = "ipc";

	/**
		Do not set this file descriptor in the child.
	**/
	var Ignore = "ignore";

	/**
		Pass through the corresponding stdio stream to/from the parent process.
	**/
	var Inherit = "inherit";
}

// see https://github.com/HaxeFoundation/haxe/issues/3499
// Ideal type: Array<EitherType<ChildProcessSpawnOptionsStdioBehaviour, EitherType<IStream, Int>>>
// TODO(section-5): replace Array<Dynamic> once nested EitherType arrays type-check reliably
typedef ChildProcessSpawnOptionsStdioFull = Array<Dynamic>;

/**
	Common options for `exec` and `execFile` methods.
**/
private typedef ChildProcessExecOptionsBase = {
	> ChildProcessCommonOptions,

	/**
		Default: `'utf8'`
	**/
	@:optional var encoding:String;

	/**
		The largest amount of data allowed on stdout or stderr.
		If this value is exceeded then the child process is killed.
		Default: `1024 * 1024`
	**/
	@:optional var maxBuffer:Int;

	/**
		If `true`, runs the command inside a shell.
		Uses `'/bin/sh'` on Unix and `process.env.ComSpec` on Windows.
		A different shell can be specified as a string.

		For `exec`, a shell is always used (default `'/bin/sh'` / `ComSpec`).
		For `execFile`, default is `false` (no shell).
	**/
	@:optional var shell:EitherType<Bool, String>;

	/**
		Hide the subprocess console window that would normally be created on Windows.
		Default: `false`.
	**/
	@:optional var windowsHide:Bool;
}

/**
	Options for the `exec` method.
**/
typedef ChildProcessExecOptions = {
	> ChildProcessExecOptionsBase,
}

/**
	Options for the `execFile` method.
**/
typedef ChildProcessExecFileOptions = {
	> ChildProcessExecOptionsBase,
}

/**
	Options for the `fork` method.
**/
typedef ChildProcessForkOptions = {
	> ChildProcessCommonOptions,

	/**
		Executable used to create the child process.
	**/
	@:optional var execPath:String;

	/**
		List of string arguments passed to the executable (Default: `process.execArgv`)
	**/
	@:optional var execArgv:Array<String>;

	/**
		If `true`, stdin, stdout, and stderr of the child will be piped to the parent,
		otherwise they will be inherited from the parent (default is `false`).
	**/
	@:optional var silent:Bool;

	/**
		See `ChildProcessSpawnOptions.stdio`. When provided, overrides `silent`.
		Must contain exactly one `'ipc'` entry when using the array form.
	**/
	@:optional var stdio:ChildProcessSpawnOptionsStdio;

	/**
		Specify the kind of serialization used for sending messages between processes.
	**/
	@:optional var serialization:ChildProcessSerialization;

	/**
		Prepare the child to run independently of its parent process.
		Platform-specific; see Node.js `options.detached` docs.
	**/
	@:optional var detached:Bool;
}

/**
	An error passed to the `ChildProcess.exec` callback.
**/
@:native("Error")
extern class ChildProcessExecError extends Error {
	/**
		the exit code of the child process.
	**/
	var code(default, null):Int;

	/**
		the signal that terminated the process.
	**/
	var signal(default, null):String;
}

/**
	A callback type for `ChildProcess.exec`.
	It receives three arguments: `error`, `stdout`, `stderr`.

	On success, error will be `null`. On error, `error` will be an instance of `Error`
	and `error.code` will be the exit code of the child process, and `error.signal` will be set
	to the signal that terminated the process (see `ChildProcessExecError`).
**/
typedef ChildProcessExecCallback = (error:Null<ChildProcessExecError>, stdout:EitherType<Buffer, String>,
	stderr:EitherType<Buffer, String>) -> Void;

/**
	Object returned from the `spawnSync` method.
**/
typedef ChildProcessSpawnSyncResult = {
	/**
		Pid of the child process
	**/
	var pid:Int;

	/**
		Array of results from stdio output
	**/
	var output:Array<Null<EitherType<Buffer, String>>>;

	/**
		The contents of output[1]
	**/
	var stdout:EitherType<Buffer, String>;

	/**
		The contents of output[2]
	**/
	var stderr:EitherType<Buffer, String>;

	/**
		The exit code of the child process
	**/
	var status:Null<Int>;

	/**
		The signal used to kill the child process
	**/
	var signal:Null<String>;

	/**
		The error object if the child process failed or timed out
	**/
	var error:Null<Error>;
}

/**
	The `child_process` module enables spawning child processes.

	@see https://nodejs.org/docs/latest-v24.x/api/child_process.html
**/
@:jsRequire("child_process")
extern class ChildProcess {
	/**
		Launches a new process with the given `command`, with command line arguments in `args`.
		If omitted, `args` defaults to an empty `Array`.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#child_processspawncommand-args-options
	**/
	@:overload(function(command:String, ?options:ChildProcessSpawnOptions):ChildProcessObject {})
	@:overload(function(command:String, args:Array<String>, ?options:ChildProcessSpawnOptions):ChildProcessObject {})
	static function spawn(command:String, ?args:Array<String>):ChildProcessObject;

	/**
		Runs a command in a shell and buffers the output.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#child_processexeccommand-options-callback
	**/
	@:overload(function(command:String, options:ChildProcessExecOptions, ?callback:ChildProcessExecCallback):ChildProcessObject {})
	static function exec(command:String, ?callback:ChildProcessExecCallback):ChildProcessObject;

	/**
		Similar to `exec` except it does not execute a subshell but rather the specified file directly.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#child_processexecfilefile-args-options-callback
	**/
	@:overload(function(file:String, args:Array<String>, options:ChildProcessExecFileOptions, ?callback:ChildProcessExecCallback):ChildProcessObject {})
	@:overload(function(file:String, options:ChildProcessExecFileOptions, ?callback:ChildProcessExecCallback):ChildProcessObject {})
	@:overload(function(file:String, args:Array<String>, ?callback:ChildProcessExecCallback):ChildProcessObject {})
	static function execFile(file:String, ?callback:ChildProcessExecCallback):ChildProcessObject;

	/**
		Special case of `spawn` for spawning Node.js processes with an IPC channel.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#child_processforkmodulepath-args-options
	**/
	@:overload(function(modulePath:EitherType<String, URL>, args:Array<String>, options:ChildProcessForkOptions):ChildProcessObject {})
	@:overload(function(modulePath:EitherType<String, URL>, options:ChildProcessForkOptions):ChildProcessObject {})
	static function fork(modulePath:EitherType<String, URL>, ?args:Array<String>):ChildProcessObject;

	/**
		Synchronous version of `spawn`.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#child_processspawnsynccommand-args-options
	**/
	@:overload(function(command:String, args:Array<String>, ?options:ChildProcessSpawnSyncOptions):ChildProcessSpawnSyncResult {})
	static function spawnSync(command:String, ?options:ChildProcessSpawnSyncOptions):ChildProcessSpawnSyncResult;

	/**
		Synchronous version of `execFile`.
		If the process times out, or has a non-zero exit code, this method will throw.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#child_processexecfilesyncfile-args-options
	**/
	@:overload(function(file:String, ?options:ChildProcessSpawnSyncOptions):EitherType<String, Buffer> {})
	@:overload(function(file:String, args:Array<String>, ?options:ChildProcessSpawnSyncOptions):EitherType<String, Buffer> {})
	static function execFileSync(file:String, ?args:Array<String>):EitherType<String, Buffer>;

	/**
		Synchronous version of `exec`.
		If the process times out, or has a non-zero exit code, this method will throw.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#child_processexecsynccommand-options
	**/
	static function execSync(command:String, ?options:ChildProcessSpawnSyncOptions):EitherType<String, Buffer>;
}
