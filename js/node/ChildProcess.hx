package js.node;

import haxe.DynamicAccess;
import haxe.EitherType;

import js.node.Stream.IStream;
import js.node.child_process.ChildProcess as ChildProcessObject;

/**
	Common options for all `ChildProcess` methods.
**/
private typedef ChildProcessCommonOptions = {
	/**
		Current working directory of the child process.
	**/
	@:optional var cwd:String;

	/**
		Environment key-value pairs
	**/
	@:optional var env:DynamicAccess<String>;
}

/**
	Options for the `spawn` method.
**/
typedef ChildProcessSpawnOptions = {
	>ChildProcessCommonOptions,

	/**
		Child's stdio configuration.
	**/
	@:optional var stdio:ChildProcessSpawnOptionsStdio;

	/**
		The child will be a process group leader.
	**/
	@:optional var detached:Bool;

	/**
		Specifies specific file descriptors for the stdio of the child process.
		This API was not portable to all platforms and therefore removed.
		With `customFds` it was possible to hook up the new process' [stdin, stdout, stderr] to existing streams;
		-1 meant that a new stream should be created.

		Use at your own risk.
	**/
	@:deprecated
	@:optional var customFds:Array<Int>;

	/**
		Sets the user identity of the process. See setuid(2).
	**/
	@:optional var uid:Int;

	/**
		Sets the group identity of the process. See setgid(2).
	**/
	@:optional var gid:Int;
}

/**
	The `stdio` option is an array where each index corresponds to a fd in the child.
	The value is one of the following:

		* 'pipe' - Create a pipe between the child process and the parent process.
			       The parent end of the pipe is exposed to the parent as a property on the child_process object as ChildProcess.stdio[fd].
			       Pipes created for fds 0 - 2 are also available as ChildProcess.stdin, ChildProcess.stdout and ChildProcess.stderr, respectively.

		* 'ipc' - Create an IPC channel for passing messages/file descriptors between parent and child.
			      A ChildProcess may have at most one IPC stdio file descriptor. Setting this option enables the ChildProcess.send() method.
			      If the child writes JSON messages to this file descriptor, then this will trigger ChildProcess.on('message').
			      If the child is a Node.js program, then the presence of an IPC channel will enable process.send() and process.on('message').

		* 'ignore' - Do not set this file descriptor in the child. Note that Node will always open fd 0 - 2 for the processes it spawns.
		             When any of these is ignored node will open /dev/null and attach it to the child's fd.

		* Stream object - Share a readable or writable stream that refers to a tty, file, socket, or a pipe with the child process.
		                  The stream's underlying file descriptor is duplicated in the child process to the fd that corresponds to the index
		                  in the stdio array. Note that the stream must have an underlying descriptor (file streams do not until the 'open'
		                  event has occurred).

		* Positive integer - The integer value is interpreted as a file descriptor that is is currently open in the parent process.
		                     It is shared with the child process, similar to how Stream objects can be shared.

		* null - Use default value. For stdio fds 0, 1 and 2 (in other words, stdin, stdout, and stderr) a pipe is created.
		         For fd 3 and up, the default is 'ignore'.

     As a shorthand, the stdio argument may also be one of the following strings, rather than an array:
		ignore - ['ignore', 'ignore', 'ignore']
		pipe - ['pipe', 'pipe', 'pipe']
		inherit - [process.stdin, process.stdout, process.stderr] or [0,1,2]
**/
typedef ChildProcessSpawnOptionsStdio = EitherType<ChildProcessSpawnOptionsStdioSimple,ChildProcessSpawnOptionsStdioFull>;

/**
	A shorthand for the `stdio` argument in `ChildProcessSpawnOptions`
**/
@:enum abstract ChildProcessSpawnOptionsStdioSimple(String) from String to String {
	/**
		Equivalent to ['ignore', 'ignore', 'ignore']
	**/
	var Ignore = "ignore";

	/**
		Equivalent to ['pipe', 'pipe', 'pipe']
	**/
	var Pipe = "pipe";

	/**
		Equivalent to [process.stdin, process.stdout, process.stderr] or [0,1,2]
	**/
	var Inherit = "inherit";
}

/**
	Enumeration of possible `stdio` behaviours.
**/
@:enum abstract ChildProcessSpawnOptionsStdioBehaviour(String) from String to String {
	/**
		Create a pipe between the child process and the parent process.
		The parent end of the pipe is exposed to the parent as a property on the child_process object as ChildProcess.stdio[fd].
		Pipes created for fds 0 - 2 are also available as ChildProcess.stdin, ChildProcess.stdout and ChildProcess.stderr, respectively.
	**/
	var Pipe = "pipe";

	/**
		Create an IPC channel for passing messages/file descriptors between parent and child.
		A ChildProcess may have at most one IPC stdio file descriptor.

		Setting this option enables the ChildProcess.send() method.

		If the child writes JSON messages to this file descriptor, then this will trigger
		ChildProcess.on('message').

		If the child is a Node.js program, then the presence of an IPC channel will
		enable process.send() and process.on('message').
	**/
	var Ipc = "ipc";

	/**
		Do not set this file descriptor in the child.
		Note that Node will always open fd 0 - 2 for the processes it spawns.
		When any of these is ignored node will open /dev/null and attach it to the child's fd.
	**/
	var Ignore = "ignore";
}

