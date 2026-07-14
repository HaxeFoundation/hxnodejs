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

package js.node.readline;

import js.lib.Promise;
import js.node.Readline.ClearLineDirection;
import js.node.stream.Writable.IWritable;

/**
	Options for constructing a `PromisesReadline`.
**/
typedef PromisesReadlineOptions = {
	/**
		If `true`, no need to call `commit()`.
	**/
	@:optional var autoCommit:Bool;
}

/**
	The `readlinePromises.Readline` class provides an abstraction for collecting
	pending actions on a TTY stream and applying them with `commit()`.

	@see https://nodejs.org/docs/latest-v24.x/api/readline.html#class-readlinepromisesreadline
**/
@:jsRequire("readline/promises", "Readline")
extern class PromisesReadline {
	function new(stream:IWritable, ?options:PromisesReadlineOptions);

	/**
		Adds an action that clears the current line of the associated stream.
	**/
	function clearLine(dir:ClearLineDirection):PromisesReadline;

	/**
		Adds an action that clears the associated stream from the current cursor position down.
	**/
	function clearScreenDown():PromisesReadline;

	/**
		Sends all pending actions to the associated stream and clears the internal list.
	**/
	function commit():Promise<Void>;

	/**
		Adds an action that moves the cursor to the specified position.
	**/
	function cursorTo(x:Int, ?y:Int):PromisesReadline;

	/**
		Adds an action that moves the cursor relative to its current position.
	**/
	function moveCursor(dx:Int, dy:Int):PromisesReadline;

	/**
		Clears the internal list of pending actions without sending it to the stream.
	**/
	function rollback():PromisesReadline;
}
