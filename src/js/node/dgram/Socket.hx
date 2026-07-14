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

package js.node.dgram;

import haxe.extern.EitherType;
import js.lib.ArrayBufferView;
import js.lib.Error;
import js.node.Dns;
import js.node.events.EventEmitter;
import js.node.net.BlockList;
import js.node.net.Socket.SocketAdress;
import js.node.web.AbortSignal;

/**
	Enumeration of events for the `Socket` object.
**/
enum abstract SocketEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when a new datagram is available on a socket.
		Listener arguments:
			`msg` - received data
			`rinfo` - sender's address information and the number of bytes in the datagram
	**/
	var Message:SocketEvent<MessageListener> = "message";

	/**
		Emitted once the `dgram.Socket` is addressable and can receive data.
		This happens either explicitly with `socket.bind()` or implicitly the first time
		data is sent using `socket.send()`.
	**/
	var Listening:SocketEvent<() -> Void> = "listening";

	/**
		Emitted after a socket is closed with `close()`.
		No new `'message'` events will be emitted on this socket.
	**/
	var Close:SocketEvent<() -> Void> = "close";

	/**
		Emitted whenever any error occurs.
	**/
	var Error:SocketEvent<(err:Error) -> Void> = "error";

	/**
		Emitted after a socket has been associated with a remote address via `socket.connect()`.
	**/
	var Connect:SocketEvent<() -> Void> = "connect";
}

/**
	Remote address information for the `SocketEvent.Message` event.
**/
typedef MessageRemoteInfo = {
	> SocketAdress,

	/**
		The message size.
	**/
	var size:Int;
}

typedef MessageListener = (msg:Buffer, rinfo:MessageRemoteInfo) -> Void;

typedef SocketSendCallback = (error:Null<Error>, bytes:Int) -> Void;

/**
	Enumeration of possible datagram socket types.
**/
enum abstract SocketType(String) from String to String {
	var Udp4 = "udp4";
	var Udp6 = "udp6";
}

/**
	Options for `Dgram.createSocket`.
**/
typedef SocketOptions = {
	/**
		The family of socket. Must be either `'udp4'` or `'udp6'`.
	**/
	var type:SocketType;

	/**
		When `true`, `socket.bind()` will reuse the address, even if another process has already
		bound a socket on it, but only one socket can receive the data.
		Default: `false`.
	**/
	@:optional var reuseAddr:Bool;

	/**
		When `true`, `socket.bind()` will reuse the port, even if another process has already bound
		a socket on it. Incoming datagrams are distributed to listening sockets.
		Available only on some platforms (Linux 3.9+, DragonFlyBSD 3.6+, FreeBSD 12.0+, Solaris 11.4, AIX 7.2.5+).
		On unsupported platforms, this option raises an error when the socket is bound.
		Default: `false`.
	**/
	@:optional var reusePort:Bool;

	/**
		Setting `ipv6Only` to `true` will disable dual-stack support, i.e., binding to address `::`
		won't make `0.0.0.0` be bound.
		Default: `false`.
	**/
	@:optional var ipv6Only:Bool;

	/**
		Sets the `SO_RCVBUF` socket value.
	**/
	@:optional var recvBufferSize:Int;

	/**
		Sets the `SO_SNDBUF` socket value.
	**/
	@:optional var sendBufferSize:Int;

	/**
		Custom lookup function. Defaults to `Dns.lookup`.
	**/
	@:optional var lookup:(hostname:String, options:DnsLookupOptions, callback:DnsLookupCallbackSingle) -> Void;

	/**
		An `AbortSignal` that may be used to close the socket.
	**/
	@:optional var signal:AbortSignal;

	/**
		Can be used for discarding inbound datagrams to specific IP addresses, IP ranges, or IP subnets.
		This does not work if the server is behind a reverse proxy, NAT, etc., because the address
		checked against the blocklist is the address of the proxy, or the one specified by the NAT.
	**/
	@:optional var receiveBlockList:BlockList;

	/**
		Can be used for disabling outbound access to specific IP addresses, IP ranges, or IP subnets.
	**/
	@:optional var sendBlockList:BlockList;
}

/**
	Options for `Socket.bind`.
**/
typedef SocketBindOptions = {
	/**
		Port to bind. If not specified or `0`, the OS attempts to bind to a random port.
	**/
	@:optional var port:Int;

	/**
		Address to bind. If not specified, the OS attempts to listen on all addresses.
	**/
	@:optional var address:String;

	/**
		When `false` (default), cluster workers share the same underlying handle.
		When `true`, the handle is not shared and attempted port sharing results in an error.
		Creating a socket with `reusePort: true` causes `exclusive` to always be `true` when `bind` is called.
	**/
	@:optional var exclusive:Bool;

	/**
		When an `fd` greater than `0` is set, wrap an existing socket with the given file descriptor.
		In this case, `port` and `address` are ignored.
	**/
	@:optional var fd:Int;
}

