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

package js.node.repl;

import haxe.DynamicAccess;
import js.lib.Error;
import js.node.events.EventEmitter;

/**
	Enumeration of events emitted by the `REPLServer` objects.
**/
enum abstract REPLServerEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		The `'exit'` event is emitted when the REPL is exited either by receiving the `.exit` command as input,
		the user pressing `<ctrl>-C` twice to signal `SIGINT`, or by pressing `<ctrl>-D` to signal 'end' on the input stream.
	**/
	var Exit:REPLServerEvent<Void->Void> = "exit";

	/**
		The `'reset'` event is emitted when the REPL's context is reset.

		// TODO(section-5): type context beyond DynamicAccess<Dynamic>
	**/
	var Reset:REPLServerEvent<(context:DynamicAccess<Dynamic>) -> Void> = "reset";
}

/**
	Instances of `repl.REPLServer` are created using the `repl.start()` method and should not be created directly using
	the JavaScript `new` keyword.

	@see https://nodejs.org/docs/latest-v24.x/api/repl.html#class-replserver
**/
@:jsRequire("repl", "REPLServer")
extern class REPLServer extends EventEmitter<REPLServer> {
	/**
		It is possible to expose a variable to the REPL explicitly by assigning it to the `context` object associated
		with each `REPLServer`.

		// TODO(section-5): type context beyond DynamicAccess<Dynamic>
	**/
	var context(default, null):DynamicAccess<Dynamic>;

	/**
		The `replServer.defineCommand()` method is used to add new `.`-prefixed commands to the REPL instance.
	**/
	@:overload(function(keyword:String, cmd:(rest:String) -> Void):Void {})
	function defineCommand(keyword:String, cmd:REPLServerOptions):Void;

	/**
		The `replServer.displayPrompt()` method readies the REPL instance for input from the user.
	**/
	function displayPrompt(?preserveCursor:Bool):Void;

	/**
		The `replServer.clearBufferedCommand()` method clears any command that has been buffered but not yet executed.
	**/
	function clearBufferedCommand():Void;

	/**
		Initializes a history log file for the REPL instance.
	**/
	function setupHistory(historyPath:String, callback:(err:Null<Error>, repl:Null<REPLServer>) -> Void):Void;
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
	var action:(rest:String) -> Void;
}
