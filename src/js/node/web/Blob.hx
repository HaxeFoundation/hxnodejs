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

import haxe.extern.EitherType;
import js.lib.ArrayBuffer;
import js.lib.ArrayBufferView;
import js.lib.Promise;
import js.lib.Uint8Array;

/**
	Encapsulates immutable, raw data that can be safely shared across workers.

	Available as a global and via `require('node:buffer').Blob`.

	@see https://nodejs.org/api/buffer.html#class-blob
	@see https://nodejs.org/api/globals.html#class-blob
**/
@:native("Blob")
extern class Blob {
	/**
		The total size of the `Blob` in bytes.
	**/
	var size(default, null):Int;

	/**
		The content-type of the `Blob`.
	**/
	var type(default, null):String;

	function new(?sources:Array<BlobPart>, ?options:BlobPropertyBag):Void;

	/**
		Returns a promise that fulfills with an `ArrayBuffer` containing a copy of the `Blob` data.
	**/
	function arrayBuffer():Promise<ArrayBuffer>;

	/**
		Returns a promise that fulfills with a `Uint8Array` containing a copy of the `Blob` data.
	**/
	function bytes():Promise<Uint8Array>;

	/**
		Creates and returns a new `Blob` containing a subset of this `Blob`'s data.
	**/
	function slice(?start:Int, ?end:Int, ?type:String):Blob;

	/**
		Returns a new `ReadableStream` that allows the content of the `Blob` to be read.
	**/
	function stream():ReadableStream;

	/**
		Returns a promise that fulfills with the contents of the `Blob` decoded as a UTF-8 string.
	**/
	function text():Promise<String>;
}

/**
	A part accepted by the `Blob` / `File` constructors.
**/
typedef BlobPart = EitherType<String, EitherType<ArrayBuffer, EitherType<ArrayBufferView, Blob>>>;

/**
	Options for the `Blob` constructor.
**/
typedef BlobPropertyBag = {
	/**
		One of `'transparent'` or `'native'`. When `'native'`, line endings in string
		source parts are converted to the platform native line-ending.
	**/
	@:optional var endings:String;

	/**
		The Blob content-type (MIME media type). No validation is performed.
	**/
	@:optional var type:String;
}
