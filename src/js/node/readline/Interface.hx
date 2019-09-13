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

package js.node.readline;

import haxe.extern.EitherType;
import js.node.events.EventEmitter;

/**
	Enumeration of events emitted by the `Interface` objects.
**/
@:enum abstract InterfaceEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted whenever the input stream receives a \n, usually received when the user hits enter, or return.
		This is a good hook to listen for user input.
	**/
	var Line:InterfaceEvent<String->Void> = "line";

	/**
		Emitted whenever the input stream is paused.
		Also emitted whenever the input stream is not paused and receives the SIGCONT event. (See events SIGTSTP and SIGCONT)
	**/
	var Pause:InterfaceEvent<Void->Void> = "pause";

	/**
		Emitted whenever the input stream is resumed.
	**/
	var Resume:InterfaceEvent<Void->Void> = "resume";

	/**
		Emitted when close() is called.

		Also emitted when the input stream receives its "end" event.
		The `Interface` instance should be considered "finished" once this is emitted.
		For example, when the input stream receives ^D, respectively known as EOT.

		This event is also called if there is no SIGINT event listener present when the input stream receives a ^C,
		respectively known as SIGINT.
	**/
	var Close:InterfaceEvent<Void->Void> = "close";

	/**
		Emitted whenever the input stream receives a ^C, respectively known as SIGINT.
		If there is no SIGINT event listener present when the input stream receives a SIGINT, pause will be triggered.
	**/
	var SIGINT:InterfaceEvent<Void->Void> = "SIGINT";

	/**
		This does not work on Windows.

		Emitted whenever the input stream receives a ^Z, respectively known as SIGTSTP.
		If there is no SIGTSTP event listener present when the input stream receives a SIGTSTP,
		the program will be sent to the background.

		When the program is resumed with fg, the pause and SIGCONT events will be emitted.
		You can use either to resume the stream.

		The pause and SIGCONT events will not be triggered if the stream was paused
		before the program was sent to the background.
	**/
	var SIGTSTP:InterfaceEvent<Void->Void> = "SIGTSTP";

	/**
		This does not work on Windows.

		Emitted whenever the input stream is sent to the background with ^Z, respectively known as SIGTSTP,
		and then continued with fg(1). This event only emits if the stream was not paused before sending
		the program to the background.
	**/
	var SIGCONT:InterfaceEvent<Void->Void> = "SIGCONT";
}

/**
	Key sequence passed as the `key` argument to `Interface.write`.
**/
typedef InterfaceWriteKey = {
	var name:String;
	@:optional var ctrl:Bool;
	@:optional var meta:Bool;
	@:optional var shift:Bool;
}

/**
	Instances of the `readline.Interface` class are constructed using the `readline.createInterface()` method.

	@see https://nodejs.org/api/readline.html#readline_class_interface
**/
extern class Interface extends EventEmitter<Interface> {
	/**
		Closes the `readline.Interface` instance and relinquishes control over the input and output streams.

		@see https://nodejs.org/api/readline.html#readline_rl_close
	**/
	function close():Void;

	/**
		Pauses the `input` stream, allowing it to be resumed later if necessary.

		@see https://nodejs.org/api/readline.html#readline_rl_pause
	**/
	function pause():Void;

	/**
		Writes the `readline.Interface` instances configured `prompt` to a new line in `output` in order to provide a
		user with a new location at which to provide input.

		@see https://nodejs.org/api/readline.html#readline_rl_prompt_preservecursor
	**/
	function prompt(?preserveCursor:Bool):Void;

	/**
		Displays the `query` by writing it to the `output`, waits for user `input` to be provided on input, then invokes
		the `callback` function passing the provided input as the first argument.

		@see https://nodejs.org/api/readline.html#readline_rl_question_query_callback
	**/
	function question(query:String, callback:String->Void):Void;

	/**
		Resumes the `input` stream if it has been paused.

		@see https://nodejs.org/api/readline.html#readline_rl_resume
	**/
	function resume():Void;

	/**
		Sets the prompt that will be written to `output` whenever `rl.prompt()` is called.

		@see https://nodejs.org/api/readline.html#readline_rl_setprompt_prompt
	**/
	function setPrompt(prompt:String):Void;

	/**
		Write either `data` or a key sequence identified by `key` to the `output`.

		@see https://nodejs.org/api/readline.html#readline_rl_write_data_key
	**/
	function write(data:Null<String>, ?key:InterfaceWriteKey):Void;
}
