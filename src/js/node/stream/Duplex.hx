/*
 * Copyright (C)2014-2019 Haxe Foundation
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

package js.node.stream;

import haxe.extern.EitherType;
import js.node.Buffer;
#if haxe4
import js.lib.Uint8Array;
import js.lib.Error;
#else
import js.html.Uint8Array;
import js.Error;
#end

/**
	Duplex streams are streams that implement both the Readable and Writable interfaces.

	@see https://nodejs.org/api/stream.html#stream_class_stream_duplex
**/
@:jsRequire("stream", "Duplex")
extern class Duplex<TSelf:Duplex<TSelf>> extends Readable<TSelf> implements IDuplex {
	// --------- Writable interface implementation ---------

	/**
		The `writable.cork()` method forces all written data to be buffered in memory.
		The buffered data will be flushed when either the `stream.uncork()` or
		`stream.end()` methods are called.

		@see https://nodejs.org/api/stream.html#stream_writable_cork
	**/
	function cork():Void;

	/**
		Calling the `writable.end()` method signals that no more data will be written
		to the `Writable`. The optional `chunk` and `encoding` arguments allow one
		final additional chunk of data to be written immediately before closing the
		stream. If provided, the optional `callback` function is attached as a listener
		for the `'finish'` event.

		@see https://nodejs.org/api/stream.html#stream_writable_end_chunk_encoding_callback
	**/
	@:overload(function(?callback:Void->Void):Void {})
	@:overload(function(chunk:Dynamic, ?callback:Null<Error>->Void):Void {})
	function end(chunk:String, ?encoding:String, ?callback:Null<Error>->Void):Void;

	/**
		The `writable.uncork()` method flushes all data buffered since
		`stream.cork()` was called.

		@see https://nodejs.org/api/stream.html#stream_writable_uncork
	**/
	function uncork():Void;

	/**
		The `writable.write()` method writes some data to the stream, and calls the
		supplied `callback` once the data has been fully handled. If an error
		occurs, the `callback` may or may not be called with the error as its
		first argument. To reliably detect write errors, add a listener for the
		`'error'` event.

		@see https://nodejs.org/api/stream.html#stream_writable_write_chunk_encoding_callback
	**/
	@:overload(function(chunk:Dynamic, ?callback:Null<Error>->Void):Bool {})
	function write(chunk:String, ?encoding:String, ?callback:Null<Error>->Void):Bool;

	/**
		The `writable.setDefaultEncoding()` method sets the default `encoding` for a
		`Writable` stream.

		@see https://nodejs.org/api/stream.html#stream_writable_setdefaultencoding_encoding
	**/
	function setDefaultEncoding(encoding:String):TSelf;

	/**
		@see https://nodejs.org/api/stream.html#stream_implementing_a_duplex_stream
	**/
	// --------- API for stream implementors - see node.js API documentation ---------
	private function new(?options:DuplexNewOptions);

	@:overload(function(chunk:Dynamic, ?callback:Error->Void):Void {})
	private function _write(chunk:String, ?encoding:String, ?callback:Error->Void):Void;
	private function _read(size:Int):Void;

	/**
		Terminal write streams (i.e. process.stdout) have this property set to true.
		It is false for any other write streams.
	**/
	var isTTY(default, null):Bool;
}

/**
	Passed to both `Writable` and `Readable` constructors. Also has the following fields:

	@see https://nodejs.org/api/stream.html#stream_new_stream_duplex_options
**/
typedef DuplexNewOptions = {
	> Readable.ReadableNewOptions,
	> Writable.WritableNewOptions,

	/**
		If set to `false`, then the stream will automatically end the writable side when the readable side ends. Default: `true`.
	**/
	@:optional var allowHalfOpen:Bool;

	/**
		Sets `objectMode` for readable side of the stream. Has no effect if `objectMode` is `true`. Default: `false`.
	**/
	@:optional var readableObjectMode:Bool;

	/**
		Sets `objectMode` for writable side of the stream. Has no effect if `objectMode` is `true`. Default: `false`.
	**/
	@:optional var writableObjectMode:Bool;

	/**
		Sets `highWaterMark` for the readable side of the stream. Has no effect if `highWaterMark` is provided.
	**/
	@:optional var readableHighWaterMark:Int;

	/**
		Sets `highWaterMark` for the writable side of the stream. Has no effect if `highWaterMark` is provided.
	**/
	@:optional var writableHighWaterMark:Int;
}

@:remove
extern interface IDuplex extends Readable.IReadable extends Writable.IWritable {}
