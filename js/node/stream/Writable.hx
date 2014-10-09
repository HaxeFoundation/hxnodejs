package js.node.stream;

import js.node.Buffer;
import js.node.events.EventEmitter;

/**
	Enumeration for `Writable` class events.
**/
@:enum abstract WritableEvent(String) to String {

	/**
		If a `writable.write(chunk)` call returns `false`, then the `drain` event will indicate
		when it is appropriate to begin writing more data to the stream.
	**/
	var Drain = "drain";

	/**
		When the `end()` method has been called, and all data has been flushed to the underlying system, this event is emitted.
	**/
	var Finish = "finish";

	/**
		Lister arguments:
			- src (Readable Stream) - source stream that is piping to `this` writable

		This is emitted whenever the `pipe()` method is called on a readable stream, adding `this` writable to its set of destinations.
	**/
	var Pipe = "pipe";

	/**
		Listener arguments:
			- src (Readable Stream) - source stream that unpiped `this` writable

		This is emitted whenever the `unpipe()` method is called on a readable stream, removing `this` writable from its set of destinations.
	**/
	var Unpipe = "unpipe";

	/**
		Listener arguments:
			- error (Error) - error object

		Emitted if there was an error when writing or piping data.
	**/
	var Error = "error";
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
extern class Writable extends EventEmitter {
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
