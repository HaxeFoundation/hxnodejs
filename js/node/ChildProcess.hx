package js.node;

import haxe.DynamicAccess;
import js.node.events.EventEmitter;
import js.node.stream.Readable;
import js.node.stream.Writable;

@:enum abstract ChildProcessEvent(String) to String  {
	/**
		Emitted when:
			1. The process could not be spawned, or
			2. The process could not be killed, or
			3. Sending a message to the child process failed for whatever reason.

		Listener arguments:
			* err:Error - the error

		Note that the exit-event may or may not fire after an error has occured.
		If you are listening on both events to fire a function, remember to guard against calling your function twice.

		See also `ChildProcess.kill` and `ChildProcess.send`.
	**/
	var Error = "error";

	/**
		This event is emitted after the child process ends.

		Listener arguments:
			* code:Int - the exit code, if it exited normally.
			* signal:String - the signal passed to kill the child process, if it was killed by the parent.

		If the process terminated normally, `code` is the final exit code of the process, otherwise null.
		If the process terminated due to receipt of a signal, `signal` is the string name of the signal, otherwise null.

		Note that the child process stdio streams might still be open.

		Also, note that node establishes signal handlers for 'SIGINT' and 'SIGTERM',
		so it will not terminate due to receipt of those signals, it will exit.
		See waitpid(2).
	**/
	var Exit = "exit";

	/**
		This event is emitted when the stdio streams of a child process have all terminated.
		This is distinct from `Exit`, since multiple processes might share the same stdio streams.

		Listener arguments:
			* code:Int - the exit code, if it exited normally.
			* signal:String - the signal passed to kill the child process, if it was killed by the parent.
	**/
	var Close = "close";

	/**
		This event is emitted after calling the `disconnect` method in the parent or in the child.
		After disconnecting it is no longer possible to send messages, and the `connected` property is false.
	**/
	var Disconnect = "disconnect";

	/**
		Messages send by `send` are obtained using the message event.

		Listener arguments:
			* message:Dynamic - a parsed JSON object or primitive value
			* sendHandle:Dynamic - a Socket or Server object
	**/
	var Message = "message";
}

