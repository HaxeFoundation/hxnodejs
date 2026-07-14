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

import haxe.extern.Rest;
import js.lib.Error;
import js.lib.Promise;
import js.node.events.EventEmitter;
import js.node.stream.Duplex.IDuplex;
import js.node.stream.Readable.IReadable;
import js.node.stream.Writable.IWritable;
import js.node.web.AbortSignal;

/**
	Base class for all streams.
	Also the `stream` module façade exporting stream helpers and constructors.

	@see https://nodejs.org/api/stream.html
**/
@:jsRequire("stream") // the module itself is also a class
extern class Stream<TSelf:Stream<TSelf>> extends EventEmitter<TSelf> implements IStream {
	private function new();

	/**
		Promise-based stream helpers (`stream/promises`).

		@see https://nodejs.org/api/stream.html#streams-promises-api
	**/
	static final promises:StreamPromises;

	/**
		A module method to pipe between streams forwarding errors and properly cleaning up
		and provide a callback when the pipeline is complete.

		@see https://nodejs.org/api/stream.html#stream_stream_pipeline_streams_callback
	**/
	@:overload(function(readable:IReadable, callback:Null<Error>->Void):Void {})
	@:overload(function(readable:IReadable, writable1:IWritable, callback:Null<Error>->Void):Void {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, callback:Null<Error>->Void):Void {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, callback:Null<Error>->Void):Void {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, writable4:IWritable,
		callback:Null<Error>->Void):Void {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, writable4:IWritable, writable5:IWritable,
		callback:Null<Error>->Void):Void {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, writable4:IWritable, writable5:IWritable,
		writable6:IWritable, callback:Null<Error>->Void):Void {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, writable4:IWritable, writable5:IWritable,
		writable6:IWritable, writable7:IWritable, callback:Null<Error>->Void):Void {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, writable4:IWritable, writable5:IWritable,
		writable6:IWritable, writable7:IWritable, writable8:IWritable, callback:Null<Error>->Void):Void {})
	static function pipeline(readable:IReadable, streams:Rest<IWritable>):Promise<Void>;

	/**
		A module method to wait for a readable or writable stream to finish.

		The callback form returns a cleanup function that removes registered listeners.

		@see https://nodejs.org/api/stream.html#streamfinishedstream-options-callback
	**/
	@:overload(function(stream:IStream, callback:Null<Error>->Void):Void->Void {})
	@:overload(function(stream:IStream, options:StreamFinishedOptions, callback:Null<Error>->Void):Void->Void {})
	static function finished(stream:IStream, ?options:StreamFinishedOptions):Promise<Void>;

	/**
		Combines two or more streams into a `Duplex` stream that writes to the first
		stream and reads from the last.

		Pass `StreamComposeOptions` (for example `{signal: ...}`) as the last argument when needed.

		@see https://nodejs.org/api/stream.html#streamcomposestreams
	**/
	static function compose(streams:Rest<Any>):IDuplex;

	/**
		Returns a pair of connected Duplex streams where data written to either side
		appears on the other.

		@see https://nodejs.org/api/stream.html#streamduplexpairoptions
	**/
	static function duplexPair(?options:js.node.stream.Duplex.DuplexNewOptions):Array<IDuplex>;

	/**
		Attaches an AbortSignal to a readable or writable stream so destroying
		the stream when the signal is aborted.

		@see https://nodejs.org/api/stream.html#streamaddabortsignalsignal-stream
	**/
	static function addAbortSignal(signal:AbortSignal, stream:IStream):IStream;

	/**
		Destroys the stream, optionally with an error.

		Exported by the `stream` module (undocumented helper used by pipeline cleanup).
	**/
	static function destroy(stream:IStream, ?error:Error):Void;

	/**
		Returns the default highWaterMark used by streams.

		@see https://nodejs.org/api/stream.html#streamgetdefaulthighwatermarkobjectmode
	**/
	static function getDefaultHighWaterMark(objectMode:Bool):Int;

	/**
		Sets the default highWaterMark used by streams.

		@see https://nodejs.org/api/stream.html#streamsetdefaulthighwatermarkobjectmode-value
	**/
	static function setDefaultHighWaterMark(objectMode:Bool, value:Int):Void;

	/**
		Returns whether the stream is readable.

		Returns `null` if `stream` is not a valid readable stream.

		@see https://nodejs.org/api/stream.html#streamisreadablestream
	**/
	static function isReadable(stream:Any):Null<Bool>;

	/**
		Returns whether the stream is writable.

		Returns `null` if `stream` is not a valid writable stream.

		@see https://nodejs.org/api/stream.html#streamiswritablestream
	**/
	static function isWritable(stream:Any):Null<Bool>;

	/**
		Returns whether the stream has been destroyed.

		Exported by the `stream` module (undocumented helper; available since Node 16+).
	**/
	static function isDestroyed(stream:Any):Bool;

	/**
		Returns whether the stream has been read from or cancelled.

		Also available as `Readable.isDisturbed`.

		@see https://nodejs.org/api/stream.html#streamreadableisdisturbedstream
	**/
	static function isDisturbed(stream:Any):Bool;

	/**
		Returns whether the stream has encountered an error.

		@see https://nodejs.org/api/stream.html#streamiserroredstream
	**/
	static function isErrored(stream:Any):Bool;
}

/**
	Options for `Stream.finished`.
**/
typedef StreamFinishedOptions = {
	/**
		If set to `false`, then a call to `emit('error', err)` is not treated as finished.
		Default: `true`.
	**/
	@:optional var error:Bool;

	/**
		When set to `false`, the callback / Promise will resolve when the stream ends
		even though the stream might still be readable.
		Default: `true`.
	**/
	@:optional var readable:Bool;

	/**
		When set to `false`, the callback / Promise will resolve when the stream ends
		even though the stream might still be writable.
		Default: `true`.
	**/
	@:optional var writable:Bool;

	/**
		Allows aborting the wait for the stream to finish. The underlying stream is not
		aborted if the signal is aborted. The callback / Promise rejects with an `AbortError`.
	**/
	@:optional var signal:AbortSignal;

	/**
		If `true`, removes the listeners registered by this function before the Promise is fulfilled.
		Only used by the Promise form of `finished`. Default: `false`.
	**/
	@:optional var cleanup:Bool;
}

/**
	Options for `Stream.pipeline` / `StreamPromises.pipeline`.
**/
typedef StreamPipelineOptions = {
	/**
		If specified, the pipeline will abort when the signal is aborted.
	**/
	@:optional var signal:AbortSignal;

	/**
		End the destination stream when the source stream ends. Default: `true`.
	**/
	@:optional var end:Bool;
}

/**
	Options for `Stream.compose`.
**/
typedef StreamComposeOptions = {
	/**
		Allows destroying the stream if the signal is aborted.
	**/
	@:optional var signal:AbortSignal;
}

/**
	`IStream` interface is used as "any Stream".

	See `Stream` for actual class.
**/
@:remove
extern interface IStream extends IEventEmitter {}
