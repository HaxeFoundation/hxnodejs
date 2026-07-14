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

package js.node.tty;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.events.EventEmitter.Event;

/**
	Enumeration of events emitted by `WriteStream` objects in addition to its parents.
**/
enum abstract WriteStreamEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted whenever either of the `columns` or `rows` properties has changed.
		No arguments are passed to the listener callback when called.

		@see https://nodejs.org/api/tty.html#event-resize
	**/
	var Resize:WriteStreamEvent<Void->Void> = "resize";
}

/**
	Direction for `WriteStream.clearLine`.

	@see https://nodejs.org/api/tty.html#writestreamclearlinedir-callback
**/
enum abstract WriteStreamClearLineDirection(Int) from Int to Int {
	/** To the left from the cursor. **/
	var Left = -1;
	/** To the right from the cursor. **/
	var Right = 1;
	/** The entire line. **/
	var EntireLine = 0;
}

/**
	Represents the writable side of a TTY. In normal circumstances, `process.stdout`
	and `process.stderr` will be the only `tty.WriteStream` instances created for a
	Node.js process and there should be no reason to create additional instances.

	`isTTY` is always `true` for `tty.WriteStream` instances (inherited from the stream hierarchy).

	@see https://nodejs.org/api/tty.html#class-ttywritestream
**/
@:jsRequire("tty", "WriteStream")
extern class WriteStream extends js.node.net.Socket {
	/**
		Creates a `WriteStream` for `fd` associated with a TTY.

		@see https://nodejs.org/api/tty.html#new-ttywritestreamfd
	**/
	function new(fd:Int);

	/**
		A number specifying the number of columns the TTY currently has.
		This property is updated whenever the `'resize'` event is emitted.

		@see https://nodejs.org/api/tty.html#writestreamcolumns
	**/
	var columns(default, null):Int;

	/**
		A number specifying the number of rows the TTY currently has.
		This property is updated whenever the `'resize'` event is emitted.

		@see https://nodejs.org/api/tty.html#writestreamrows
	**/
	var rows(default, null):Int;

	/**
		Clears the current line of this `WriteStream` in a direction identified by `dir`.

		Returns `false` if the stream wishes for the calling code to wait for the `'drain'`
		event to be emitted before continuing to write additional data; otherwise `true`.

		@see https://nodejs.org/api/tty.html#writestreamclearlinedir-callback
	**/
	function clearLine(dir:WriteStreamClearLineDirection, ?callback:Void->Void):Bool;

	/**
		Clears this `WriteStream` from the current cursor down.

		Returns `false` if the stream wishes for the calling code to wait for the `'drain'`
		event to be emitted before continuing to write additional data; otherwise `true`.

		@see https://nodejs.org/api/tty.html#writestreamclearscreendowncallback
	**/
	function clearScreenDown(?callback:Void->Void):Bool;

	/**
		Moves this `WriteStream`'s cursor to the specified position.

		Returns `false` if the stream wishes for the calling code to wait for the `'drain'`
		event to be emitted before continuing to write additional data; otherwise `true`.

		@see https://nodejs.org/api/tty.html#writestreamcursortox-y-callback
	**/
	@:overload(function(x:Int, callback:Void->Void):Bool {})
	function cursorTo(x:Int, ?y:Int, ?callback:Void->Void):Bool;

	/**
		Moves this `WriteStream`'s cursor relative to its current position.

		Returns `false` if the stream wishes for the calling code to wait for the `'drain'`
		event to be emitted before continuing to write additional data; otherwise `true`.

		@see https://nodejs.org/api/tty.html#writestreammovecursordx-dy-callback
	**/
	function moveCursor(dx:Int, dy:Int, ?callback:Void->Void):Bool;

	/**
		Returns the color depth supported by the terminal:

		- `1` for 2,
		- `4` for 16,
		- `8` for 256,
		- `24` for 16,777,216 colors supported.

		Pass `env` to simulate the usage of a specific terminal (defaults to `process.env`).

		@see https://nodejs.org/api/tty.html#writestreamgetcolordepthenv
	**/
	function getColorDepth(?env:DynamicAccess<String>):Int;

	/**
		Returns the size of the TTY corresponding to this `WriteStream` as `[numColumns, numRows]`.

		@see https://nodejs.org/api/tty.html#writestreamgetwindowsize
	**/
	function getWindowSize():Array<Int>;

	/**
		Returns `true` if the `writeStream` supports at least as many colors as provided in `count`.
		Minimum support is 2 (black and white). Default `count` is 16.

		Pass `env` to simulate the usage of a specific terminal (defaults to `process.env`).

		@see https://nodejs.org/api/tty.html#writestreamhascolorscount-env
	**/
	@:overload(function(env:DynamicAccess<String>):Bool {})
	@:overload(function(count:Int, ?env:DynamicAccess<String>):Bool {})
	function hasColors(?count:EitherType<Int, DynamicAccess<String>>, ?env:DynamicAccess<String>):Bool;
}
