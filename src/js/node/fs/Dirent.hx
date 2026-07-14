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

package js.node.fs;

import haxe.extern.EitherType;
import js.node.Buffer;

/**
	A directory entry returned by `Dir.read` / `Fs.readdir` / `Fs.glob` when `withFileTypes` is `true`.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#class-fsdirent
**/
extern class Dirent {
	/**
		The file name that this `Dirent` object refers to.
		The type of this value is determined by the `encoding` option.
	**/
	var name:EitherType<String, Buffer>;

	/**
		The path to the parent directory of the file this `Dirent` object refers to.
	**/
	var parentPath:String;

	/**
		Returns `true` if this `Dirent` describes a regular file.
	**/
	function isFile():Bool;

	/**
		Returns `true` if this `Dirent` describes a file system directory.
	**/
	function isDirectory():Bool;

	/**
		Returns `true` if this `Dirent` describes a block device.
	**/
	function isBlockDevice():Bool;

	/**
		Returns `true` if this `Dirent` describes a character device.
	**/
	function isCharacterDevice():Bool;

	/**
		Returns `true` if this `Dirent` describes a symbolic link.
	**/
	function isSymbolicLink():Bool;

	/**
		Returns `true` if this `Dirent` describes a first-in-first-out (FIFO) pipe.
	**/
	function isFIFO():Bool;

	/**
		Returns `true` if this `Dirent` describes a socket.
	**/
	function isSocket():Bool;
}
