package js.node.net;

import js.Error;
import js.node.events.EventEmitter;
import js.node.net.Socket.NetworkAdress;

/**
	Enumeration of events emitted by the `Server` objects
**/
@:enum abstract ServerEvent(String) to String {
	/**
		Emitted when the server has been bound after calling `Server.listen`.
	**/
	var Listening = "listening";

	/**
		Emitted when a new connection is made.
		Listener arguments:
			* socket:Socket - The connection object
	**/
	var Connection = "connection";

	/**
		Emitted when the server closes.
		Note that if connections exist, this event is not emitted until all connections are ended.
	**/
	var Close = "close";

	/**
		Emitted when an error occurs.
		The 'close' event will be called directly following this event. See example in discussion of server.listen.
		Listener arguments:
			* error - Error object
	**/
	var Error = "error";
}

/**
	This class is used to create a TCP or UNIX server.
**/
extern class Server extends EventEmitter<Server> {
	/**
		Begin accepting connections on the specified `port` and `host`.
		If the `host` is omitted, the server will accept connections directed to any IPv4 address (INADDR_ANY).
		A `port` value of zero will assign a random port.

		`backlog` is the maximum length of the queue of pending connections. The actual length will be determined
		by your OS through sysctl settings such as tcp_max_syn_backlog and somaxconn on linux.
		The default value of this parameter is 511 (not 512).

		This function is asynchronous. When the server has been bound, 'listening' event will be emitted.
		The last parameter `callback` will be added as an listener for the 'listening' event.
	**/
	@:overload(function(path:String, ?callback:Void->Void):Void {}) // TOOD: document that
	@:overload(function(handle:haxe.EitherType<Dynamic,{fd:Int}>, ?callback:Void->Void):Void {}) // TODO: according to docs, Dynamic should be either a server or socket, but i'm not sure if it's EitherType<Socket,Server>. Also, document that
	@:overload(function(port:Int, ?callback:Void->Void):Void {})
	@:overload(function(port:Int, backlog:Int, ?callback:Void->Void):Void {})
	@:overload(function(port:Int, host:String, ?callback:Void->Void):Void {})
	function listen(port:Int, host:String, backlog:Int, ?callback:Void->Void):Void;


	/**
		Stops the server from accepting new connections and keeps existing connections.
		This function is asynchronous, the server is finally closed when all connections are ended
		and the server emits a 'close' event.

		Optionally, you can pass a `callback` to listen for the 'close' event.
	**/
	function close(?callback:Void->Void):Void;

	/**
		Returns the bound address, the address family name and port of the server as reported by the operating system.
		Useful to find which port was assigned when giving getting an OS-assigned address.
	**/
	function address():NetworkAdress;

	/**
		Calling `unref` on a server will allow the program to exit if this is the only active server in the event system.
		If the server is already `unref`d calling `unref` again will have no effect.
	**/
	function unref():Void;

	/**
		Opposite of `unref`, calling `ref` on a previously `unref`d server
		will not let the program exit if it's the only server left (the default behavior).

		If the server is `ref`d calling `ref` again will have no effect.
	**/
	function ref():Void;

	/**
		Set this property to reject connections when the server's connection count gets high.
		It is not recommended to use this option once a socket has been sent to a child with child_process.fork().
	**/
	var maxConnections : Int;

	/**
		This function is deprecated; please use `getConnections` instead.

		The number of concurrent connections on the server.

		This becomes null when sending a socket to a child with child_process.fork().
		To poll forks and get current number of active connections use asynchronous `getConnections` instead.
	**/
	var connections(default,null):Null<Int>;

	/**
		Asynchronously get the number of concurrent connections on the server.
		Works when sockets were sent to forks.
	**/
	function getConnections(callback:Error->Int->Void):Void;
}