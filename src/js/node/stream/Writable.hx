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
import js.node.events.EventEmitter.Event;
import js.node.Stream;
import js.node.stream.Readable.IReadable;
#if haxe4
import js.lib.Error;
import js.lib.Uint8Array;
#else
import js.Error;
import js.html.Uint8Array;
#end

/**
	Writable streams are an abstraction for a destination to which data is written.

	@see https://nodejs.org/api/stream.html#stream_writable_streams
**/
@:enum abstract WritableEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		The `'close'` event is emitted when the stream and any of its underlying resources (a file descriptor, for example) have been closed. The event indicates that no more events will be emitted, and no further computation will occur.

		@see https://nodejs.org/api/stream.html#stream_event_close
	**/
	var Close:WritableEvent<Void->Void> = "close";

	/**
		If a call to stream.write(chunk) returns `false`, the `'drain'` event will be emitted when it is appropriate to resume writing data to the stream.

		@see https://nodejs.org/api/stream.html#stream_event_drain
	**/
	var Drain:WritableEvent<Void->Void> = "drain";

	/**
		The `'error'` event is emitted if an `error` occurred while writing or piping data. The listener callback is passed a single Error argument when called.

		@see https://nodejs.org/api/stream.html#stream_event_error
	**/
	var Error:WritableEvent<Error->Void> = "error";

	/**
		The `'finish'` event is emitted after the stream.end() method has been called, and all data has been flushed to the underlying system.

		@see https://nodejs.org/api/stream.html#stream_event_finish
	**/
	var Finish:WritableEvent<Void->Void> = "finish";

	/**
		The `'pipe'` event is emitted when the stream.pipe() method is called on a readable stream, adding this writable to its set of destinations.

		@see https://nodejs.org/api/stream.html#stream_event_pipe
	**/
	var Pipe:WritableEvent<IReadable->Void> = "pipe";

	/**
		The `'unpipe'` event is emitted when the stream.unpipe() method is called on a Readable stream, removing this Writable from its set of destinations.

		@see https://nodejs.org/api/stream.html#stream_event_unpipe
	**/
	var Unpipe:WritableEvent<IReadable->Void> = "unpipe";
}

/**
	The Writable stream interface is an abstraction for a destination that you are writing data to.

	Examples of writable streams include:
		- http requests, on the client
		- http responses, on the server
		- fs write streams
		- zlib streams
		- crypto streams
		- tcp sockets
		- child process stdin
		- process.stdout, process.stderr
**/
@:jsRequire("stream", "Writable")
extern class Writable<TSelf:Writable<TSelf>> extends Stream<TSelf> implements IWritable {
	/**
		The `writable.cork()` method forces all written data to be buffered in memory. The buffered data will be flushed when either the stream.uncork() or stream.end() methods are called.

		@see https://nodejs.org/api/stream.html#stream_writable_cork
	**/
	function cork():Void;

	/**
		Destroy the stream. Optionally emit an `'error'` event, and emit a `'close'` event unless `emitClose` is set in `false`.
		After this call, the writable stream has ended and subsequent calls to `write()` or `end()` will result in an `ERR_STREAM_DESTROYED` error.
		This is a destructive and immediate way to destroy a stream. Previous calls to `write()` may not have drained, and may trigger an `ERR_STREAM_DESTROYED` error.
		Use `end()` instead of destroy if data should flush before close, or wait for the `'drain'` event before destroying the stream. Implementors should not override this method, but instead implement writable._destroy().

		@see https://nodejs.org/api/stream.html#stream_writable_destroy_error
	**/
	function destroy(?error:Error):Writable<TSelf>;

	/**
		Is `true` after writable.destroy() has been called.

		@see https://nodejs.org/api/stream.html#stream_writable_destroyed
	**/
	var destroyed(default, null):Bool;

	/**
		Calling the `writable.end()` method signals that no more data will be written to the Writable.
		The optional `chunk` and `encoding` arguments allow one final additional chunk of data to be written immediately before closing the stream.
		If provided, the optional `callback` function is attached as a listener for the 'finish' event.

		@see https://nodejs.org/api/stream.html#stream_writable_end_chunk_encoding_callback
	**/
	@:overload(function(?callback:Void->Void):Void {})
	@:overload(function(chunk:Dynamic, ?callback:Null<Error>->Void):Void {})
	function end(chunk:String, ?encoding:String, ?callback:Null<Error>->Void):Void;

	/**
		The `writable.setDefaultEncoding()` method sets the default `encoding` for a Writable stream.

		@see https://nodejs.org/api/stream.html#stream_writable_setdefaultencoding_encoding
	**/
	function setDefaultEncoding(encoding:String):Writable<TSelf>;

	/**
		Is `true` after `writable.destroy()` has been called.

		@see https://nodejs.org/api/stream.html#stream_writable_destroyed
	**/
	function uncork():Void;

	/**
		Is `true` if it is safe to call `writable.write()`.

		@see https://nodejs.org/api/stream.html#stream_writable_writable
	**/
	var writable(default, null):Bool;

	/**
		Is `true` after `writable.end()` has been called. This property
		does not indicate whether the data has been flushed, for this use
		`writable.writableFinished` instead.

		@seehttps://nodejs.org/api/stream.html#stream_writable_writableended
	**/
	var writableEnded(default, null):Bool;

	/**
		Is set to `true` immediately before the 'finish' event is emitted.

		@see https://nodejs.org/api/stream.html#stream_writable_writablefinished
	**/
	var writableFinished(default, null):Bool;

	/**
		Return the value of `highWaterMark` passed when constructing this `Writable`.

		@see https://nodejs.org/api/stream.html#stream_writable_writablehighwatermark
	**/
	var writablehighWaterMark(default, null):Int;

	/**
		This property contains the number of bytes (or objects) in the queue ready to be written.
		The value provides introspection data regarding the status of the `highWaterMark`.

		@see https://nodejs.org/api/stream.html#stream_writable_writablelength
	**/
	var writableLength(default, null):Int;

	/**
		Getter for the property `objectMode` of a given `Writable` stream.

		@see https://nodejs.org/api/stream.html#stream_writable_writableobjectmode
	**/
	var writableObjectMode(default, null):Bool;

	/**
		The `writable.write()` method writes some data to the stream, and calls the supplied `callback` once the data has been fully handled.
		If an error occurs, the `callback` may or may not be called with the error as its first argument.
		To reliably detect write errors, add a listener for the `'error'` event.

		@see https://nodejs.org/api/stream.html#stream_writable_write_chunk_encoding_callback
	**/
	@:overload(function(chunk:Dynamic, ?callback:Null<Error>->Void):Bool {})
	function write(chunk:String, ?encoding:String, ?callback:Null<Error>->Void):Bool;

	/**
		@see https://nodejs.org/api/stream.html#stream_constructor_new_stream_writable_options
	**/
	private function new(?options:WritableNewOptions);

	/**
		All `Writable` stream implementations must provide a writable._write() method to send data to the underlying resource.

		@see https://nodejs.org/api/stream.html#stream_writable_write_chunk_encoding_callback_1
	**/
	@:overload(function(chunk:Dynamic, ?callback:Null<Error->Void>):Void {})
	private function _write(chunk:String, ?encoding:String, ?callback:Null<Error>->Void):Void;

	/**
		This function MUST NOT be called by application code directly. It should be implemented by child classes, and called by the internal `Writable` class methods only.

		@see https://nodejs.org/api/stream.html#stream_writable_writev_chunks_callback
	**/
	private function _writev(chunks:Array<Chunk>, callback:Null<Error>->Void):Void;

	/**
		The `_destroy()` method is called by writable.destroy(). It can be overridden by child classes but it must not be called directly.

		@see https://nodejs.org/api/stream.html#stream_writable_destroy_err_callback
	**/
	private function _destroy(err:Null<Error>, callback:Null<Error>->Void):Void;

	/**
		The `_final()` method must not be called directly. It may be implemented by child classes, and if so, will be called by the internal `Writable` class methods only.

		@see https://nodejs.org/api/stream.html#stream_writable_final_callback
	**/
	private function _final(callback:Null<Error>->Void):Void;

	/**
		Terminal write streams (i.e. process.stdout) have this property set to true.
		It is false for any other write streams.
	**/
	var isTTY(default, null):Bool;
} /**
	@see https://nodejs.org/api/stream.html#stream_constructor_new_stream_writable_options
**/

