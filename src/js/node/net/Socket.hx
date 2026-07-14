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
import js.node.Dns;
import js.node.events.EventEmitter.Event;
import js.node.web.AbortSignal;

/**
	Enumeration of events for `Socket` objects.
**/
enum abstract SocketEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted after resolving the hostname but before connecting.
		Not applicable to UNIX sockets.

		Listener arguments: `err`, `address`, `family`, `host`.
	**/
	var Lookup:SocketEvent<(err:Null<Error>, address:String, family:Null<DnsAddressFamily>, host:String) -> Void> = "lookup";

	/**
		Emitted when a socket connection is successfully established. See `Socket.connect`.
	**/
	var Connect:SocketEvent<Void->Void> = "connect";

	/**
		Emitted when data is received.
		The argument data will be a `Buffer` or `String`.
		Encoding of data is set by `Socket.setEncoding`.

		Note that the data will be lost if there is no listener when a Socket emits a 'data' event.
	**/
	var Data:SocketEvent<EitherType<Buffer, String>->Void> = "data";

	/**
		Emitted when the other end of the socket sends a FIN packet.

		By default (allowHalfOpen == false) the socket will destroy its file descriptor once
		it has written out its pending write queue. However, by setting allowHalfOpen == true
		the socket will not automatically `end` its side allowing the user to write arbitrary amounts of data,
		with the caveat that the user is required to `end` their side now.
	**/
	var End:SocketEvent<Void->Void> = "end";

	/**
		Emitted if the socket times out from inactivity.
		This is only to notify that the socket has been idle
		The user must manually close the connection.
		See also: `Socket.setTimeout`
	**/
	var Timeout:SocketEvent<Void->Void> = "timeout";

	/**
		Emitted when the write buffer becomes empty. Can be used to throttle uploads.
		See also: the return values of `Socket.write`
	**/
	var Drain:SocketEvent<Void->Void> = "drain";

	/**
		Emitted when an error occurs. The 'close' event will be called directly following this event.
	**/
	var Error:SocketEvent<Error->Void> = "error";

	/**
		Emitted once the socket is fully closed.
		The argument `had_error` is a boolean which says if the socket was closed due to a transmission error.

		Listener arguments:
			had_error - true if the socket had a transmission error
	**/
	var Close:SocketEvent<Bool->Void> = "close";

	/**
		Emitted when a socket is ready to be used.

		Triggered immediately after `'connect'`.
	**/
	var Ready:SocketEvent<Void->Void> = "ready";

	/**
		Emitted when a new connection attempt is started.
		Only emitted for family-agnostic (`family: 0` / autoSelectFamily) connects.

		@see https://nodejs.org/api/net.html#event-connectionattempt
	**/
	var ConnectionAttempt:SocketEvent<(ip:String, port:Int, family:Int) -> Void> = "connectionAttempt";

	/**
		Emitted when a connection attempt fails.
		Only emitted for family-agnostic connects.

		@see https://nodejs.org/api/net.html#event-connectionattemptfailed
	**/
	var ConnectionAttemptFailed:SocketEvent<(ip:String, port:Int, family:Int, error:Error) -> Void> = "connectionAttemptFailed";

	/**
		Emitted when a connection attempt times out.
		Only emitted for family-agnostic connects.

		@see https://nodejs.org/api/net.html#event-connectionattempttimeout
	**/
	var ConnectionAttemptTimeout:SocketEvent<(ip:String, port:Int, family:Int) -> Void> = "connectionAttemptTimeout";
}

typedef SocketOptionsBase = {
	/**
		If true, then the socket won't automatically send a FIN packet
		when the other end of the socket sends a FIN packet.

		The socket becomes non-readable, but still writable. You should call the `end` method explicitly.
		See `end` event for more information.

		Default: false
	**/
	@:optional var allowHalfOpen:Bool;
}

