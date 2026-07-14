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

/**
	Information about a mounted file system from `Fs.statfs` / `Fs.statfsSync`.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#class-fsstatsfs
**/
extern class StatsFs {
	/**
		Type of file system.
	**/
	var type:Float;

	/**
		Optimal transfer block size.
	**/
	var bsize:Int;

	/**
		Fundamental file system block size.
	**/
	var frsize:Int;

	/**
		Total data blocks in file system.
	**/
	var blocks:Float;

	/**
		Free blocks in file system.
	**/
	var bfree:Float;

	/**
		Free blocks available to unprivileged users.
	**/
	var bavail:Float;

	/**
		Total file nodes in file system.
	**/
	var files:Float;

	/**
		Free file nodes in file system.
	**/
	var ffree:Float;
}
