package js.node.stream;

import js.node.Buffer;

/**
	Duplex streams are streams that implement both the `Readable` and `Writable` interfaces.

	Use relevant event enumeration types from `Readable` and `Writable` modules.

	Examples of `Duplex` streams include:
		- tcp sockets
		- zlib streams
		- crypto streams
**/
@:jsRequire("stream", "Duplex")
extern class Duplex<TSelf:Duplex<TSelf>> extends Readable<TSelf> implements Writable.IWritable {
	// --------- Writable interface implementation ---------

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

	/**
		Terminal write streams (i.e. process.stdout) have this property set to true.
		It is false for any other write streams.
	**/
	var isTTY(default,null):Bool;

	// --------- API for stream implementors - see node.js API documentation ---------
	private function new(?options:DuplexNewOptions);
	private function _write(chunk:Dynamic, encoding:String, callback:js.Error->Void):Void;
}

/**
	Options for `Duplex` private constructor.
	For stream implementors only, see node.js API documentation
**/
typedef DuplexNewOptions = {
	>Readable.ReadableNewOptions,
	>Writable.WritableNewOptions,
	@:optional var allowHalfOpen:Bool;
}
