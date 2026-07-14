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

package js.node.zlib;

/**
	Not exported by the zlib module.
	Documented here as the base class of the compressor/decompressor classes.

	Renamed from `Zlib` to `ZlibBase` in Node.js documentation (v11.7.0+);
	this type keeps the historical Haxe name.

	@see https://nodejs.org/docs/latest-v24.x/api/zlib.html#class-zlibzlibbase
**/
extern class Zlib extends js.node.stream.Transform<Zlib> {
	/**
		The number of bytes written to the engine before the bytes are processed
		(compressed or decompressed, as appropriate for the derived class).
	**/
	var bytesWritten(default, null):Float;

	/**
		Close the underlying handle.
	**/
	function close(?callback:Void->Void):Void;

	/**
		Flush pending data.

		`kind` defaults to `js.node.Zlib.constants.Z_FULL_FLUSH` for zlib-based streams,
		`js.node.Zlib.constants.BROTLI_OPERATION_FLUSH` for Brotli-based streams, and
		`js.node.Zlib.constants.ZSTD_e_flush` for Zstd-based streams.

		Don't call this frivolously; premature flushes negatively impact the
		effectiveness of the compression algorithm.
	**/
	@:overload(function(kind:Int, callback:Void->Void):Void {})
	function flush(callback:Void->Void):Void;

	/**
		Dynamically update the compression level and compression strategy.
		Only available for zlib-based (deflate) streams — not Brotli or Zstd.
	**/
	function params(level:Int, strategy:Int, callback:Void->Void):Void;

	/**
		Reset the compressor/decompressor to factory defaults.
		Only applicable to the inflate and deflate algorithms.
	**/
	function reset():Void;
}
