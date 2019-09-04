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

import js.node.Buffer;
import js.node.events.EventEmitter.Event;
import js.node.Stream;
import js.node.stream.Readable.IReadable;
#if haxe4
import js.lib.Error;
#else
import js.Error;
#end

/**
	Writable streams are an abstraction for a destination to which data is written.

	@see https://nodejs.org/api/stream.html#stream_writable_streams
**/
/**
	Enumeration for `Writable` class events.
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
		This method writes some data to the underlying system,
		and calls the supplied callback once the data has been fully handled.

		The return value indicates if you should continue writing right now. If the data had to be buffered internally,
		then it will return `false`. Otherwise, it will return `true`.

		This return value is strictly advisory. You MAY continue to write, even if it returns `false`.
		However, writes will be buffered in memory, so it is best not to do this excessively.
		Instead, wait for the `drain` event before writing more data.
	**/
	@:overload(function(chunk:Buffer, ?callback:Void->Void):Bool {})
	@:overload(function(chunk:String, ?callback:Void->Void):Bool {})
	function write(chunk:String, encoding:String, ?callback:Void->Void):Bool;

	/**
		Call this method when no more data will be written to the stream.
		If supplied, the callback is attached as a listener on the `finish` event.

		Calling `write()` after calling `end()` will raise an error.
	**/
	@:overload(function(?callback:Void->Void):Void {})
	@:overload(function(chunk:Buffer, ?callback:Void->Void):Void {})
	@:overload(function(chunk:String, ?callback:Void->Void):Void {})
	function end(chunk:String, encoding:String, ?callback:Void->Void):Void;

	/**
		Terminal write streams (i.e. process.stdout) have this property set to true.
		It is false for any other write streams.
	**/
	var isTTY(default, null):Bool;

	/**
		The writable.cork() method forces all written data to be buffered in memory.
		The buffered data will be flushed when either the stream.uncork() or stream.end() methods are called.
	**/
	function cork():Void;

	/**
		The writable.uncork() method flushes all data buffered since stream.cork() was called.
	**/
	function uncork():Void;

	/**
		The writable.setDefaultEncoding() method sets the default encoding for a Writable stream.
	**/
	function setDefaultEncoding(encoding:String):TSelf;

	// --------- API for stream implementors - see node.js API documentation ---------
	private function new(?options:WritableNewOptions);
	@:overload(function(chunk:String, encoding:String, callback:Error->Void):Void {})
	private function _write(chunk:Buffer, encoding:String, callback:Error->Void):Void;
}

/**
	Options for `Writable` private constructor.
	For stream implementors only, see node.js API documentation
**/
typedef WritableNewOptions = {
	@:optional var highWaterMark:Int;
	@:optional var decodeStrings:Bool;
	@:optional var defaultEncoding:String;
	@:optional var objectMode:Bool;
	@:optional var emitClose:Bool;
	@:optional var write:Dynamic->String->(Null<Error>->Void)->Void;
	@:optional var writev:Array<{chunk:Dynamic, encoding:String}>->(Null<Error>->Void)->Void;
	@:optional var destroy:Null<Error>->(Null<Error>->Void)->Void;
}

/**
	Writable interface used for type parameter constraints.
	See `Writable` for actual class documentation.
**/
@:remove
extern interface IWritable extends IStream {
	@:overload(function(chunk:Buffer, ?callback:Void->Void):Bool {})
	@:overload(function(chunk:String, ?callback:Void->Void):Bool {})
	function write(chunk:String, encoding:String, ?callback:Void->Void):Bool;

	@:overload(function(?callback:Void->Void):Void {})
	@:overload(function(chunk:Buffer, ?callback:Void->Void):Void {})
	@:overload(function(chunk:String, ?callback:Void->Void):Void {})
	function end(chunk:String, encoding:String, ?callback:Void->Void):Void;

	function cork():Void;
	function uncork():Void;
	function setDefaultEncoding(encoding:String):IWritable;

	var isTTY(default, null):Bool;
}
