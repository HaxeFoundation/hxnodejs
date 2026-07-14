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

package js.node.child_process;

import haxe.extern.EitherType;
import js.lib.Error;
import js.node.Stream;
import js.node.dgram.Socket as DgramSocket;
import js.node.events.EventEmitter;
import js.node.net.Server as NetServer;
import js.node.net.Socket as NetSocket;
import js.node.stream.Readable;
import js.node.stream.Writable;

/**
	Handle that may be sent over an IPC channel (`net.Socket`, `net.Server`, or `dgram.Socket`).

	@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#subprocesssendmessage-sendhandle-options-callback
**/
typedef ChildProcessSendHandle = EitherType<NetSocket, EitherType<NetServer, DgramSocket>>;

/**
	Control object for an open IPC channel (`process.channel` / `subprocess.channel`).

	@see https://nodejs.org/docs/latest-v24.x/api/process.html#processchannel
**/
typedef ChildProcessChannel = {
	function ref():Void;
	function unref():Void;
}

/**
	Enumeration of events emitted by `ChildProcess` objects.
**/
enum abstract ChildProcessEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when:
			1. The process could not be spawned, or
			2. The process could not be killed, or
			3. Sending a message to the child process failed for whatever reason.

		Note that the exit-event may or may not fire after an error has occurred.
		If you are listening on both events to fire a function, remember to guard against calling your function twice.

		See also `ChildProcess.kill` and `ChildProcess.send`.
	**/
	var Error:ChildProcessEvent<Error->Void> = "error";

	/**
		This event is emitted after the child process ends.

		Listener arguments:
			code - the exit code, if it exited normally.
			signal - the signal passed to kill the child process, if it was killed by the parent.
	**/
	var Exit:ChildProcessEvent<Null<Int>->Null<String>->Void> = "exit";

	/**
		This event is emitted when the stdio streams of a child process have all terminated.
		This is distinct from `Exit`, since multiple processes might share the same stdio streams.
	**/
	var Close:ChildProcessEvent<Null<Int>->Null<String>->Void> = "close";

	/**
		This event is emitted after calling the `disconnect` method in the parent or in the child.
		After disconnecting it is no longer possible to send messages, and the `connected` property is false.
	**/
	var Disconnect:ChildProcessEvent<Void->Void> = "disconnect";

	/**
		Messages sent by `send` are obtained using the `'message'` event.

		Listener arguments:
			message - a parsed JSON object or primitive value
			sendHandle - a `net.Socket`, `net.Server`, or `dgram.Socket` when one was sent
	**/
	var Message:ChildProcessEvent<(message:Dynamic, sendHandle:Null<ChildProcessSendHandle>) -> Void> = "message";

	/**
		The `'spawn'` event is emitted once the child process has spawned successfully.
		If the child process does not spawn successfully, the `'spawn'` event is not emitted
		and the `'error'` event is emitted instead.
	**/
	var Spawn:ChildProcessEvent<Void->Void> = "spawn";
}

typedef ChildProcessSendOptions = {
	/**
		Can be used when passing instances of `js.node.net.Socket`.

		When true, the socket is kept open in the sending process.

		Defaults to false.
	**/
	@:optional var keepOpen:Bool;
}

/**
	An object representing a child process.

	The `ChildProcess` class is not intended to be used directly. Use the spawn() or fork() module methods
	to create a `ChildProcess` instance.

	@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#class-childprocess
**/
extern class ChildProcess extends EventEmitter<ChildProcess> {
	/**
		A Writable Stream that represents the child process's stdin.
		Closing this stream via `end` often causes the child process to terminate.

		If the child stdio streams are shared with the parent, then this will not be set.
	**/
	var stdin(default, null):Null<IWritable>;

	/**
		A Readable Stream that represents the child process's stdout.

		If the child stdio streams are shared with the parent, then this will not be set.
	**/
	var stdout(default, null):Null<IReadable>;

	/**
		A Readable Stream that represents the child process's stderr.

		If the child stdio streams are shared with the parent, then this will not be set.
	**/
	var stderr(default, null):Null<IReadable>;

	/**
		A sparse array of pipes to the child process, corresponding with positions
		in the `stdio` option that have been set to the value `'pipe'`.
	**/
	var stdio(default, null):Array<Null<IStream>>;

	/**
		The PID of the child process.

		If the child process could not be spawned successfully, then the value is `undefined`.
	**/
	var pid(default, null):Null<Int>;

	/**
		Set to false after `disconnect` is called.
		If `connected` is false, it is no longer possible to send messages.
	**/
	var connected(default, null):Bool;

	/**
		The `subprocess.killed` property indicates whether the child process successfully received
		a signal from `subprocess.kill()`. The `killed` property does not indicate that the child process
		has been terminated.
	**/
	var killed(default, null):Bool;

	/**
		The `subprocess.exitCode` property indicates the exit code of the child process.
		If the child process is still running, the field will be `null`.
	**/
	var exitCode(default, null):Null<Int>;

	/**
		The `subprocess.signalCode` property indicates the signal that caused the child process to terminate,
		or `null` if it terminated normally.
	**/
	var signalCode(default, null):Null<String>;

	/**
		The executable file name of the child process that is launched.

		For example, on Linux this would be `'bin/bash'` when spawning bash. For `fork()`, it would be the path
		to the `node` binary.
	**/
	var spawnfile(default, null):String;

	/**
		The command-line arguments of the child process.
	**/
	var spawnargs(default, null):Array<String>;

	/**
		While the IPC channel established by `fork` is open, this is a reference to that channel.
		Otherwise `null` / `undefined`.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#subprocesschannel
	**/
	var channel(default, null):Null<ChildProcessChannel>;

	/**
		Send a signal to the child process.

		If no argument is given, the process will be sent `'SIGTERM'`.
		See signal(7) for a list of available signals.

		Returns `true` if `kill()` succeeded, else `false`.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#subprocesskillsignal
	**/
	function kill(?signal:EitherType<String, Int>):Bool;

	/**
		Calls `kill('SIGTERM')`. Available as `subprocess[Symbol.dispose]()`
		(stable since Node.js 24.2).

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#subprocesssymboldispose
	**/
	extern inline function dispose():Void
		js.Syntax.code("{0}[Symbol.dispose]()", this);

	/**
		When using `fork`, write to the child using `send`;
		messages are received via the `'message'` event on the child.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#subprocesssendmessage-sendhandle-options-callback
	**/
	@:overload(function(message:Dynamic, sendHandle:ChildProcessSendHandle, options:ChildProcessSendOptions, ?callback:Null<Error>->Void):Bool {})
	@:overload(function(message:Dynamic, sendHandle:ChildProcessSendHandle, ?callback:Null<Error>->Void):Bool {})
	function send(message:Dynamic, ?callback:Null<Error>->Void):Bool;

	/**
		Close the IPC channel between parent and child, allowing the child to exit gracefully once there are no other
		connections keeping it alive.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#subprocessdisconnect
	**/
	function disconnect():Void;

	/**
		By default, the parent will wait for the detached child to exit.
		To prevent the parent from waiting for a given child, use the `unref` method.

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#subprocessunref
	**/
	function unref():Void;

	/**
		Opposite of `unref()`. References the child from the parent's event loop so that
		the parent will wait for the child to exit before exiting itself
		(unless there are other references keeping the parent alive).

		@see https://nodejs.org/docs/latest-v24.x/api/child_process.html#subprocessref
	**/
	function ref():Void;
}