/**
	Options for creating new `Socket` object.
**/
typedef SocketOptions = {
	> SocketOptionsBase,

	/**
		If specified, wrap around an existing socket with the given file descriptor,
		otherwise a new socket will be created.
	**/
	@:optional var fd:Null<Int>;

	/**
		Allow reads on this socket (NOTE: Works only when `fd` is passed). Default: `false`.
	**/
	@:optional var readable:Bool;

	/**
		Allow writes on this socket (NOTE: Works only when `fd` is passed). Default: `false`.
	**/
	@:optional var writable:Bool;

	/**
		If specified, incoming data is stored in a single `buffer` and passed to the supplied `callback`
		when data arrives on the socket. This disables normal streaming `data` events.

		@see https://nodejs.org/api/net.html#new-netsocketoptions
	**/
	@:optional var onread:SocketOnReadOptions;

	/**
		AbortSignal that may be used to destroy the socket.
	**/
	@:optional var signal:AbortSignal;

	/**
		If set to `true`, enables keep-alive functionality on the socket immediately after the connection is established.
		Default: `false`.
	**/
	@:optional var keepAlive:Bool;

	/**
		If set to a positive number, sets the initial delay before the first keepalive probe is sent on an idle socket.
		Default: `0`.
	**/
	@:optional var keepAliveInitialDelay:Int;

	/**
		If set to `true`, disables the use of Nagle's algorithm immediately after the socket is established.
		Default: `false`.
	**/
	@:optional var noDelay:Bool;

	/**
		`net.BlockList` for disabling outbound access to specific IP addresses, ranges, or subnets.
	**/
	@:optional var blockList:BlockList;

	/**
		The initial Type of Service (TOS) value (0-255).

		@see https://nodejs.org/api/net.html#new-netsocketoptions
	**/
	@:optional var typeOfService:Int;
}

/**
	Optional `onread` callback options for `Socket`.
**/
typedef SocketOnReadOptions = {
	/**
		Either a reusable chunk of memory to use for storing incoming data, or a function that returns such.
	**/
	var buffer:EitherType<js.node.Buffer, () -> js.node.Buffer>;

	/**
		Called for every chunk of incoming data with the number of bytes written and a reference to `buffer`.
		Return `false` to implicitly `pause()` the socket.
	**/
	var callback:(bytesWritten:Int, buffer:js.node.Buffer) -> Bool;
}

/**
	Options for the `Socket.connect` method (TCP version).
**/
typedef SocketConnectOptionsTcp = {
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
		Version of IP stack. Must be `4`, `6`, or `0`.
		The value `0` indicates that both IPv4 and IPv6 addresses are allowed.
		Default: `0`.
	**/
	@:optional var family:DnsAddressFamily;

	/**
		Custom lookup function. Defaults to `Dns.lookup`.
	**/
	@:optional var lookup:String->DnsLookupOptions->DnsLookupCallbackSingle->Void;

	/**
		Optional dns.lookup() hints.
	**/
	@:optional var hints:Int;

	/**
		If true, connecting sockets enable TCP keep-alive (SO_KEEPALIVE).
	**/
	@:optional var keepAlive:Bool;

	/**
		Initial TCP keep-alive delay in milliseconds, when `keepAlive` is enabled.
	**/
	@:optional var keepAliveInitialDelay:Int;

	/**
		If set to `true`, disables the Nagle algorithm.
	**/
	@:optional var noDelay:Bool;

	/**
		If set to `true`, enables a family autodetection algorithm (RFC 8305 §5).
		Ignored if `family` is not `0` or if `localAddress` is set.
		Default: `Net.getDefaultAutoSelectFamily()`.
	**/
	@:optional var autoSelectFamily:Bool;

	/**
		Timeout in milliseconds for autoSelectFamily connection attempts.
		Default: `Net.getDefaultAutoSelectFamilyAttemptTimeout()`.
	**/
	@:optional var autoSelectFamilyAttemptTimeout:Int;

	/**
		Connection timeout in milliseconds. Defaults to no timeout.
	**/
	@:optional var timeout:Int;

	/**
		AbortSignal used to abort an ongoing connect.
	**/
	@:optional var signal:AbortSignal;
}

/**
	Options for the `Socket.connect` method (Local domain socket version).
**/
typedef SocketConnectOptionsUnix = {
	/**
		Path the client should connect to
	**/
	var path:String;

	/**
		AbortSignal used to abort an ongoing connect.
	**/
	@:optional var signal:AbortSignal;
}