typedef WritableNewOptions = {
	/**
		`highWaterMark` <number> Buffer level when stream.write() starts returning `false`. Default: `16384` (16kb), or 16 for `objectMode` streams.
	**/
	@:optional var highWaterMark:Int;

	/**
		`decodeStrings` <boolean> Whether to encode `string`s passed to stream.write() to `Buffer`s (with the encoding specified in the stream.write() call) before passing them to stream._write().
		Other types of data are not converted (i.e. `Buffer`s are not decoded into `string`s). Setting to false will prevent strings from being converted. Default: `true`.
	**/
	@:optional var decodeStrings:Bool;

	/**
		`defaultEncoding` <string> The default encoding that is used when no encoding is specified as an argument to stream.write(). Default: `'utf8'`.
	**/
	@:optional var defaultEncoding:String;

	/**
		`objectMode` <boolean> Whether or not the stream.write(anyObj) is a valid operation. When set, it becomes possible to write JavaScript values other than string, `Buffer` or `Uint8Array` if supported by the stream implementation. Default: `false`.
	**/
	@:optional var objectMode:Bool;

	/**
		`emitClose` <boolean> Whether or not the stream should emit `'close'` after it has been destroyed. Default: `true`.
	**/
	@:optional var emitClose:Bool;

	/**
		`write` <Function> Implementation for the stream._write() method.
	**/
	@:optional var write:(EitherType<Buffer, EitherType<String, Any>>, String, (Null<Error>->Void)) -> Void;

	/**
		`writev` <Function> Implementation for the stream._writev() method.
	**/
	@:optional var writev:(Array<Chunk>, (Null<Error>->Void)) -> Void;

	/**
		`destroy` <Function> Implementation for the stream._destroy() method.
	**/
	@:optional var destroy:(Null<Error>, (Null<Error>->Void)) -> Void;

	/**
		`final` <Function> Implementation for the stream._final() method.
	**/
	// TODO @native in typedef cannot work now
	//	@:native("final")
	//	@:optional var _final:Null<Error>->Void;

	/**
		`autoDestroy` <boolean> Whether this stream should automatically call .destroy() on itself after ending. Default: false.
	**/
	@:optional var autoDestroy:Bool;
}

/**
	Writable interface used for type parameter constraints.
	See `Writable` for actual class documentation.
**/
@:remove
extern interface IWritable extends IStream {
	@:overload(function(chunk:Dynamic, ?callback:Null<Error>->Void):Bool {})
	function write(chunk:String, ?encoding:String, ?callback:Null<Error>->Void):Bool;
	@:overload(function(?callback:Void->Void):Void {})
	@:overload(function(chunk:Dynamic, ?callback:Null<Error>->Void):Void {})
	function end(chunk:String, ?encoding:String, ?callback:Null<Error>->Void):Void;
	function cork():Void;
	function uncork():Void;
	function setDefaultEncoding(encoding:String):IWritable;
	var isTTY(default, null):Bool;
}

typedef Chunk = {
	var chunk:EitherType<Buffer, EitherType<String, Any>>;
	var encoding:String;
}
