package nodejs.http;
import nodejs.net.TCPServer;
import nodejs.NodeJS;
import js.html.ArrayBufferView;
import nodejs.events.EventEmitter;

/**
 * Enum with the events supported by the Server class.
 */
class HTTPServerEventType
{
	/**
	 * Emitted when the server has been bound after calling server.listen.
	 */
	static public var Listening : String = "listening";
	
	/**
	 * Emitted when a new connection is made. socket is an instance of net.Socket.
	 */
	static public var Connection : String = "connection";
	
	/**
	 * Emitted when the server closes. Note that if connections exist, this event is not emitted until all connections are ended. 
	 */
	static public var Close : String = "close";
	
	/**
	 * Emitted when an error occurs. The 'close' event will be called directly following this event. See example in discussion of server.listen.
	 */
	static public var Error : String = "error";
	
	/**
	 * function (request, response) { }
	 * Emitted each time there is a request. Note that there may be multiple requests per connection (in the case of keep-alive connections). request is an instance of http.IncomingMessage and response is an instance of http.ServerResponse.
	 */
	static public var Request : String = "request";
	
	/**
	 * function (request, response) { }
	 * Emitted each time a request with an http Expect: 100-continue is received. If this event isn't listened for, the server will automatically respond with a 100 Continue as appropriate.
	 * Handling this event involves calling response.writeContinue() if the client should continue to send the request body, or generating an appropriate HTTP response (e.g., 400 Bad Request) if the client should not continue to send the request body.
	 * Note that when this event is emitted and handled, the request event will not be emitted.
	 */
	static public var CheckContinue : String = "checkContinue";
	
	/**
	 * function (request, socket, head) { }
	 * Emitted each time a client requests a http CONNECT method. If this event isn't listened for, then clients requesting a CONNECT method will have their connections closed.
	 * request is the arguments for the http request, as it is in the request event.
	 * socket is the network socket between the server and client.
	 * head is an instance of Buffer, the first packet of the tunneling stream, this may be empty.
	 * After this event is emitted, the request's socket will not have a data event listener, meaning you will need to bind to it in order to handle data sent to the server on that socket.
	 */
	static public var Connect : String = "connect";
	
	/**
	 * function (request, socket, head) { }
	 * Emitted each time a client requests a http upgrade. If this event isn't listened for, then clients requesting an upgrade will have their connections closed.
	 * request is the arguments for the http request, as it is in the request event.
	 * socket is the network socket between the server and client.
	 * head is an instance of Buffer, the first packet of the upgraded stream, this may be empty.
	 * After this event is emitted, the request's socket will not have a data event listener, meaning you will need to bind to it in order to handle data sent to the server on that socket.
	 */
	static public var Upgrade : String = "upgrade";
	
	/**
	 * function (exception, socket) { }
	 * If a client connection emits an 'error' event - it will forwarded here.
	 * socket is the net.Socket object that the error originated from.
	 */
	static public var ClientError : String = "clientError";
}

/**
 * HTTP Server EventEmitter. This class is used to create a TCP or UNIX server.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class HTTPServer extends TCPServer
{	
	
	/**
	 * Limits maximum incoming headers count, equal to 1000 by default. If set to 0 - no limit will be applied.
	 */
	var maxHeadersCount : Int;
	
	
	var setTimeout	 : Dynamic;// (msecs, callback)
	
	/**
	 * Number Default = 120000 (2 minutes)
	 * The number of milliseconds of inactivity before a socket is presumed to have timed out.
	 * Note that the socket timeout logic is set up on connection, so changing this value only affects new connections to the server, not any existing connections.
	 * Set to 0 to disable any kind of automatic timeout behavior on incoming connections.
	 */
	var timeout : Int;
	
}