/**
	A shorthand for the `stdio` argument in `ChildProcessSpawnOptions`
**/
@:enum abstract ChildProcessStdioConfig(String) from String to String {
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

private typedef ChildProcessCommonOptions = {
	/**
		Current working directory of the child process.
	**/
	?cwd:String,

	/**
		Environment key-value pairs
	**/
	?env:DynamicAccess<String>,
}

typedef ChildProcessSpawnOptions = {
	>ChildProcessCommonOptions,

	/**
		Child's stdio configuration.

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
	**/
	?stdio:haxe.EitherType<ChildProcessStdioConfig,Array<Dynamic>>, // TODO: type properly

	/**
		The child will be a process group leader.
	**/
	?detached:Bool,

	/**
		Sets the user identity of the process. See setuid(2).
	**/
	?uid:Int,

	/**
		Sets the group identity of the process. See setgid(2).
	**/
	?gid:Int,
}

typedef ChildProcessExecOptions = {
	>ChildProcessCommonOptions,

	/**
		Default: 'utf8'
	**/
	?encoding:String,

	/**
		If greater than 0, then it will kill the child process if it runs longer than timeout milliseconds.
	**/
	?timeout:Int,

	/**
		The child process is killed with `killSignal` (default: 'SIGTERM').
	**/
	?killSignal:String,

	/**
		The largest amount of data allowed on stdout or stderr.
		If this value is exceeded then the child process is killed.
	**/
	?maxBuffer:Int,
}

typedef ChildProcessForkOptions = {
	>ChildProcessCommonOptions,

	/**
		Default: 'utf8'
	**/
	?encoding:String,

	/**
		Executable used to create the child process
	**/
	?execPath:String,

	/**
		List of string arguments passed to the executable (Default: process.execArgv)
	**/
	?execArgv:Array<String>,

	/**
		If `true`, stdin, stdout, and stderr of the child will be piped to the parent,
		otherwise they will be inherited from the parent, see the "pipe" and "inherit"
		options for `ChildProcessSpawnOptions.stdio` for more details (default is `false`)
	**/
	?silent:Bool
}

@:jsRequire("child_process") // TODO move ChildProcess (the class) to a package to comply with general guidelines?
extern class ChildProcess extends EventEmitter<ChildProcess> {

	/**
		Launches a new process with the given `command`, with command line arguments in `args`.
		If omitted, `args` defaults to an empty `Array`.

		The third argument is used to specify additional options, which defaults to:
			{ cwd: undefined,
			  env: process.env
			}

		Note that if spawn receives an empty options object, it will result in spawning the process with an empty
		environment rather than using `process.env`. This due to backwards compatibility issues with a deprecated API.
	**/
	@:overload(function(command:String, args:Array<String>, options:ChildProcessSpawnOptions):ChildProcess {})
	@:overload(function(command:String, options:ChildProcessSpawnOptions):ChildProcess {})
	static function spawn(command:String, ?args:Array<String>):ChildProcess;

	/**
		Runs a command in a shell and buffers the output.

		The callback gets the arguments (error, stdout, stderr).

		The default `options` are:
			{ encoding: 'utf8',
			  timeout: 0,
			  maxBuffer: 200*1024,
			  killSignal: 'SIGTERM',
			  cwd: null,
			  env: null }
	**/
	@:overload(function(command:String, options:ChildProcessExecOptions, callback:Error->Buffer->Buffer->Void):ChildProcess {})
	static function exec(command:String, callback:Error->Buffer->Buffer->Void):ChildProcess;

	/**
		This is similar to `exec` except it does not execute a subshell but rather the specified file directly.
		This makes it slightly leaner than `exec`
	**/
	@:overload(function(file:String, args:Array<String>, options:ChildProcessExecOptions, callback:Error->Buffer->Buffer->Void):ChildProcess {})
	@:overload(function(file:String, options:ChildProcessExecOptions, ?callback:Error->Buffer->Buffer->Void):ChildProcess {})
	@:overload(function(file:String, args:Array<String>, ?callback:Error->Buffer->Buffer->Void):ChildProcess {})
	static function execFile(file:String, ?callback:Error->Buffer->Buffer->Void):ChildProcess;

	/**
		This is a special case of the `spawn` functionality for spawning Node processes.
		In addition to having all the methods in a normal `ChildProcess` instance,
		the returned object has a communication channel built-in.
		See `send` for details.
	**/
	@:overload(function(modulePath:String, args:Array<String>, options:ChildProcessForkOptions):ChildProcess {})
	@:overload(function(modulePath:String, options:ChildProcessForkOptions):ChildProcess {})
	static function fork(modulePath:String, ?args:Array<String>):ChildProcess;

	/**
		A Writable Stream that represents the child process's stdin.
		Closing this stream via `end` often causes the child process to terminate.

		If the child stdio streams are shared with the parent, then this will not be set.
	**/
	var stdin(default,null):Writable;

	/**
		A Readable Stream that represents the child process's stdout.

		If the child stdio streams are shared with the parent, then this will not be set.
	**/
	var stdout(default,null):IReadable;

	/**
		A Readable Stream that represents the child process's stderr.

		If the child stdio streams are shared with the parent, then this will not be set.
	**/
	var stderr(default,null):IReadable;

	/**
		The PID of the child process.
	**/
	var pid(default,null):Int;

	/**
		Set to false after `disconnect' is called
		If `connected` is false, it is no longer possible to send messages.
	**/
	var connected(default,null):Bool;

	/**
		Send a signal to the child process.

		If no argument is given, the process will be sent 'SIGTERM'.
		See signal(7) for a list of available signals.

		May emit an 'error' event when the signal cannot be delivered.

		Sending a signal to a child process that has already exited is not an error
		but may have unforeseen consequences: if the PID (the process ID) has been reassigned to another process,
		the signal will be delivered to that process instead. What happens next is anyone's guess.

		Note that while the function is called `kill`, the signal delivered to the child process may not actually kill it.
		`kill` really just sends a signal to a process. See kill(2)
	**/
	function kill(?signal:String):Void;

	/**
		When using `fork` you can write to the child using `send` and messages are received by a 'message' event on the child.

		In the child the `Process` object will have a `send` method, and process will emit objects each time it receives
		a message on its channel.

		Please note that the `send` method on both the parent and child are synchronous - sending large chunks of data is
		not advised (pipes can be used instead, see `spawn`).

		There is a special case when sending a {cmd: 'NODE_foo'} `message`. All messages containing a `NODE_` prefix in
		its cmd property will not be emitted in the 'message' event, since they are internal messages used by node core.
		Messages containing the prefix are emitted in the 'internalMessage' event, you should by all means avoid using
		this feature, it is subject to change without notice.

		The `sendHandle` option is for sending a TCP server or socket object to another process.
		The child will receive the object as its second argument to the message event.

		Emits an 'error' event if the message cannot be sent, for example because the child process has already exited.
	**/
	// TODO: make a ChildProcessFork subclass? Because this field is only available when created with "fork"
	function send(message:Dynamic, ?sendHandle:Dynamic):Void;

	/**
		Close the IPC channel between parent and child, allowing the child to exit gracefully once there are no other
		connections keeping it alive.

		After calling this method the `connected` flag will be set to false in both the parent and child,
		and it is no longer possible to send messages.

		The 'disconnect' event will be emitted when there are no messages in the process of being received,
		most likely immediately.

		Note that you can also call `process.disconnect` in the child process.
	 */
	function disconnect():Void;

	/**
		By default, the parent will wait for the detached child to exit.
		To prevent the parent from waiting for a given child, use the `unref` method,
		and the parent's event loop will not include the child in its reference count.
	**/
	function unref():Void;
}
