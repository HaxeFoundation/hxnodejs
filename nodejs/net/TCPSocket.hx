package nodejs.net;
import nodejs.events.EventEmitter;
import nodejs.stream.Duplex;


/**
 * Class that serves as an 'enum' for TCPSocketEvents.
 */
class TCPSocketEventType
{
	/**
	 * Emitted when a socket connection is successfully established. See connect().
	 */
	static public var Connect : String = "connect";
	
	/**
	 * Emitted when data is received. The argument data will be a Buffer or String. 
	 * Encoding of data is set by socket.setEncoding(). (See the Readable Stream section for more information.)
	 * Note that the data will be lost if there is no listener when a Socket emits a 'data' event.
	 */
	static public var Data : String = "data";
	
	/**
	 * Emitted when the other end of the socket sends a FIN packet.
	 * By default (allowHalfOpen == false) the socket will destroy its file descriptor once it has written out its pending write queue.
	 * However, by setting allowHalfOpen == true the socket will not automatically end() its side allowing the user to write arbitrary amounts of data,
	 * with the caveat that the user is required to end() their side now.
	 */
	static public var End : String = "end";
	
	/**
	 * Emitted if the socket times out from inactivity. This is only to notify that the socket has been idle. The user must manually close the connection.
	 * See also: socket.setTimeout()
	 */
	static public var TimeOut : String = "timeout";
	
	/**
	 * Emitted when the write buffer becomes empty. Can be used to throttle uploads.
	 * See also: the return values of socket.write()
	 */
	static public var Drain : String = "drain";
	
	/**
	 * Emitted when an error occurs. The 'close' event will be called directly following this event.
	 */
	static public var Error : String = "error";
	
	/**
	 * Emitted once the socket is fully closed. The argument had_error is a boolean which says if the socket was closed due to a transmission error.
	 */
	static public var Close : String = "close";
	
}

/**
 * Bound address, the address family name and port of the socket as reported by the operating system. 
 */
extern class NetworkAdress
{
	/**
	 * Connection port.
	 */
	var port : Int;
	
	/**
	 * IP Family.
	 */
	var family : String;
	
	/**
	 * IP Address.
	 */
	var address : String;
}


/**
 * Class that configures a new Socket being created.
 */
extern class TCPSocketOption
{
	/**
	 * Allows you to specify the existing file descriptor of socket
	 */
	var fd				: Int;
	
	/**
	 * Refer to createServer() and 'end' event.
	 */
	var allowHalfOpen	: Bool;
	
	/**
	 * Allow reads and/or writes on this socket (NOTE: Works only when fd is passed)
	 */
	var readable		: Bool;
	
	/**
	 * Allow reads and/or writes on this socket (NOTE: Works only when fd is passed)
	 */
	var writable		: Bool;
	
}

