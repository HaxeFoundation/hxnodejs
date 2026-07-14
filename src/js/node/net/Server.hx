/*
 * Copyright (C)2014-2026 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package js.node.net;

import haxe.extern.EitherType;
import js.lib.Error;
import js.node.events.EventEmitter;
import js.node.net.BlockList;
import js.node.net.Socket.SocketAdress;
import js.node.net.Socket.SocketOptionsBase;
import js.node.web.AbortSignal;

/**
	Options for `new Server()` / `Net.createServer`.
**/
typedef ServerOptions = {
	> SocketOptionsBase,

	/**
		If true, then the socket associated with each incoming connection will be paused,
		and no data will be read from its handle.

		This allows connections to be passed between processes without any data being read by the original process.
		To begin reading data from a paused socket, call `resume`.

		Default: false
	**/
	@:optional var pauseOnConnect:Bool;

	/**
		If set to `true`, it enables keep-alive functionality on the socket immediately after the connection is established.
	**/
	@:optional var keepAlive:Bool;

	/**
		If set to a positive number, it sets the initial delay before the first keepalive probe is sent on an idle socket.
	**/
	@:optional var keepAliveInitialDelay:Int;

	/**
		If set to `true`, it disables the use of Nagle's algorithm immediately after a connection is established.
	**/
	@:optional var noDelay:Bool;

	/**
		Optionally overrides all `net.Socket`s' `readableHighWaterMark` and `writableHighWaterMark`.
	**/
	@:optional var highWaterMark:Int;

	/**
		`net.BlockList` used as an IP allow/deny list for incoming connections.
	**/
	@:optional var blockList:BlockList;
}

/**
	Argument passed to the `'drop'` event for TCP servers when `maxConnections` is reached.
	For IPC servers the argument is `undefined`.

	@see https://nodejs.org/api/net.html#event-drop
**/
typedef ServerDropArgument = {
	@:optional var localAddress:String;
	@:optional var localPort:Int;
	@:optional var localFamily:String;
	@:optional var remoteAddress:String;
	@:optional var remotePort:Int;
	@:optional var remoteFamily:String;
}

/**
	Enumeration of events emitted by the `Server` objects
**/
enum abstract ServerEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when the server has been bound after calling `Server.listen`.
	**/
	var Listening:ServerEvent<Void->Void> = "listening";

	/**
		Emitted when a new connection is made.
	**/
	var Connection:ServerEvent<Socket->Void> = "connection";

	/**
		Emitted when the server closes.
		Note that if connections exist, this event is not emitted until all connections are ended.
	**/
	var Close:ServerEvent<Void->Void> = "close";

	/**
		Emitted when an error occurs.
		The 'close' event will be called directly following this event. See example in discussion of server.listen.
	**/
	var Error:ServerEvent<Error->Void> = "error";

	/**
		Emitted when a connection is dropped because of `maxConnections` being reached.
		For TCP servers, the listener receives connection metadata; for IPC servers it is `undefined`.

		@see https://nodejs.org/api/net.html#event-drop
	**/
	var Drop:ServerEvent<Null<ServerDropArgument>->Void> = "drop";
}

private typedef ServerListenOptionsBase = {
	/**
		Common parameter of `server.listen()` functions.
	**/
	@:optional var backlog:Int;

	/**
		When `false` (default), cluster workers share the same underlying handle.
		When `true`, the handle is not shared.
	**/
	@:optional var exclusive:Bool;

	/**
		An `AbortSignal` that may be used to close a listening server.
	**/
	@:optional var signal:AbortSignal;
}

/**
	Options for the `Server.listen` method (TCP version).
**/
typedef ServerListenOptionsTcp = {
	> ServerListenOptionsBase,
	@:optional var port:Int;
	@:optional var host:String;

	/**
		For TCP servers, setting `ipv6Only` to `true` disables dual-stack support
		(binding to `::` will not also bind `0.0.0.0`). Default: `false`.
	**/
	@:optional var ipv6Only:Bool;

	/**
		For TCP servers, setting `reusePort` to `true` allows multiple sockets on the same host
		to bind to the same port (platform-dependent). Default: `false`.

		@see https://nodejs.org/api/net.html#serverlistenoptions-callback
	**/
	@:optional var reusePort:Bool;
}

/**
	Options for the `Server.listen` method (UNIX / IPC version).
**/
typedef ServerListenOptionsUnix = {
	> ServerListenOptionsBase,
	@:optional var path:String;

	/**
		For IPC servers, makes the pipe readable for all users. Default: `false`.
	**/
	@:optional var readableAll:Bool;

	/**
		For IPC servers, makes the pipe writable for all users. Default: `false`.
	**/
	@:optional var writableAll:Bool;
}

