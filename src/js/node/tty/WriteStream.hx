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

package js.node.tty;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.events.EventEmitter;

/**
	Enumeration of events emitted by `WriteStream` objects in addition to its parents.
**/
enum abstract WriteStreamEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted by refreshSize() when either of the columns or rows properties has changed.
	**/
	var Resize:WriteStreamEvent<Void->Void> = "resize";
}

/**
	Direction for `WriteStream.clearLine`.
**/
enum abstract WriteStreamClearLineDirection(Int) from Int to Int {
	var Left = -1;
	var Right = 1;
	var EntireLine = 0;
}

/**
	A net.Socket subclass that represents the writable portion of a tty.
	In normal circumstances, process.stdout will be the only tty.WriteStream instance
	ever created (and only when isatty(1) is true).
**/
@:jsRequire("tty", "WriteStream")
extern class WriteStream extends js.node.net.Socket {
	function new(fd:Int);

	/**
		The number of columns the TTY currently has.
		This property gets updated on "resize" events.
	**/
	var columns(default, null):Int;

	/**
		The number of rows the TTY currently has.
		This property gets updated on "resize" events.
	**/
	var rows(default, null):Int;

	/**
		`writeStream.clearLine()` clears the current line of this `WriteStream` in a direction identified by `dir`.
	**/
	function clearLine(dir:WriteStreamClearLineDirection, ?callback:Void->Void):Bool;

	/**
		`writeStream.clearScreenDown()` clears this `WriteStream` from the current cursor down.
	**/
	function clearScreenDown(?callback:Void->Void):Bool;

	/**
		`writeStream.cursorTo()` moves this `WriteStream`'s cursor to the specified position.
	**/
	@:overload(function(x:Int, callback:Void->Void):Bool {})
	function cursorTo(x:Int, ?y:Int, ?callback:Void->Void):Bool;

	/**
		`writeStream.moveCursor()` moves this `WriteStream`'s cursor relative to its current position.
	**/
	function moveCursor(dx:Int, dy:Int, ?callback:Void->Void):Bool;

	/**
		Returns:
		- `1` for 2,
		- `4` for 16,
		- `8` for 256,
		- `24` for 16,777,216 colors supported.
	**/
	function getColorDepth(?env:DynamicAccess<String>):Int;

	/**
		`writeStream.getWindowSize()` returns the size of the TTY corresponding to this `WriteStream`
		as `[numColumns, numRows]`.
	**/
	function getWindowSize():Array<Int>;

	/**
		Returns `true` if the `writeStream` supports at least as many colors as provided in `count`.
	**/
	@:overload(function(env:DynamicAccess<String>):Bool {})
	@:overload(function(count:Int, ?env:DynamicAccess<String>):Bool {})
	function hasColors(?count:EitherType<Int, DynamicAccess<String>>, ?env:DynamicAccess<String>):Bool;
}
