package nodejs.net;
import js.Error;
import nodejs.events.EventEmitter;
import nodejs.net.TCPSocket.NetworkAdress;

/**
 * 
 */
class TCPServerEventType
{
	/**
	 * Emitted when the server has been bound after calling server.listen.
	 */
	static var Listening 	: String = "listening";
	
	/**
	 * Emitted when a new connection is made. socket is an instance of net.Socket.
	 */
	static var Connection 	: String = "connection";
	
	/**
	 * Emitted when the server closes. Note that if connections exist, this event is not emitted until all connections are ended.
	 */
	static var Close 		: String = "close";
	
	/**
	 * Error Object
	 * Emitted when an error occurs. The 'close' event will be called directly following this event. See example in discussion of server.listen.
	 */
	static var Error 		: String = "error";
}

/**
 * This class is used to create a TCP or UNIX server.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class TCPServer extends EventEmitter
{
	/**
	 * Set this property to reject connections when the server's connection count gets high.
	 * It is not recommended to use this option once a socket has been sent to a child with child_process.fork().
	 */
	var maxConnections : Int;
	
	/**
	 * This function is deprecated; please use server.getConnections() instead. The number of concurrent connections on the server.
	 * This becomes null when sending a socket to a child with child_process.fork(). To poll forks and get current number of active connections use asynchronous server.getConnections instead.
	 */
	var connections : Array<TCPSocket>;
	
	/**
	 * Begin accepting connections on the specified port and hostname. If the hostname is omitted, the server will accept connections directed to any IPv4 address (INADDR_ANY).
	 * To listen to a unix socket, supply a filename instead of port and hostname.
	 * Backlog is the maximum length of the queue of pending connections. The actual length will be determined by your OS through sysctl settings such as tcp_max_syn_backlog and somaxconn on linux.
	 * The default value of this parameter is 511 (not 512).
	 * This function is asynchronous. The last parameter callback will be added as a listener for the 'listening' event. See also net.Server.listen(port).
	 */
	@:overload( function (handle : Dynamic):Void { })
	@:overload( function (handle : Dynamic, on_listening_callback : Dynamic):Void { })
	@:overload( function (path : String):Void { })
	@:overload( function (path : String, on_listening_callback : Dynamic):Void { })
	@:overload( function (port : Int):Void { })
	@:overload( function (port : Int, hostname:String):Void { })
	@:overload( function (port : Int, hostname:String, backlog:Int):Void { })
	function listen(port : Int, hostname : String, backlog : Int, on_listening_callback : Dynamic) : Void;
	
	
	/**
	 * Stops the server from accepting new connections and keeps existing connections. 
	 * This function is asynchronous, the server is finally closed when all connections are ended and the server emits a 'close' event.
	 * Optionally, you can pass a callback to listen for the 'close' event.
	 * @param	p_callback
	 */
	@:overload(function():Void { })
	function close(p_callback:Void->Void):Void;
	
	/**
	 * Returns the bound address, the address family name and port of the server as reported by the operating system.
	 * Useful to find which port was assigned when giving getting an OS-assigned address. Returns an object with three properties,
	 * e.g. { port: 12346, family: 'IPv4', address: '127.0.0.1' }
	 * @return
	 */
	function address():NetworkAdress;
	
	/**
	 * Calling unref on a server will allow the program to exit if this is the only active server in the event system. 
	 * If the server is already unrefd calling unref again will have no effect.
	 */
	function unref():Void;
	
	/**
	 * Opposite of unref, calling ref on a previously unrefd server will not let the program exit if it's the only server left (the default behavior). 
	 * If the server is refd calling ref again will have no effect.
	 */
	function ref():Void;
	
	/**
	 * Asynchronously get the number of concurrent connections on the server. Works when sockets were sent to forks.
	 * Callback should take two arguments err and count.
	 * net.Server is an EventEmitter with the following events:
	 * @param	p_callback
	 */
	@:overload(function():Int{})
	function getConnections(p_callback : Error -> Int):Void;
	
}