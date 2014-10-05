package nodejs.http;
import nodejs.events.EventEmitter;
import nodejs.fs.ReadStream;
import nodejs.net.TCPSocket;
import nodejs.stream.Readable.ReadableEventType;

/**
 * 
 */
class IncomingMessageEventType extends ReadableEventType
{
	
	/**
	 * chunk Buffer | String The chunk of data.
	 * If you attach a data event listener, then it will switch the stream into flowing mode, and data will be passed to your handler as soon as it is available.
	 * If you just want to get all the data out of the stream as fast as possible, this is the best way to do so.
	 */
	static public var 	Data	 : String = "data";
	
	/**
	 * Emitted when the underlying resource (for example, the backing file descriptor) has been closed. Not all streams will emit this.
	 */
	static public var 	Close	 : String = "close";
	
	
	/**
	 * This event fires when no more data will be provided.
	 * Note that the end event will not fire unless the data is completely consumed.
	 * This can be done by switching into flowing mode, or by calling read() repeatedly until you get to the end.
	 */
	static public var	End	  	 : String = "end";
	
	
}

/**
 * Wrapper class for the 'request' data that came from the 'http' createServer listener.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class IncomingMessage extends ReadStream
{	
	
	/**
	 * Request URL string. This contains only the URL that is present in the actual HTTP request. If the request is:
	 */
	var url : String;	
	
	/**
	 * The 3-digit HTTP response status code. E.G. 404.
	 */
	var statusCode:Int;
	
	/**
	 * The net.Socket object associated with the connection.
	 */
	var socket:TCPSocket;
	
	/**
	 * The request method as a string. Read only. Example: 'GET', 'DELETE'.
	 */
	var method : String;
	
	/**
	 * Calls message.connection.setTimeout(msecs, callback).
	 */
	function setTimeout(msecs : Int, p_callback : Dynamic):Void;
	
	/**
	 * The request/response headers object.
	 * Read only map of header names and values. Header names are lower-cased
	 */
	var headers: Dynamic;
	
	/**
	 * The request/response trailers object. Only populated after the 'end' event.
	 */
	var trailers:Dynamic;
	
	
	/**
	 * In case of server request, the HTTP version sent by the client. In the case of client response, the HTTP version of the connected-to server. Probably either '1.1' or '1.0'.
	 */
	var httpVersion:String;
	
	/**
	 * HTTP Version first integer
	 */
	var httpVersionMajor :Int;
	
	/**
	 * HTTP Version second integer
	 */
	var httpVersionMinor :Int;
	
	
}