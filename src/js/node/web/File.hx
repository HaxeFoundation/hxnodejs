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

package js.node.web;

import js.node.web.Blob.BlobPart;

/**
	Provides information about files. Extends `Blob`.

	Also available via `require('node:buffer').File`.

	@see https://nodejs.org/api/buffer.html#class-file
	@see https://nodejs.org/api/globals.html#class-file
**/
@:native("File")
extern class File extends Blob {
	/**
		The name of the file.
	**/
	var name(default, null):String;

	/**
		The last modified date of the file (milliseconds since UNIX epoch).
	**/
	var lastModified(default, null):Float;

	function new(sources:Array<BlobPart>, fileName:String, ?options:FilePropertyBag):Void;
}

/**
	Options for the `File` constructor.
**/
typedef FilePropertyBag = {
	/**
		One of `'transparent'` or `'native'`.
	**/
	@:optional var endings:String;

	/**
		The File content-type.
	**/
	@:optional var type:String;

	/**
		The last modified date of the file. Default: `Date.now()`.
	**/
	@:optional var lastModified:Float;
}
