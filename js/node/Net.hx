package js.node;

import js.node.net.Socket;
import js.node.net.Server;

private typedef CommonOptions = {
	/**
		If true, then the socket won't automatically send a FIN packet
		when the other end of the socket sends a FIN packet.

		The socket becomes non-readable, but still writable. You should call the `end` method explicitly.
		See `end` event for more information.

		Default: false
	**/
	@:optional var allowHalfOpen:Bool;
}

typedef SocketOptions = {
	>CommonOptions,
	/**
		If true, then the socket associated with each incoming connection will be paused,
		and no data will be read from its handle.

		This allows connections to be passed between processes without any data being read by the original process.
		To begin reading data from a paused socket, call `resume`.

		Default: false
	**/
	@:optional var pauseOnConnect:Bool;
}

typedef TCPConnectOptions = {
	>CommonOptions,

	/**
		Port the client should connect to
	**/
	var port:Int;

	/**
		Host the client should connect to.
		Defaults to 'localhost'.
	**/
	@:optional var host:String;

	/**
		Local interface to bind to for network connections.
	**/
	@:optional var localAddress:String;

	/**
		Local port to bind to for network connections.
	**/
	@:optional var localPort:Int;

	/**
		Version of IP stack. Defaults to 4.

		TODO: enum this?
	**/
	@:optional var family:Int;
}

typedef UnixConnectOptions = {
	>CommonOptions,

	/**
		Path the client should connect to
	**/
	var path:String;
}

/**
	Enumeration of possible values for `Net.isIP` return.
**/
@:enum abstract IsIPResult(Int) to Int {
	var Invalid = 0;
	var IPv4 = 4;
	var IPv6 = 6;
}

/**
	The net module provides you with an asynchronous network wrapper.
	It contains methods for creating both servers and clients (called streams).
**/
@:jsRequire("net")
extern class Net {
	/**
		Creates a new TCP server.

		The `connectionListener` argument is automatically set as a listener for the 'connection' event.
	**/
	@:overload(function(options:SocketOptions, ?connectionListener:Socket->Void):Server {})
	static function createServer(?connectionListener:Socket->Void):Server;

	/**
		A factory method, which returns a new `Socket` and connects to the supplied address and port.

		When the socket is established, the 'connect' event will be emitted.
		The `connectListener` parameter will be added as an listener for the 'connect' event.

		If `port` is provided, creates a TCP connection to `port` on `host`.
		If `host` is omitted, 'localhost' will be assumed.

		If `path` is provided, creates unix socket connection to `path`.

		Otherwise `options` argument should be provided.
	**/
	@:overload(function(path:String, ?connectListener:Void->Void):Socket {})
	@:overload(function(port:Int, ?connectListener :Void->Void):Socket {})
	@:overload(function(port:Int, host:String, ?connectListener:Void->Void):Socket {})
	static function connect(options:haxe.EitherType<TCPConnectOptions,UnixConnectOptions>, ?connectListener:Void->Void):Socket;

	/**
		Same as `connect`.
	**/
	@:overload(function(path:String, ?connectListener:Void->Void):Socket {})
	@:overload(function(port:Int, ?connectListener:Void->Void):Socket {})
	@:overload(function(port:Int, host:String, ?connectListener:Void->Void):Socket {})
	static function createConnection(options:haxe.EitherType<TCPConnectOptions,UnixConnectOptions>, ?connectListener:Void->Void):Socket;

	/**
		Tests if input is an IP address.
		Returns 0 for invalid strings, returns 4 for IP version 4 addresses, and returns 6 for IP version 6 addresses.
	**/
	static function isIP(input:String):IsIPResult;

	/**
		Returns true if input is a version 4 IP address, otherwise returns false.
	**/
	static function isIPv4(input:String):Bool;

	/**
		Returns true if input is a version 6 IP address, otherwise returns false.
	**/
	static function isIPv6(input:String):Bool;
}