/**
	This class is used to create a TCP or local server.
**/
@:jsRequire("net", "Server")
extern class Server extends EventEmitter<Server> {
	/**
		Creates a new TCP or IPC server.

		The `connectionListener` argument is automatically set as a listener for the `'connection'` event.

		@see https://nodejs.org/api/net.html#new-netserveroptions-connectionlistener
	**/
	@:overload(function(?connectionListener:Socket->Void):Void {})
	function new(?options:ServerOptions, ?connectionListener:Socket->Void):Void;

	/**
		Begin accepting connections on the specified `port` and `hostname`.

		If the `hostname` is omitted, the server will accept connections on any IPv6 address (::) when IPv6 is available,
		or any IPv4 address (0.0.0.0) otherwise.
		A `port` value of zero will assign a random port.

		`backlog` is the maximum length of the queue of pending connections. The actual length will be determined
		by your OS through sysctl settings such as tcp_max_syn_backlog and somaxconn on linux.
		The default value of this parameter is 511 (not 512).

		When `path` is provided, start a local socket server listening for connections on the given path.

		When `handle` is provided, it should be either a server or socket (anything with an underlying `_handle` member),
		or a {fd: <n>} object. This will cause the server to accept connections on the specified handle,
		but it is presumed that the file descriptor or handle has already been bound to a port or domain socket.
		Listening on a file descriptor is not supported on Windows.

		This function is asynchronous. When the server has been bound, 'listening' event will be emitted.
		The last parameter `callback` will be added as an listener for the 'listening' event.

		Returns `this` for chaining.
	**/
	@:overload(function(path:String, ?callback:Void->Void):Server {})
	@:overload(function(handle:EitherType<Server, EitherType<Socket, {fd:Int}>>, ?callback:Void->Void):Server {})
	@:overload(function(port:Int, ?callback:Void->Void):Server {})
	@:overload(function(port:Int, backlog:Int, ?callback:Void->Void):Server {})
	@:overload(function(port:Int, hostname:String, ?callback:Void->Void):Server {})
	@:overload(function(port:Int, hostname:String, backlog:Int, ?callback:Void->Void):Server {})
	function listen(options:EitherType<ServerListenOptionsTcp, ServerListenOptionsUnix>, ?callback:Void->Void):Server;

	/**
		Stops the server from accepting new connections and keeps existing connections.
		This function is asynchronous, the server is finally closed when all connections are ended
		and the server emits a 'close' event.

		The optional callback will be called once the 'close' event occurs. Unlike that event,
		it will be called with an Error as its only argument if the server was not open when it was closed.

		Returns `this` for chaining.
	**/
	@:overload(function(callback:Error->Void):Server {})
	function close(?callback:Void->Void):Server;

	/**
		Returns the bound address, the address family name and port of the server as reported by the operating system.
		Useful to find which port was assigned when giving getting an OS-assigned address.

		Returns `null` before the `'listening'` event has been emitted or after calling `close`.

		For a server listening on a pipe or Unix domain socket, Node returns the path as a `String` at runtime;
		that case is omitted here so TCP callers can access `.port` / `.address` / `.family` without casting.
	**/
	function address():Null<SocketAdress>;

	/**
		Calling `unref` on a server will allow the program to exit if this is the only active server in the event system.
		If the server is already `unref`d calling `unref` again will have no effect.
	**/
	function unref():Server;

	/**
		Opposite of `unref`, calling `ref` on a previously `unref`d server
		will not let the program exit if it's the only server left (the default behavior).

		If the server is `ref`d calling `ref` again will have no effect.
	**/
	function ref():Server;

	/**
		A boolean indicating whether or not the server is listening for connections.
	**/
	var listening(default, null):Bool;

	/**
		Set this property to reject connections when the server's connection count gets high.
		It is not recommended to use this option once a socket has been sent to a child with child_process.fork().
	**/
	var maxConnections:Int;

	/**
		If `true`, when the connection count reaches `maxConnections`, Node.js drops the connection
		instead of handing it to another cluster worker.

		@see https://nodejs.org/api/net.html#serverdropmaxconnection
	**/
	var dropMaxConnection:Bool;

	/**
		The number of concurrent connections on the server.

		This becomes null when sending a socket to a child with child_process.fork().
		To poll forks and get current number of active connections use asynchronous `getConnections` instead.
	**/
	@:deprecated("please use `getConnections` instead")
	var connections(default, null):Null<Int>;

	/**
		Asynchronously get the number of concurrent connections on the server.
		Works when sockets were sent to forks.
	**/
	function getConnections(callback:Error->Int->Void):Server;
}
