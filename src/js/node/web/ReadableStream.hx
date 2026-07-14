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

import js.lib.Promise;

/**
	A browser-compatible implementation of `ReadableStream`.

	@see https://nodejs.org/api/globals.html#class-readablestream
	@see https://nodejs.org/api/webstreams.html#class-readablestream
**/
@:native("ReadableStream")
extern class ReadableStream {
	/**
		Creates a `ReadableStream` from an iterable or async iterable.
	**/
	static function from(iterable:Any):ReadableStream;

	/**
		Whether a reader is currently locked onto this stream.
	**/
	var locked(default, null):Bool;

	function new(?underlyingSource:ReadableStreamUnderlyingSource, ?strategy:QueuingStrategy):Void;

	/**
		Cancels the stream, signaling a reason why consumer is no longer interested.
	**/
	function cancel(?reason:Any):Promise<Void>;

	/**
		Creates a reader and locks this stream to it.

		When `options.mode` is `"byob"`, returns a `ReadableStreamBYOBReader`.
	**/
	@:overload(function(options:{var mode:String;}):ReadableStreamBYOBReader {})
	function getReader(?options:Any):ReadableStreamDefaultReader;

	/**
		Pipes this readable stream through a transform stream pair.
	**/
	function pipeThrough(transform:ReadableWritablePair, ?options:StreamPipeOptions):ReadableStream;

	/**
		Pipes this readable stream to a writable stream.
	**/
	function pipeTo(destination:WritableStream, ?options:StreamPipeOptions):Promise<Void>;

	/**
		Tees this readable stream, returning a pair of branching streams.
	**/
	function tee():Array<ReadableStream>;

	/**
		Async iterator over stream chunks (`[Symbol.asyncIterator]` / `values()`).
		Typed as `Any` because Haxe lacks a standard async-iterator type in 4.0.5.
	**/
	function values(?options:{@:optional var preventCancel:Bool;}):Any;
}

/**
	Underlying source object for `ReadableStream` construction.

	Callback controller arguments use stream controller types when known;
	start/pull/cancel remain loosely typed for byte vs default sources.
**/
typedef ReadableStreamUnderlyingSource = {
	@:optional var type:String;
	@:optional var autoAllocateChunkSize:Int;
	@:optional var start:Any->Any;
	@:optional var pull:Any->Any;
	@:optional var cancel:Any->Any;
}

/**
	A `{ readable, writable }` pair used by `pipeThrough`.
**/
typedef ReadableWritablePair = {
	var readable:ReadableStream;
	var writable:WritableStream;
}

/**
	Options for `pipeTo` / `pipeThrough`.
**/
typedef StreamPipeOptions = {
	@:optional var preventClose:Bool;
	@:optional var preventAbort:Bool;
	@:optional var preventCancel:Bool;
	@:optional var signal:AbortSignal;
}
