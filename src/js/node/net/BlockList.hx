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

/**
	IP version used by `BlockList` add/check methods.
**/
enum abstract BlockListAddressType(String) from String to String {
	var IPv4 = "ipv4";
	var IPv6 = "ipv6";
}

/**
	The `BlockList` object can be used with some network APIs to specify rules
	for disabling inbound or outbound access to specific IP addresses, IP ranges, or IP subnets.
**/
@:jsRequire("net", "BlockList")
extern class BlockList {
	function new();

	/**
		Returns `true` if the `value` is a `net.BlockList`.

		@see https://nodejs.org/api/net.html#blocklistisblocklistvalue
	**/
	static function isBlockList(value:Any):Bool;

	/**
		Adds a rule to block the given IP address.

		`type` defaults to `'ipv4'`.
	**/
	function addAddress(address:EitherType<String, SocketAddress>, ?type:BlockListAddressType):Void;

	/**
		Adds a rule to block a range of IP addresses from `start` (inclusive) to `end` (inclusive).

		`type` defaults to `'ipv4'`.
	**/
	function addRange(start:EitherType<String, SocketAddress>, end:EitherType<String, SocketAddress>, ?type:BlockListAddressType):Void;

	/**
		Adds a rule to block a range of IP addresses specified as a subnet mask.

		`prefix` is the number of CIDR prefix bits. For IPv4, this must be between 0 and 32.
		For IPv6, this must be between 0 and 128.

		`type` defaults to `'ipv4'`.
	**/
	function addSubnet(net:EitherType<String, SocketAddress>, prefix:Int, ?type:BlockListAddressType):Void;

	/**
		Returns `true` if the given IP address matches any of the rules added to the `BlockList`.

		`type` defaults to `'ipv4'`.
	**/
	function check(address:EitherType<String, SocketAddress>, ?type:BlockListAddressType):Bool;

	/**
		The list of rules added to the blocklist.
	**/
	var rules(default, null):Array<String>;

	/**
		Loads rules from a JSON string or an array of rule strings (same format as `rules`).

		Stability: 1 - Experimental.

		@see https://nodejs.org/api/net.html#blocklistfromjsonvalue
	**/
	function fromJSON(value:EitherType<String, Array<String>>):Void;

	/**
		Returns the rules as a JSON-serializable array of strings (same format as `rules`).

		Stability: 1 - Experimental.

		@see https://nodejs.org/api/net.html#blocklisttojson
	**/
	function toJSON():Array<String>;
}