/**
	Encapsulates the datagram functionality.

	New instances are created using `Dgram.createSocket`.
	The `new` keyword must not be used to create `dgram.Socket` instances.
**/
@:jsRequire("dgram", "Socket")
extern class Socket extends EventEmitter<Socket> {
	@:overload(function(type:SocketType, ?callback:MessageListener):Void {})
	private function new(options:SocketOptions, ?callback:MessageListener);

	/**
		Broadcasts a datagram on the socket.

		For connectionless sockets, the destination `port` and `address` must be specified.
		Connected sockets use their associated remote endpoint, so `port` and `address` must not be set.

		`msg` may be a `String`, `Buffer` / `ArrayBufferView` (`TypedArray` or `DataView`), or an array of
		those. When `msg` is a string it is automatically converted to a `Buffer` with `'utf8'` encoding.
		`offset` and `length` are supported only for buffer-like messages (not strings or arrays).

		If `address` is omitted or nullish, `'127.0.0.1'` (udp4) or `'::1'` (udp6) is used.
		If the socket has not been bound, it is assigned a random port and bound to all interfaces.

		An optional `callback` may be specified to detect DNS errors or for determining when it is safe
		to reuse the buffer. DNS lookups delay the time to send by at least one tick.
		The only way to know for sure that the datagram has been sent is by using a `callback`.
	**/
	@:overload(function(msg:EitherType<String, EitherType<ArrayBufferView, Array<EitherType<String, ArrayBufferView>>>>,
		?callback:SocketSendCallback):Void {})
	@:overload(function(msg:EitherType<String, EitherType<ArrayBufferView, Array<EitherType<String, ArrayBufferView>>>>, port:Int,
		?callback:SocketSendCallback):Void {})
	@:overload(function(msg:EitherType<String, EitherType<ArrayBufferView, Array<EitherType<String, ArrayBufferView>>>>, port:Int, address:String,
		?callback:SocketSendCallback):Void {})
	@:overload(function(msg:ArrayBufferView, offset:Int, length:Int, ?callback:SocketSendCallback):Void {})
	@:overload(function(msg:ArrayBufferView, offset:Int, length:Int, port:Int, ?callback:SocketSendCallback):Void {})
	function send(msg:ArrayBufferView, offset:Int, length:Int, port:Int, address:String, ?callback:SocketSendCallback):Void;

	/**
		Associates the `dgram.Socket` to a remote address and port. Subsequent messages are sent to that
		destination, and the socket only receives messages from that remote peer.

		Calling `connect()` on an already-connected socket throws `ERR_SOCKET_DGRAM_IS_CONNECTED`.
		If `address` is not provided, `'127.0.0.1'` (udp4) or `'::1'` (udp6) is used.
	**/
	@:overload(function(port:Int, callback:() -> Void):Void {})
	@:overload(function(port:Int, address:String, ?callback:() -> Void):Void {})
	function connect(port:Int, ?callback:() -> Void):Void;

	/**
		A synchronous function that disassociates a connected `dgram.Socket` from its remote address.
		Throws `ERR_SOCKET_DGRAM_NOT_CONNECTED` if the socket is unbound or already disconnected.
	**/
	function disconnect():Void;

	/**
		Returns an object containing the `address`, `family`, and `port` of the remote endpoint.
		Throws `ERR_SOCKET_DGRAM_NOT_CONNECTED` if the socket is not connected.
	**/
	function remoteAddress():SocketAdress;

	/**
		Causes the socket to listen for datagram messages on a named `port` and optional `address`.
		If `port` is not specified or is `0`, the OS attempts to bind to a random port.
		If `address` is not specified, the OS attempts to listen on all addresses.
		After binding is done, a `'listening'` event is emitted and the `callback` (if specified) is called.

		A bound datagram socket keeps the Node.js process running to receive datagrams.

		If binding fails, an `'error'` event is generated. In rare cases (e.g. binding a closed socket),
		an `Error` may be thrown.

		Returns a reference to the socket so calls can be chained.
	**/
	@:overload(function(options:SocketBindOptions, ?callback:() -> Void):Socket {})
	@:overload(function(port:Int, address:String, ?callback:() -> Void):Socket {})
	@:overload(function(port:Int, ?callback:() -> Void):Socket {})
	function bind(?callback:() -> Void):Socket;

	/**
		Close the underlying socket and stop listening for data on it.

		If a `callback` is provided, it is added as a listener for the `'close'` event.
		Returns a reference to the socket so calls can be chained.
	**/
	function close(?callback:() -> Void):Socket;

	/**
		Returns an object containing the address information for a socket (`address`, `family`, `port`).
		Throws `EBADF` if called on an unbound socket.
	**/
	function address():SocketAdress;

	/**
		Sets or clears the `SO_BROADCAST` socket option.
		When this option is set, UDP packets may be sent to a local interface's broadcast address.
		Throws `EBADF` if called on an unbound socket.
	**/
	function setBroadcast(flag:Bool):Void;

	/**
		Sets the `IP_TTL` socket option. TTL stands for "Time to Live," but in this context it specifies
		the number of IP hops that a packet is allowed to go through. Each router or gateway that forwards
		a packet decrements the TTL. If the TTL is decremented to 0 by a router, it will not be forwarded.
		Changing TTL values is typically done for network probes or when multicasting.

		The argument to `setTTL` is a number of hops between 1 and 255. The default on most systems is 64.
		Throws `EBADF` if called on an unbound socket.
	**/
	function setTTL(ttl:Int):Int;

	/**
		Sets the `IP_MULTICAST_TTL` socket option. TTL stands for "Time to Live," but in this context it specifies
		the number of IP hops that a packet is allowed to go through, specifically for multicast traffic.
		Each router or gateway that forwards a packet decrements the TTL. If the TTL is decremented to 0 by a router,
		it will not be forwarded.

		The argument to `setMulticastTTL` is a number of hops between 0 and 255. The default on most systems is 1.
		Throws `EBADF` if called on an unbound socket.
	**/
	function setMulticastTTL(ttl:Int):Int;

	/**
		Sets or clears the `IP_MULTICAST_LOOP` socket option.
		When this option is set, multicast packets will also be received on the local interface.
		Throws `EBADF` if called on an unbound socket.
	**/
	function setMulticastLoopback(flag:Bool):Bool;

	/**
		Tells the kernel to join a multicast group with the `IP_ADD_MEMBERSHIP` socket option.

		If `multicastInterface` is not specified, the OS chooses one interface and adds membership to it.
		To add membership on every available interface, call `addMembership` once per interface.

		When called on an unbound socket, this method implicitly binds to a random port on all interfaces.
	**/
	function addMembership(multicastAddress:String, ?multicastInterface:String):Void;

	/**
		Opposite of `addMembership` — tells the kernel to leave a multicast group with the `IP_DROP_MEMBERSHIP`
		socket option. This is automatically called by the kernel when the socket is closed or the process
		terminates, so most apps will never need to call this.

		If `multicastInterface` is not specified, the OS will try to drop membership on all valid interfaces.
	**/
	function dropMembership(multicastAddress:String, ?multicastInterface:String):Void;

	/**
		Instructs the kernel to join a source-specific multicast channel with the `IP_ADD_SOURCE_MEMBERSHIP`
		socket option. When called on an unbound socket, this method implicitly binds to a random port on all interfaces.
	**/
	function addSourceSpecificMembership(sourceAddress:String, groupAddress:String, ?multicastInterface:String):Void;

	/**
		Instructs the kernel to leave a source-specific multicast channel with the `IP_DROP_SOURCE_MEMBERSHIP`
		socket option. Automatically called when the socket is closed or the process terminates.
	**/
	function dropSourceSpecificMembership(sourceAddress:String, groupAddress:String, ?multicastInterface:String):Void;

	/**
		Sets the default outgoing multicast interface of the socket to a chosen interface or back to system
		interface selection. Throws `EBADF` if called on an unbound socket.
	**/
	function setMulticastInterface(multicastInterface:String):Void;

	/**
		Sets the `SO_RCVBUF` socket option.
		Throws `ERR_SOCKET_BUFFER_SIZE` if called on an unbound socket.
	**/
	function setRecvBufferSize(size:Int):Void;

	/**
		Sets the `SO_SNDBUF` socket option.
		Throws `ERR_SOCKET_BUFFER_SIZE` if called on an unbound socket.
	**/
	function setSendBufferSize(size:Int):Void;

	/**
		Gets the current value of the `SO_RCVBUF` socket option.
		Throws `ERR_SOCKET_BUFFER_SIZE` if called on an unbound socket.
	**/
	function getRecvBufferSize():Int;

	/**
		Gets the current value of the `SO_SNDBUF` socket option.
		Throws `ERR_SOCKET_BUFFER_SIZE` if called on an unbound socket.
	**/
	function getSendBufferSize():Int;

	/**
		Number of bytes queued for sending.
	**/
	function getSendQueueSize():Int;

	/**
		Number of send requests currently in the queue awaiting to be processed.
	**/
	function getSendQueueCount():Int;

	/**
		Calling `unref` on a socket will allow the program to exit if this is the only active socket in the event system.
		If the socket is already `unref`d calling `unref` again will have no effect.
		Returns a reference to the socket so calls can be chained.
	**/
	function unref():Socket;

	/**
		Opposite of `unref`, calling `ref` on a previously `unref`d socket will not let
		the program exit if it's the only socket left (the default behavior).
		If the socket is `ref`d calling `ref` again will have no effect.
		Returns a reference to the socket so calls can be chained.
	**/
	function ref():Socket;
}
