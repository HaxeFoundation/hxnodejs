/*
 * Copyright (C)2014-2020 Haxe Foundation
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
	Represents a network endpoint as an IP address and port pair.

	@see https://nodejs.org/api/net.html#class-netsocketaddress
**/
@:jsRequire("net", "SocketAddress")
extern class SocketAddress {
	/**
		Creates a new `SocketAddress`.

		`family` is either `'ipv4'` or `'ipv6'`. Default: `'ipv4'`.

		@see https://nodejs.org/api/net.html#new-netsocketaddressoptions
	**/
	function new(?options:{
		?address:String,
		?family:String,
		?flowlabel:Int,
		?port:Int
	}):Void;

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
	var family(default, null):String;

	/**
		An IP port.
	**/
	var port(default, null):Int;

	/**
		An IPv6 flow-label used only if `family` is `'ipv6'`.
	**/
	var flowlabel(default, null):Int;
}
