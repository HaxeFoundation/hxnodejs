package nodejs.http;
import js.html.ArrayBufferView;
import nodejs.fs.WriteStream;

/**
 * 
 */
class ServerResponseEventType
{
	/**
	 * function () { }
	 * Indicates that the underlying connection was terminated before response.end() was called or able to flush.
	 */
	static public var Close : String = "close";
	
	
	
	/**
	 * function () { }
	 * Emitted when the response has been sent. More specifically, this event is emitted when the last segment of the response headers and body have been handed off to the operating system for transmission over the network. It does not imply that the client has received anything yet.
	 * After this event, no more events will be emitted on the response object.
	 */
	static public var Finish : String = "finish";
}

/**
 * This object is created internally by a HTTP server--not by the user. It is passed as the second parameter to the 'request' event.
 * The response implements the Writable Stream interface. This is an EventEmitter with the following events:
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class ServerResponse extends WriteStream
{	
	
	/**
	 * Sends a HTTP/1.1 100 Continue message to the client, indicating that the request body should be sent. See the 'checkContinue' event on Server.
	 */
	function writeContinue():Void;
	
	/**
	 * Sends a response header to the request. The status code is a 3-digit HTTP status code, like 404.
	 * The last argument, headers, are the response headers. Optionally one can give a human-readable reasonPhrase as the second argument.
	 * This method must only be called once on a message and it must be called before response.end() is called.
	 * If you call response.write() or response.end() before calling this, the implicit/mutable headers will be calculated and call this function for you.
	 * Note: that Content-Length is given in bytes not characters. 
	 */
	@:overload( function( statusCode : Int, headers : Dynamic ) :Void { } )
	@:overload( function( statusCode : Int) :Void { } )	
	function writeHead(statusCode : Int, reasonPhrase : String, headers : Dynamic) : Void;
	
	/**
	 * When using implicit headers (not calling response.writeHead() explicitly), this property controls the status code that will be sent to the client when the headers get flushed.
	 */
	var statusCode : Int;
	
	/**
	 * Boolean (read-only). True if headers were sent, false otherwise.
	 */
	var headersSent : Bool;
	 
	 /**
	  * Reads out a header that's already been queued but not sent to the client. Note that the name is case insensitive. This can only be called before headers get implicitly flushed.
	  * @param	name
	  * @return
	  */
	 function getHeader(name : String):String;
	 
	  /**
	   * Sets a single header value for implicit headers. If this header already exists in the to-be-sent headers, its value will be replaced. Use an array of strings here if you need to send multiple headers with the same name.
	   * @param	name
	   * @param	value
	   */
	 function setHeader(name : String, value : String) : Void;
	 
	/*	 
    setTimeout(msecs, callback)            
    sendDate    
    removeHeader(name)    
    addTrailers(headers)    
	//*/
	 
}