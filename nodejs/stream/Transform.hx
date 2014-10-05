package nodejs.stream;
import nodejs.events.EventEmitter;

/**
* Transform streams are Duplex streams where the output is in some way computed from the input. 
* They implement both the Readable and Writable interfaces. See above for usage.
* Examples of Transform streams include:
*  - zlib streams
*  - crypto streams
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('stream').Transform)")
extern class Transform extends EventEmitter
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
	
	var write	: Dynamic;		//(chunk, [encoding], [callback])	
	var end		: Dynamic;		//([chunk], [encoding], [callback])	
}