/**
 * This object is an abstraction of a TCP or UNIX socket. net.Socket instances implement a duplex Stream interface. 
 * They can be created by the user and used as a client (with connect()) or they can be created by Node and 
 * passed to the user through the 'connection' event of a server.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('net').Socket)")
extern class TCPSocket extends Duplex
{
	/**
	 * Construct a new socket object.
	 */
	@:overload(function():Void{})
	function new(p_options : TCPSocketOption):Void;
	
	/**
	 * The string representation of the local IP address the remote client is connecting on. 
	 * For example, if you are listening on '0.0.0.0' and the client connects on '192.168.1.1', the value would be '192.168.1.1'.
	 */
	var localAddress : String;
	
	/**
	 * The numeric representation of the local port. For example, 80 or 21.
	 */
	var localPort : Int;
	
	/**
	 * The amount of received bytes.
	 */
	var bytesRead : Int;
	
	/**
	 * The amount of bytes sent.
	 */
	var bytesWritten : Int;
	
	/**
	 * The string representation of the remote IP address. For example, '74.125.127.100' or '2001:4860:a005::68'.
	 */
	var remoteAddress : String;
	
	/**
	 * The numeric representation of the remote port. For example, 80 or 21.
	 */
	var remotePort : Int;
	
	/**
	 * Returns the bound address, the address family name and port of the socket as reported by the operating system.
	 * Returns an object with three properties, e.g. { port: 12346, family: 'IPv4', address: '127.0.0.1' }
	 * @return
	 */
	function address():NetworkAdress;
	
	/**
	 * net.Socket has the property that socket.write() always works. This is to help users get up and running quickly. 
	 * The computer cannot always keep up with the amount of data that is written to a socket - the network connection simply might be too slow. 
	 * Node will internally queue up the data written to a socket and send it out over the wire when it is possible. (Internally it is polling on the socket's file descriptor for being writable).
	 * The consequence of this internal buffering is that memory may grow. This property shows the number of characters currently buffered to be written.
	 * (Number of characters is approximately equal to the number of bytes to be written, but the buffer may contain strings, and the strings are lazily encoded,
	 * so the exact number of bytes is not known.)
	 * Users who experience large or growing bufferSize should attempt to "throttle" the data flows in their program with pause() and resume().
	 */
	var bufferSize : Int;
	
	/**
	 * Opens the connection for a given socket. If port and host are given, then the socket will be opened as a TCP socket, if host is omitted, localhost will be assumed. If a path is given, the socket will be opened as a unix socket to that path.
	 * Normally this method is not needed, as net.createConnection opens the socket. Use this only if you are implementing a custom Socket.
	 * This function is asynchronous. When the 'connect' event is emitted the socket is established. If there is a problem connecting, the 'connect' event will not be emitted, the 'error' event will be emitted with the exception.
	 * The connectListener parameter will be added as an listener for the 'connect' event.
	 * @param	p_port
	 * @param	p_host
	 * @param	p_connectListener
	 */	
	@:overload(function(p_path:String, p_connectListener:Dynamic):Void { } )
	@:overload(function(p_path:String):Void { } )
	@:overload(function(p_port : Int):Void { } )	
	@:overload(function(p_port : Int, p_host : String):Void { } )	
	function connect(p_port : Int, p_host : String, p_connectListener : Dynamic):Void;
	
	
	/**
	 * Ensures that no more I/O activity happens on this socket. Only necessary in case of errors (parse error or so).
	 */
	function destroy():Void;
	
	/**
	 * Pauses the reading of data. That is, 'data' events will not be emitted. Useful to throttle back an upload.
	 */
	override function pause():Void;
	
	/**
	 * Sets the socket to timeout after timeout milliseconds of inactivity on the socket. By default net.Socket do not have a timeout.
	 * When an idle timeout is triggered the socket will receive a 'timeout' event but the connection will not be severed. The user must manually end() or destroy() the socket.
	 * If timeout is 0, then the existing idle timeout is disabled.
	 * The optional callback parameter will be added as a one time listener for the 'timeout' event.
	 * @param	p_timeout
	 * @param	p_callback
	 */
	@:overload(function(p_timeout:Int):Void{})
	function setTimeout(p_timeout:Int, p_callback:Void->Void):Void;
		
	/**
	 * Disables the Nagle algorithm. By default TCP connections use the Nagle algorithm, they buffer data before sending it off. Setting true for noDelay will immediately fire off data each time socket.write() is called. noDelay defaults to true.
	 * @param	p_nodelay
	 */
	@:overload(function():Void { } )
	function setNoDelay(p_nodelay:Bool):Void;
	
	/**
	 * Enable/disable keep-alive functionality, and optionally set the initial delay before the first keepalive probe is sent on an idle socket. enable defaults to false.
	 * Set initialDelay (in milliseconds) to set the delay between the last data packet received and the first keepalive probe. 
	 * Setting 0 for initialDelay will leave the value unchanged from the default (or previous) setting. Defaults to 0.
	 * @param	p_enable
	 * @param	p_initialDelay
	 */
	@:overload(function():Void { } )
	@:overload(function(p_enable : Bool):Void { } )	
	function setKeepAlive(p_enable : Bool, p_initialDelay:Int):Void;
	
}