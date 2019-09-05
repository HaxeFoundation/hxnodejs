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
import js.node.stream.Writable.IWritable;
#if haxe4
import js.lib.Error;
#else
import js.Error;
#end

/**
	Readable streams are an abstraction for a source from which data is consumed.

	@see https://nodejs.org/api/stream.html#stream_readable_streams
**/
/**
	Enumeration of events emitted by the `Readable` class.
**/
@:enum abstract ReadableEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	var Close:ReadableEvent<Void->Void> = "close";
	var Data:ReadableEvent<EitherType<Buffer, String>->Void> = "data";
	var End:ReadableEvent<Void->Void> = "end";
	var Error:ReadableEvent<Error->Void> = "error";
	var Pause:ReadableEvent<Error->Void> = "pause";
	var Readable:ReadableEvent<Void->Void> = "readable";
	var Resume:ReadableEvent<Void->Void> = "resume";
}

/**
	@see https://nodejs.org/api/stream.html#stream_class_stream_readable
**/
@:jsRequire("stream", "Readable")
extern class Readable<TSelf:Readable<TSelf>> extends Stream<TSelf> implements IReadable {
	/**
		The `read` method pulls some data out of the internal buffer and returns it.
		If there is no data available, then it will return null.

		If you pass in a `size` argument, then it will return that many bytes.
		If `size` bytes are not available, then it will return null.

		If you do not specify a `size` argument, then it will return all the data in the internal buffer.

		This method should only be called in non-flowing mode.
		In flowing-mode, this method is called automatically until the internal buffer is drained.
	**/
	function read(?size:Int):Null<EitherType<String, Buffer>>;

	/**
		Call this function to cause the stream to return strings of the specified encoding instead of `Buffer` objects.
		For example, if you do `setEncoding('utf8')`, then the output data will be interpreted as UTF-8 data,
		and returned as strings. If you do `setEncoding('hex')`, then the data will be encoded in hexadecimal string format.

		This properly handles multi-byte characters that would otherwise be potentially mangled if you simply pulled
		the `Buffer`s directly and called `buf.toString(encoding)` on them.

		If you want to read the data as strings, always use this method.
	**/
	function setEncoding(encoding:String):Void;

	/**
		This method will cause the readable stream to resume emitting 'data' events.

		This method will switch the stream into flowing-mode.
		If you do not want to consume the data from a stream, but you do want to get to its `end` event,
		you can call `resume` to open the flow of data.
	**/
	function resume():Void;

	/**
		This method will cause a stream in flowing-mode to stop emitting 'data' events.

		Any data that becomes available will remain in the internal buffer.

		This method is only relevant in flowing mode. When called on a non-flowing stream,
		it will switch into flowing mode, but remain paused.
	**/
	function pause():Void;

	/**
		This method pulls all the data out of a readable stream, and writes it to the supplied destination,
		automatically managing the flow so that the destination is not overwhelmed by a fast readable stream.

		Multiple destinations can be piped to safely.

		This function returns the destination stream, so you can set up pipe chains.

		By default `end` is called on the destination when the source stream emits 'end',
		so that destination is no longer writable. Pass `{end: false}` as `options`
		to keep the destination stream open.

		Note that `Process.stderr` and `Process.stdout` are never closed until the process exits,
		regardless of the specified options.
	**/
	function pipe<T:IWritable>(destination:T, ?options:{?end:Bool}):T;

	/**
		This method will remove the hooks set up for a previous `pipe` call.

		If the `destination` is not specified, then all pipes are removed.

		If the `destination` is specified, but no pipe is set up for it, then this is a no-op.
	**/
	@:overload(function():Void {})
	function unpipe(destination:IWritable):Void;

	/**
		This is useful in certain cases where a stream is being consumed by a parser,
		which needs to "un-consume" some data that it has optimistically pulled out of the source,
		so that the stream can be passed on to some other party.

		If you find that you must often call `unshift` in your programs,
		consider implementing a `Transform` stream instead.
	**/
	@:overload(function(chunk:Buffer):Void {})
	function unshift(chunk:String):Void;

	/**
		Versions of Node prior to v0.10 had streams that did not implement the entire Streams API as it is today.

		If you are using an older Node library that emits 'data' events and has a 'pause' method that is advisory only,
		then you can use the `wrap` method to create a `Readable` stream that uses the old stream as its data source.
	**/
	function wrap(stream:Dynamic):IReadable;

	// --------- API for stream implementors - see node.js API documentation ---------
	// TODO: add state objects here and in other streams
	private function new(?options:ReadableNewOptions);
	private function _read(size:Int):Void;
	@:overload(function(chunk:Buffer):Bool {})
	private function push(chunk:String, ?encoding:String):Bool;
}

/**
	Options for `Readable` private constructor.
	For stream implementors only, see node.js API documentation
**/
typedef ReadableNewOptions = {
	@:optional var highWaterMark:Int;
	@:optional var encoding:String;
	@:optional var objectMode:Bool;
	@:optional var read:Int->Void;
	@:optional var destroy:Null<Error>->(Null<Error>->Void)->Void;
}

/**
	`IReadable` interface is used as "any Readable".

	See `Readable` for actual class documentation.
**/
@:remove
extern interface IReadable extends IStream {
	function read(?size:Int):Null<EitherType<String, Buffer>>;

	function setEncoding(encoding:String):Void;

	function resume():Void;
	function pause():Void;

	function pipe<T:IWritable>(destination:T, ?options:{?end:Bool}):T;

	@:overload(function():Void {})
	function unpipe(destination:IWritable):Void;

	@:overload(function(chunk:Buffer):Void {})
	function unshift(chunk:String):Void;

	function wrap(stream:Dynamic):IReadable;
}
