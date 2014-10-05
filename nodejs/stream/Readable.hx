package nodejs.stream;
import nodejs.events.EventEmitter;

/**
 * Enumeration for Readable class events.
 */
class ReadableEventType
{
	/**
	 * When a chunk of data can be read from the stream, it will emit a 'readable' event.
	 * In some cases, listening for a 'readable' event will cause some data to be read into the internal buffer from the underlying system, if it hadn't already.
	 */
	static public var 	Readable : String = "readable";
	/**
	 * chunk Buffer | String The chunk of data.
	 * If you attach a data event listener, then it will switch the stream into flowing mode, and data will be passed to your handler as soon as it is available.
	 * If you just want to get all the data out of the stream as fast as possible, this is the best way to do so.
	 */
	static public var 	Data	 : String = "data";
	/**
	 * This event fires when no more data will be provided.
	 * Note that the end event will not fire unless the data is completely consumed.
	 * This can be done by switching into flowing mode, or by calling read() repeatedly until you get to the end.
	 */
	static public var	End	  	 : String = "end";
	/**
	 * Emitted when the underlying resource (for example, the backing file descriptor) has been closed. Not all streams will emit this.
	 */
	static public var 	Close	 : String = "close";
	/**
	 * Emitted if there was an error receiving data.
	 */
	static public var 	Error	 : String = "error";
}

/**
 * The Readable stream interface is the abstraction for a source of data that you are reading from. In other words, data comes out of a Readable stream.
 * A Readable stream will not start emitting data until you indicate that you are ready to receive it.
 * Readable streams have two "modes": a flowing mode and a non-flowing mode. When in flowing mode, data is read from the underlying system and provided to your program as fast as possible. In non-flowing mode, you must explicitly call stream.read() to get chunks of data out.
 * Examples of readable streams include:
 * 	- http responses, on the client
 *  - http requests, on the server
 *  - fs read streams
 *  - zlib streams
 *  - crypto streams
 *  - tcp sockets
 *  - child process stdout and stderr
 *  - process.stdin
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('stream').Readable)")
extern class Readable extends EventEmitter
{
	var read			: Dynamic;	//([size])
	var setEncoding		: Dynamic;	//(encoding)	
	var pipe			: Dynamic;	//(destination, [options])
	var unpipe			: Dynamic;	//([destination])
	var unshift			: Dynamic;	//(chunk)
	var wrap			: Dynamic;	//(stream)
	
	/**
	 * This method will cause the readable stream to resume emitting data events.
	 * This method will switch the stream into flowing-mode.
	 * If you do not want to consume the data from a stream, but you do want to get to its end event, 
	 * you can call readable.resume() to open the flow of data.
	 */
	function resume():Void;
	
	/**
	 * This method will cause a stream in flowing-mode to stop emitting data events. 
	 * Any data that becomes available will remain in the internal buffer.
	 * This method is only relevant in flowing mode. When called on a non-flowing stream, it will switch into flowing mode, but remain paused.
	 */
	function pause():Void;
	
	
}