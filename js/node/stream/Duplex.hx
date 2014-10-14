package js.node.stream;

import js.node.Buffer;
import js.node.events.EventEmitter;
import js.node.stream.Writable;
import js.node.stream.Readable;

/**
	Duplex streams are streams that implement both the `Readable` and `Writable` interfaces.

	Use relevant event enumeration types from `Readable` and `Writable` modules.

	Examples of `Duplex` streams include:
		- tcp sockets
		- zlib streams
		- crypto streams
**/
@:jsRequire("stream", "Duplex")
extern class Duplex extends EventEmitter implements IWritable implements IReadable
{
	// --------- Readable ---------

	/**
		The read() method pulls some data out of the internal buffer and returns it.
		If there is no data available, then it will return null.

		If you pass in a `size` argument, then it will return that many bytes.
		If `size` bytes are not available, then it will return null.

		If you do not specify a `size` argument, then it will return all the data in the internal buffer.

		This method should only be called in non-flowing mode.
		In flowing-mode, this method is called automatically until the internal buffer is drained.
	**/
	@:overload(function(?size:Int):Null<Buffer> {})
	function read(?size:Int):Null<String>;

	/**
		Call this function to cause the stream to return strings of the specified encoding instead of `Buffer` objects.
		For example, if you do readable.setEncoding('utf8'), then the output data will be interpreted as UTF-8 data,
		and returned as strings. If you do readable.setEncoding('hex'), then the data will be encoded in hexadecimal string format.

		This properly handles multi-byte characters that would otherwise be potentially mangled if you simply pulled
		the Buffers directly and called buf.toString(encoding) on them.

		If you want to read the data as strings, always use this method.
	**/
	function setEncoding(encoding:String):Void;

	/**
		This method will cause the readable stream to resume emitting `data` events.
		This method will switch the stream into flowing-mode.
		If you do not want to consume the data from a stream, but you do want to get to its `end` event,
		you can call readable.resume() to open the flow of data.
	**/
	function resume():Void;

	/**
		This method will cause a stream in flowing-mode to stop emitting `data` events.
		Any data that becomes available will remain in the internal buffer.
		This method is only relevant in flowing mode. When called on a non-flowing stream,
		it will switch into flowing mode, but remain paused.
	**/
	function pause():Void;

	/**
		This method pulls all the data out of a readable stream, and writes it to the supplied destination,
		automatically managing the flow so that the destination is not overwhelmed by a fast readable stream.

		This function returns the destination stream, so you can set up pipe chains.

		By default `end()` is called on the destination when the source stream emits `end`,
		so that destination is no longer writable. Pass `{ end: false }` as `options` to keep the destination stream open.
	**/
	function pipe<T:IWritable>(destination:T, ?options:{end:Bool}):T;

	/**
		This method will remove the hooks set up for a previous pipe() call.
		If the destination is not specified, then all pipes are removed.
		If the destination is specified, but no pipe is set up for it, then this is a no-op.
	**/
	@:overload(function():Void {})
	function unpipe(destination:IWritable):Void;

	/**
		This is useful in certain cases where a stream is being consumed by a parser,
		which needs to "un-consume" some data that it has optimistically pulled out of the source,
		so that the stream can be passed on to some other party.

		If you find that you must often call `stream.unshift(chunk)` in your programs,
		consider implementing a `Transform` stream instead.
	**/
	@:overload(function(chunk:Buffer):Void {})
	function unshift(chunk:String):Void;

	/**
		If you are using an older Node library that emits `data` events and has a `pause()` method that is advisory only,
		then you can use the `wrap()` method to create a `Readable` stream that uses the old stream as its data source.
	**/
	function wrap(stream:Dynamic):Readable;


	// --------- Writable ---------

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
	function end(chunk:String, encoding:String, ?callback:Void->Void):Void;
}
