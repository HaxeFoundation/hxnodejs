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

package js.node.repl;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.lib.Error;
import js.node.Repl.ReplOptions;
import js.node.events.EventEmitter.Event;
import js.node.readline.Interface;
import js.node.stream.Readable.IReadable;
import js.node.stream.Writable.IWritable;

/**
	Enumeration of events emitted by `REPLServer` objects.
**/
enum abstract REPLServerEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		The `'exit'` event is emitted when the REPL is exited either by receiving the `.exit` command as input,
		the user pressing Ctrl+C twice to signal `SIGINT`, or by pressing Ctrl+D to signal `'end'` on the input stream.

		@see https://nodejs.org/docs/latest-v24.x/api/repl.html#event-exit
	**/
	var Exit:REPLServerEvent<() -> Void> = "exit";

	/**
		The `'reset'` event is emitted when the REPL's context is reset.
		This occurs whenever the `.clear` command is received as input unless the REPL is using the default evaluator
		and the `REPLServer` instance was created with the `useGlobal` option set to `true`.

		// TODO(section-5): type context beyond DynamicAccess<Dynamic>

		@see https://nodejs.org/docs/latest-v24.x/api/repl.html#event-reset
	**/
	var Reset:REPLServerEvent<(context:DynamicAccess<Dynamic>) -> Void> = "reset";
}

/**
	Instances of `repl.REPLServer` are created using `repl.start()` or directly with `new REPLServer(options)`.

	Extends `readline.Interface`.

	@see https://nodejs.org/docs/latest-v24.x/api/repl.html#class-replserver
**/
@:jsRequire("repl", "REPLServer")
extern class REPLServer extends Interface {
	/**
		Creates a new `REPLServer` instance. Prefer `Repl.start()` in most cases.
	**/
	function new(?options:ReplOptions);

	/**
		The `vm` / REPL context object provided to the `eval` function.

		// TODO(section-5): type context beyond DynamicAccess<Dynamic>
	**/
	var context(default, null):DynamicAccess<Dynamic>;

	/**
		The `Readable` stream from which REPL input will be read.
	**/
	var input(default, null):IReadable;

	/**
		The `Writable` stream to which REPL output will be written.
	**/
	var output(default, null):IWritable;

	/**
		Deprecated alias for `input`. Deprecated since: v14.3.0.
	**/
	@:deprecated("Use input instead")
	var inputStream(default, null):IReadable;

	/**
		Deprecated alias for `output`. Deprecated since: v14.3.0.
	**/
	@:deprecated("Use output instead")
	var outputStream(default, null):IWritable;

	/**
		Commands registered via `defineCommand()`.
	**/
	var commands(default, null):DynamicAccess<EitherType<REPLCommand, (rest:String) -> Void>>;

	/**
		The `replServer.defineCommand()` method is used to add new `.`-prefixed commands to the REPL instance.
	**/
	@:overload(function(keyword:String, cmd:(rest:String) -> Void):Void {})
	function defineCommand(keyword:String, cmd:REPLCommand):Void;

	/**
		The `replServer.displayPrompt()` method readies the REPL instance for input from the user,
		printing the configured `prompt` to a new line in `output` and resuming `input`.

		When multi-line input is being entered, a pipe `'|'` is printed rather than the prompt.
	**/
	function displayPrompt(?preserveCursor:Bool):Void;

	/**
		The `replServer.clearBufferedCommand()` method clears any command that has been buffered but not yet executed.
	**/
	function clearBufferedCommand():Void;

	/**
		Initializes a history log file for the REPL instance.

		When `historyConfig` is a string, it is the path to the history file.
		Since Node.js v24.2.0, an options object may be passed instead.
	**/
	@:overload(function(historyConfig:REPLServerHistoryOptions, ?callback:(err:Null<Error>, repl:Null<REPLServer>) -> Void):Void {})
	function setupHistory(historyPath:String, callback:(err:Null<Error>, repl:Null<REPLServer>) -> Void):Void;
}

/**
	Object form of `replServer.setupHistory` (Node.js v24.2.0+).

	@see https://nodejs.org/docs/latest-v24.x/api/repl.html#replserversetuphistoryhistoryconfig-callback
**/
typedef REPLServerHistoryOptions = {
	/**
		The path to the history file.
	**/
	@:optional var filePath:String;

	/**
		Maximum number of history lines retained. Set to `0` to disable history.
		Only applies when `terminal` is `true`. Default: `30`.
	**/
	@:optional var size:Int;

	/**
		If `true`, when a new input line duplicates an older one, the older line is removed. Default: `false`.
	**/
	@:optional var removeHistoryDuplicates:Bool;

	/**
		Called when history writes are ready or upon error.
		May be used instead of the `callback` argument to `setupHistory`.
	**/
	@:optional var onHistoryFileLoaded:(err:Null<Error>, repl:Null<REPLServer>) -> Void;
}

/**
	Options object used by `REPLServer.defineCommand`.
**/
typedef REPLCommand = {
	/**
		Help text to be displayed when `.help` is entered.
	**/
	@:optional var help:String;

	/**
		The function to execute, optionally accepting a single string argument.
	**/
	var action:(rest:String) -> Void;
}

/** @deprecated Use `REPLCommand` instead. **/
typedef REPLServerOptions = REPLCommand;
