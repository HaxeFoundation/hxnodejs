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

package js.node;

/**
	The `node:tty` module provides the `tty.ReadStream` and `tty.WriteStream` classes.
	In most cases, it will not be necessary or possible to use this module directly.

	When Node.js detects that it is being run with a text terminal ("TTY") attached,
	`process.stdin` will, by default, be initialized as an instance of `tty.ReadStream`
	and both `process.stdout` and `process.stderr` will, by default, be instances of
	`tty.WriteStream`. The preferred method of determining whether Node.js is being run
	within a TTY context is to check that the value of the `process.stdout.isTTY`
	property is `true`.

	@see https://nodejs.org/api/tty.html
**/
@:jsRequire("tty")
extern class Tty {
	/**
		Returns `true` if the given `fd` is associated with a TTY and `false` if it is not,
		including whenever `fd` is not a non-negative integer.

		@see https://nodejs.org/api/tty.html#ttyisattyfd
	**/
	static function isatty(fd:Int):Bool;

	/**
		Removed from Node.js. Use `js.node.tty.ReadStream.setRawMode` instead.
	**/
	@:deprecated("Use js.node.tty.ReadStream.setRawMode instead")
	static function setRawMode(mode:Bool):Void;
}
