package nodejs.stream;
import js.html.ArrayBufferView;
import nodejs.events.EventEmitter;

/**
 * Enumeration for Writable class events.
 */
class WritableEventType
{
	/**
	 * If a writable.write(chunk) call returns false, then the drain event will indicate when it is appropriate to begin writing more data to the stream.
	 */
	static var  Drain	     : String = "drain"	;
	/**
	 * When the end() method has been called, and all data has been flushed to the underlying system, this event is emitted.
	 */
	static var  Finish	     : String = "finish";	
	/**
	 * src Readable Stream source stream that is piping to this writable
	 * This is emitted whenever the pipe() method is called on a readable stream, adding this writable to its set of destinations.
	 */
	static var  Pipe	     : String = "pipe";	
	/**
	 * src Readable Stream The source stream that unpiped this writable
	 * This is emitted whenever the unpipe() method is called on a readable stream, removing this writable from its set of destinations.
	 */
	static var  Unpipe 	     : String = "unpipe";	
	/**
	 * Emitted if there was an error when writing or piping data.
	 */
	static var  Error 	     : String = "error";
}

/**
 * The Writable stream interface is an abstraction for a destination that you are writing data to.
 * Examples of writable streams include:
 *   - http requests, on the client
 *   - http responses, on the server
 *   - fs write streams
 *   - zlib streams
 *   - crypto streams
 *   - tcp sockets
 *   - child process stdin
 *   - process.stdout, process.stderr
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('stream').Writable)")
extern class Writable extends EventEmitter
{
	/**
	 * If this method is called and response.writeHead() has not been called, it will switch to implicit header mode and flush the implicit headers.
	 * This sends a chunk of the response body. This method may be called multiple times to provide successive parts of the body.
	 * chunk can be a string or a buffer. If chunk is a string, the second parameter specifies how to encode it into a byte stream. By default the encoding is 'utf8'.
	 * Note: This is the raw HTTP body and has nothing to do with higher-level multi-part body encodings that may be used.
	 * The first time response.write() is called, it will send the buffered header information and the first body to the client. The second time response.write() is called, Node assumes you're going to be streaming data, and sends that separately. That is, the response is buffered up to the first chunk of body.
	 * Returns true if the entire data was flushed successfully to the kernel buffer. Returns false if all or part of the data was queued in user memory. 'drain' will be emitted when the buffer is again free.
	 */
	@:overload( function( chunk : ArrayBufferView) :Void { } )	
	@:overload( function( chunk : String) :Void { } )	
	function write(chunk : String, encoding : String) : Void;
	
	/**
	 * This method signals to the server that all of the response headers and body have been sent; that server should consider this message complete.
	 * The method, response.end(), MUST be called on each response.
	 * If data is specified, it is equivalent to calling response.write(data, encoding) followed by response.end().
	 */
	 @:overload( function() :Void { } )	
	 @:overload( function(chunk : String) :Void { } )	
	 function end(chunk : String, encoding : String) : Void;
	
}