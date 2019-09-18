/*
 * Copyright (C)2014-2019 Haxe Foundation
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

import haxe.extern.EitherType;
import js.node.events.EventEmitter;
#if haxe4
import js.lib.Error;
import js.lib.Function;
#else
import js.Error;
#end

/**
	Enumeration of events emitted by the `REPLServer` objects.
**/
@:enum abstract REPLServerEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when the REPL is exited either by receiving the `.exit` command as input, the user pressing `<ctrl>-C`
		twice to signal `SIGINT`, or by pressing `<ctrl>-D` to signal `'end'` on the input stream.

		@see https://nodejs.org/api/repl.html#repl_event_exit
	**/
	var Exit:REPLServerEvent<Void->Void> = "exit";

	/**
		Emitted when the REPL's context is reset.

		@see https://nodejs.org/api/repl.html#repl_event_reset
	**/
	var Reset:REPLServerEvent<Dynamic<Dynamic>->Void> = "reset";
}

/**
	Instances of `repl.REPLServer` are created using the `repl.start()` method and should not be created directly using
	the JavaScript `new` keyword.

	@see https://nodejs.org/api/repl.html#repl_class_replserver
**/
@:jsRequire("repl", "REPLServer")
extern class REPLServer extends EventEmitter<REPLServer> {
	/**
		It is possible to expose a variable to the REPL explicitly by assigning it to the `context` object associated
		with each `REPLServer`.

		@see https://nodejs.org/api/repl.html#repl_global_and_local_scope
	**/
	var context(default, null):Dynamic<Dynamic>;

	/**
		The `replServer.defineCommand()` method is used to add new `.`-prefixed commands to the REPL instance.

		@see https://nodejs.org/api/repl.html#repl_replserver_definecommand_keyword_cmd
	**/
	function defineCommand(keyword:String, cmd:EitherType<REPLServerOptions, Function>):Void;

	/**
		The `replServer.displayPrompt()` method readies the REPL instance for input from the user, printing the
		configured `prompt` to a new line in the `output` and resuming the `input` to accept new input.

		@see https://nodejs.org/api/repl.html#repl_replserver_displayprompt_preservecursor
	**/
	function displayPrompt(?preserveCursor:Bool):Void;

	/**
		The `replServer.clearBufferedCommand()` method clears any command that has been buffered but not yet executed.

		@see https://nodejs.org/api/repl.html#repl_replserver_clearbufferedcommand
	**/
	function clearBufferedCommand():Void;

	/**
		Initializes a history log file for the REPL instance.

		@see https://nodejs.org/api/repl.html#repl_replserver_setuphistory_historypath_callback
	**/
	function setupHistory(historyPath:String, callback:Error->REPLServer->Void):Void;
}

/**
	Options object used by `REPLServer.defineCommand`.
**/
typedef REPLServerOptions = {
	/**
		Help text to be displayed when `.help` is entered.
	**/
	@:optional var help:String;

	/**
		The function to execute.
	**/
	var action:?String->Void;
}
