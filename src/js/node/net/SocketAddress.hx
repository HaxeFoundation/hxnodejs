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

/**
	IP version for `SocketAddress` construction.
**/
enum abstract SocketAddressFamily(String) from String to String {
	var IPv4 = "ipv4";
	var IPv6 = "ipv6";
}

/**
	Options for `new SocketAddress()`.
**/
typedef SocketAddressOptions = {
	/**
		The network address as either an IPv4 or IPv6 string.
		Default: `'127.0.0.1'` if `family` is `'ipv4'`; `'::'` if `family` is `'ipv6'`.
	**/
	@:optional var address:String;

	/**
		Either `'ipv4'` or `'ipv6'`. Default: `'ipv4'`.
	**/
	@:optional var family:SocketAddressFamily;

	/**
		An IPv6 flow-label used only if `family` is `'ipv6'`.
	**/
	@:optional var flowlabel:Int;

	/**
		An IP port.
	**/
	@:optional var port:Int;
}

/**
	Represents a network endpoint as an IP address and port pair.

	@see https://nodejs.org/api/net.html#class-netsocketaddress
**/
@:jsRequire("net", "SocketAddress")
extern class SocketAddress {
	/**
		Creates a new `SocketAddress`.

		@see https://nodejs.org/api/net.html#new-netsocketaddressoptions
	**/
	function new(?options:SocketAddressOptions):Void;

	/**
		Parses an IP address and optional port string into a `SocketAddress`.

		`input` examples: `123.1.2.3:1234` or `[1::1]:1234`.
		Returns `null`/`undefined` if parsing fails.

		@see https://nodejs.org/api/net.html#socketaddressparseinput
	**/
	static function parse(input:String):Null<SocketAddress>;

	/**
		The network address as either an IPv4 or IPv6 string.
	**/
	var address(default, null):String;

	/**
		Either `'ipv4'` or `'ipv6'`.
	**/
	var family(default, null):SocketAddressFamily;

	/**
		An IP port.
	**/
	var port(default, null):Int;

	/**
		An IPv6 flow-label used only if `family` is `'ipv6'`.
	**/
	var flowlabel(default, null):Int;
}