/**
	Possible values of `socket.readyState`.
**/
enum abstract SocketReadyState(String) from String to String {
	var Opening = "opening";
	var Open = "open";
	var ReadOnly = "readOnly";
	var WriteOnly = "writeOnly";
}

/**
	Bound address, the address family name and port of the socket as reported by the operating system.
**/
typedef SocketAdress = {
	/**
		Connection port.
	**/
	var port:Int;

	/**
		IP Family.
	**/
	var family:SocketAdressFamily;

	/**
		IP Address.
	**/
	var address:String;
}

/**
	Enumeration of possible socket family values.
**/
enum abstract SocketAdressFamily(String) to String {
	var IPv4 = "IPv4";
	var IPv6 = "IPv6";
}

@:jsRequire("net", "Socket")
extern class Socket extends js.node.stream.Duplex<Socket> {
	/**
		Construct a new socket object.
	**/
	function new(?options:SocketOptions);

	/**
		Opens the connection for a given socket.

		If `port` and `host` are given, then the socket will be opened as a TCP socket,
		if `host` is omitted, localhost will be assumed.
		If a `path` is given, the socket will be opened as a unix socket to that path.

		Normally this method is not needed, as `Net.createConnection` opens the socket.
		Use this only if you are implementing a custom `Socket`.

		This function is asynchronous. When the 'connect' event is emitted the socket is established.
		If there is a problem connecting, the 'connect' event will not be emitted,
		the 'error' event will be emitted with the exception

		The `connectListener` parameter will be added as an listener for the 'connect' event.
	**/
	@:overload(function(path:String, ?connectListener:Void->Void):Socket {})
	@:overload(function(port:Int, ?connectListener:Void->Void):Socket {})
	@:overload(function(port:Int, host:String, ?connectListener:Void->Void):Socket {})
	function connect(options:EitherType<SocketConnectOptionsTcp, SocketConnectOptionsUnix>, ?connectListener:Void->Void):Socket;

	/**
		This property shows the number of characters buffered for writing.
		The buffer may contain strings whose length after encoding is not yet known,
		so this number is only an approximation of the number of bytes in the buffer.

		Users who experience large or growing `bufferSize` should attempt to "throttle" the data flows
		in their program with `pause` and `resume`.

		@deprecated Since v14.6.0 — use `writableLength` instead.
	**/
	@:deprecated("Use writableLength instead")
	var bufferSize(default, null):Int;

	/**
		A boolean value that indicates if the connection is destroyed or not.
		Once a connection is destroyed no further data can be transferred using it.

		define in Stream/Readable.hx
	**/
	// var destroyed(default, null):Bool;

	/**
		Ensures that no more I/O activity happens on this socket.
		Only necessary in case of errors (parse error or so).

		If `exception` is specified, an 'error' event will be emitted and
		any listeners for that event will receive exception as an argument.
	**/
	function destroy(?exception:Error):Socket;

	/**
		Destroys the socket after all data has been written.
		If there is remaining data in the write buffer, it will wait until that data has been flushed.
	**/
	function destroySoon():Void;

	/**
		Half-closes the socket by sending a FIN packet, then destroys it upon error / when fully closed.
		Useful for HTTP/1 agents that need to reset a pooled connection.
	**/
	function resetAndDestroy():Socket;

	/**
		Sets the socket to timeout after `timeout` milliseconds of inactivity on the socket.
		By default `Socket` do not have a timeout.

		When an idle timeout is triggered the socket will receive a 'timeout' event but the connection will not be severed.
		The user must manually `end` or `destroy` the socket.

		If `timeout` is 0, then the existing idle timeout is disabled.

		The optional `callback` parameter will be added as a one time listener for the 'timeout' event.
	**/
	function setTimeout(timeout:Int, ?callback:Void->Void):Socket;

	/**
		Disables the Nagle algorithm.
		By default TCP connections use the Nagle algorithm, they buffer data before sending it off.
		Setting true for `noDelay` will immediately fire off data each time `write` is called.
		`noDelay` defaults to true.
	**/
	function setNoDelay(?noDelay:Bool):Socket;

	/**
		Enable/disable keep-alive functionality, and optionally set the initial delay
		before the first keepalive probe is sent on an idle socket.

		`enable` defaults to false.

		Set `initialDelay` (in milliseconds) to set the delay between the last data packet received and
		the first keepalive probe.

		Setting 0 for `initialDelay` will leave the value unchanged from the default (or previous) setting.
		Defaults to 0.
	**/
	@:overload(function(?initialDelay:Int):Socket {})
	function setKeepAlive(enable:Bool, ?initialDelay:Int):Socket;

	/**
		Returns the current Type of Service (TOS) field for IPv4 packets or Traffic Class for IPv6 packets.

		`setTypeOfService` may be called before the socket is connected; the value will be cached and applied
		when the socket establishes a connection. `getTypeOfService` returns the currently set value even before connection.

		@see https://nodejs.org/api/net.html#socketgettypeofservice
	**/
	function getTypeOfService():Int;

	/**
		Sets the Type of Service (TOS) field for IPv4 packets or Traffic Class for IPv6 packets sent from this socket.
		`tos` must be in the range 0-255.

		@see https://nodejs.org/api/net.html#socketsettypeservicetos
	**/
	function setTypeOfService(tos:Int):Socket;

	/**
		Returns the bound address, the address family name and port of the socket as reported by the operating system.
	**/
	function address():SocketAdress;

	/**
		Calling `unref` on a socket will allow the program to exit if this is the only active socket in the event system.
		If the socket is already `unref`d calling `unref` again will have no effect.
	**/
	function unref():Socket;

	/**
		Opposite of `unref`, calling `ref` on a previously `unref`d socket will not let the program exit
		if it's the only socket left (the default behavior).
		If the socket is `ref`d calling `ref` again will have no effect.
	**/
	function ref():Socket;

	/**
		The string representation of the remote IP address.
		For example, '74.125.127.100' or '2001:4860:a005::68'.
		May be `undefined` if the socket is destroyed.
	**/
	var remoteAddress(default, null):Null<String>;

	/**
		The string representation of the remote IP family.
		'IPv4' or 'IPv6'.
		May be `undefined` if the socket is destroyed.
	**/
	var remoteFamily(default, null):Null<SocketAdressFamily>;

	/**
		The numeric representation of the remote port. For example, 80 or 21.
		May be `undefined` if the socket is destroyed.
	**/
	var remotePort(default, null):Null<Int>;

	/**
		The string representation of the local IP address the remote client is connecting on.
		For example, if you are listening on '0.0.0.0' and the client connects on '192.168.1.1',
		the value would be '192.168.1.1'.
	**/
	var localAddress(default, null):Null<String>;

	/**
		The numeric representation of the local port. For example, 80 or 21.
	**/
	var localPort(default, null):Null<Int>;

	/**
		The string representation of the local IP family. `'IPv4'` or `'IPv6'`.
	**/
	var localFamily(default, null):Null<SocketAdressFamily>;

	/**
		This property is only present when using `autoSelectFamily` and represents attempted addresses.

		@see https://nodejs.org/api/net.html#socketautoselectfamilyattemptedaddresses
	**/
	var autoSelectFamilyAttemptedAddresses(default, null):Array<String>;

	/**
		If `true`, `socket.connect(options[, connectListener])` was called and has not yet finished.
	**/
	var connecting(default, null):Bool;

	/**
		This is `true` if the socket is not connected yet, either because `.connect()` has not yet been called
		or because it is still in the process of connecting (see `connecting`).
	**/
	var pending(default, null):Bool;

	/**
		The socket timeout in milliseconds as set by `socket.setTimeout()`.
		`undefined` if a timeout has not been set.
	**/
	var timeout(default, null):Null<Int>;

	/**
		This property represents the state of the connection as a string.

		@see https://nodejs.org/api/net.html#socketreadystate
	**/
	var readyState(default, null):SocketReadyState;

	/**
		The amount of received bytes.
	**/
	var bytesRead(default, null):Int;

	/**
		The amount of bytes sent.
	**/
	var bytesWritten(default, null):Int;

	/**
		Always true for TLSSocket instances.

		May be used to distinguish TLS sockets from regular ones.
	**/
	var encrypted(default, null):Bool;
}
