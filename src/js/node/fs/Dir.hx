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

package js.node.fs;

#if haxe4
import js.lib.Error;
#else
import js.Error;
#end

/**
	A class representing a directory stream.

	Created by `Fs.opendir` or `Fs.opendirSync`.
**/
@:jsRequire("fs", "Dir")
extern class Dir {
	/**
		The read-only path of this directory as was provided to `Fs.opendir` / `Fs.opendirSync`.
	**/
	var path(default, null):String;

	/**
		Asynchronously close the directory's underlying resource handle.
		Subsequent reads will result in errors.
	**/
	function close(callback:Error->Void):Void;

	/**
		Synchronously close the directory's underlying resource handle.
		Subsequent reads will result in errors.
	**/
	function closeSync():Void;

	/**
		Asynchronously read the next directory entry via readdir(3) as a `Dirent`.

		The callback is called with a `Dirent`, or `null` if there are no more directory entries to read.
	**/
	function read(callback:Error->Null<Dirent>->Void):Void;

	/**
		Synchronously read the next directory entry as a `Dirent`.

		If there are no more directory entries to read, `null` will be returned.
	**/
	function readSync():Null<Dirent>;
}
