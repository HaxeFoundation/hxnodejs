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

/**
	Represents the readable side of a TTY. In normal circumstances `process.stdin`
	will be the only `tty.ReadStream` instance in a Node.js process and there should
	be no reason to create additional instances.

	`isTTY` is always `true` for `tty.ReadStream` instances (inherited from the stream hierarchy).

	@see https://nodejs.org/api/tty.html#class-ttyreadstream
**/
@:jsRequire("tty", "ReadStream")
extern class ReadStream extends js.node.net.Socket {
	/**
		Creates a `ReadStream` for `fd` associated with a TTY.

		@see https://nodejs.org/api/tty.html#new-ttyreadstreamfd-options
	**/
	function new(fd:Int, ?options:js.node.net.Socket.SocketOptions);

	/**
		A `Bool` that is `true` if the TTY is currently configured to operate as a raw device.

		This flag is always `false` when a process starts, even if the terminal is operating
		in raw mode. Its value will change with subsequent calls to `setRawMode`.

		@see https://nodejs.org/api/tty.html#readstreamisraw
	**/
	var isRaw(default, null):Bool;

	/**
		Allows configuration of `tty.ReadStream` so that it operates as a raw device.

		When in raw mode, input is always available character-by-character, not including
		modifiers. Additionally, all special processing of characters by the terminal is
		disabled, including echoing input characters. Ctrl+C will no longer cause a `SIGINT`
		when in this mode.

		@see https://nodejs.org/api/tty.html#readstreamsetrawmodemode
	**/
	function setRawMode(mode:Bool):ReadStream;
}