// see https://github.com/HaxeFoundation/haxe/issues/3494
// typedef ChildProcessSpawnOptionsStdioFull = Array<EitherType<ChildProcessSpawnOptionsStdioBehaviour,EitherType<IStream,Int>>>;
typedef ChildProcessSpawnOptionsStdioFull = Array<Dynamic>;

/**
	Options for the `exec` method.
**/
typedef ChildProcessExecOptions = {
	>ChildProcessCommonOptions,

	/**
		Default: 'utf8'
	**/
	@:optional var encoding:String;

	/**
		If greater than 0, then it will kill the child process if it runs longer than timeout milliseconds.
	**/
	@:optional var timeout:Int;

	/**
		The child process is killed with `killSignal` (default: 'SIGTERM').
	**/
	@:optional var killSignal:String;

	/**
		The largest amount of data allowed on stdout or stderr.
		If this value is exceeded then the child process is killed.
		Default: 200*1024
	**/
	@:optional var maxBuffer:Int;
}

/**
	Options for the `fork` method.
**/
typedef ChildProcessForkOptions = {
	>ChildProcessCommonOptions,

	/**
		Default: 'utf8'
	**/
	@:optional var encoding:String;

	/**
		Executable used to create the child process
	**/
	@:optional var execPath:String;

	/**
		List of string arguments passed to the executable (Default: process.execArgv)
	**/
	@:optional var execArgv:Array<String>;

	/**
		If `true`, stdin, stdout, and stderr of the child will be piped to the parent,
		otherwise they will be inherited from the parent, see the "pipe" and "inherit"
		options for `ChildProcessSpawnOptions.stdio` for more details (default is `false`)
	**/
	@:optional var silent:Bool;
}

/**
	An error passed to the `ChildProcess.exec` callback.

	TODO: this is not a real class, should we care about Std.is and friends?
**/
extern class ChildProcessExecError extends js.Error {
	/**
		the exit code of the child proces.
	**/
	var code(default,null):Int;

	/**
		the signal that terminated the process.
	**/
	var signal(default,null):String;
}

/**
	A callback type for the `ChildProcess.exec`.
	It received three arguments: error, stdout, stderr.

	On success, error will be null. On error, error will be an instance of `Error`
	and `error.code` will be the exit code of the child process, and `error.signal` will be set
	to the signal that terminated the process (see `ChildProcessExecError`).
**/
typedef ChildProcessExecCallback = Null<ChildProcessExecError> -> Buffer -> Buffer -> Void;

@:jsRequire("child_process")
extern class ChildProcess {
	/**
		Launches a new process with the given `command`, with command line arguments in `args`.
		If omitted, `args` defaults to an empty `Array`.

		The third argument is used to specify additional options, which defaults to:
			{ cwd: null,
			  env: process.env
			}

		Note that if spawn receives an empty options object, it will result in spawning the process with an empty
		environment rather than using `process.env`. This due to backwards compatibility issues with a deprecated API.
	**/
	static function spawn(command:String, ?args:Array<String>, ?options:ChildProcessSpawnOptions):ChildProcessObject;

	/**
		Runs a command in a shell and buffers the output.

		`command` is the command to run, with space-separated arguments.

		The default `options` are:
			{ encoding: 'utf8',
			  timeout: 0,
			  maxBuffer: 200*1024,
			  killSignal: 'SIGTERM',
			  cwd: null,
			  env: null }
	**/
	@:overload(function(command:String, options:ChildProcessExecOptions, callback:ChildProcessExecCallback):ChildProcessObject {})
	static function exec(command:String, callback:ChildProcessExecCallback):ChildProcessObject;

	/**
		This is similar to `exec` except it does not execute a subshell but rather the specified file directly.
		This makes it slightly leaner than `exec`
	**/
	@:overload(function(file:String, args:Array<String>, options:ChildProcessExecOptions, ?callback:ChildProcessExecCallback):ChildProcessObject {})
	@:overload(function(file:String, options:ChildProcessExecOptions, ?callback:ChildProcessExecCallback):ChildProcessObject {})
	@:overload(function(file:String, args:Array<String>, ?callback:ChildProcessExecCallback):ChildProcessObject {})
	static function execFile(file:String, ?callback:ChildProcessExecCallback):ChildProcessObject;

	/**
		This is a special case of the `spawn` functionality for spawning Node processes.
		In addition to having all the methods in a normal `ChildProcess` instance,
		the returned object has a communication channel built-in.
		See `send` for details.
	**/
	@:overload(function(modulePath:String, args:Array<String>, options:ChildProcessForkOptions):ChildProcessObject {})
	@:overload(function(modulePath:String, options:ChildProcessForkOptions):ChildProcessObject {})
	static function fork(modulePath:String, ?args:Array<String>):ChildProcessObject;
}
