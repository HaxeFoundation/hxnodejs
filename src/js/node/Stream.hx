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

package js.node;

import haxe.extern.Rest;
import js.node.events.EventEmitter;
import js.node.stream.Readable.IReadable;
import js.node.stream.Writable.IWritable;
#if haxe4
import js.lib.Error;
import js.lib.Promise;
#else
import js.Error;
import js.Promise;
#end

/**
	Base class for all streams.
**/
@:jsRequire("stream") // the module itself is also a class
extern class Stream<TSelf:Stream<TSelf>> extends EventEmitter<TSelf> implements IStream {
	private function new();

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

		@see https://nodejs.org/api/stream.html#streamfinishedstream-options-callback
	**/
	@:overload(function(stream:IStream, callback:Null<Error>->Void):Void {})
	@:overload(function(stream:IStream, options:StreamFinishedOptions, callback:Null<Error>->Void):Void {})
	static function finished(stream:IStream, ?options:StreamFinishedOptions):Promise<Void>;

	/**
		Returns whether the stream is readable.

		@see https://nodejs.org/api/stream.html#streamisreadablestream
	**/
	static function isReadable(stream:Dynamic):Bool;

	/**
		Returns whether the stream is writable.

		@see https://nodejs.org/api/stream.html#streamiswritablestream
	**/
	static function isWritable(stream:Dynamic):Bool;

	/**
		Returns whether the stream has been destroyed.

		@see https://nodejs.org/api/stream.html#streamisdestroyedstream
	**/
	static function isDestroyed(stream:Dynamic):Bool;

	/**
		Returns whether the stream has been read from or written to.

		@see https://nodejs.org/api/stream.html#streamisdisturbedstream
	**/
	static function isDisturbed(stream:Dynamic):Bool;

	/**
		Returns whether the stream has encountered an error.

		@see https://nodejs.org/api/stream.html#streamiserroredstream
	**/
	static function isErrored(stream:Dynamic):Bool;
}

/**
	Options for `Stream.finished`.
**/
typedef StreamFinishedOptions = {
	/**
		If `true`, emit `'error'` as an `'error'` event instead of rejecting the Promise / calling the callback.
	**/
	@:optional var error:Bool;

	/**
		Makes `finished()` wait until the stream ends before calling the callback / resolving the Promise if the stream is readable.
	**/
	@:optional var readable:Bool;

	/**
		Makes `finished()` wait until the stream ends before calling the callback / resolving the Promise if the stream is writable.
	**/
	@:optional var writable:Bool;
}

/**
	`IStream` interface is used as "any Stream".

	See `Stream` for actual class.
**/
@:remove
extern interface IStream extends IEventEmitter {}
