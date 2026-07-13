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

package js.node;

import haxe.extern.EitherType;
import js.node.Dns;
#if haxe4
import js.lib.Promise;
#else
import js.Promise;
#end

/**
	The `dns/promises` API provides an alternative set of asynchronous DNS methods
	that return `Promise` objects rather than using callbacks.

	This binding covers the common promise-based lookup/resolve helpers.
	It does not yet include `Resolver`, `resolveAny` / `resolveCaa` / `resolveNaptr` /
	`resolveTlsa`, or `setDefaultResultOrder`.

	`ADDRCONFIG` and `V4MAPPED` are not exported by `dns/promises` (they are `undefined`
	there). For lookup `hints`, use `Dns.ADDRCONFIG` and `Dns.V4MAPPED`.

	@see https://nodejs.org/api/dns.html#dns-promises-api
**/
@:jsRequire("dns/promises")
extern class DnsPromises {
	/**
		Returns an array of IP address strings, formatted according to
		[RFC 5952](https://tools.ietf.org/html/rfc5952), that are currently configured for DNS resolution.
	**/
	static function getServers():Array<String>;

	/**
		Resolves a `hostname` into the first found A (IPv4) or AAAA (IPv6) record.

		With `all: false` (default), fulfills with `{ address, family }`.
		With `all: true`, fulfills with an array of such objects.
	**/
	@:overload(function(hostname:String):Promise<DnsPromisesLookupResult> {})
	@:overload(function(hostname:String, options:DnsAddressFamily):Promise<DnsPromisesLookupResult> {})
	@:overload(function(hostname:String, options:{family:DnsAddressFamily, ?hints:Int, all:Bool}):Promise<Array<DnsLookupCallbackAllEntry>> {})
	static function lookup(hostname:String, options:EitherType<DnsAddressFamily, DnsLookupOptions>):Promise<EitherType<DnsPromisesLookupResult, Array<DnsLookupCallbackAllEntry>>>;

	/**
		Resolves the given `address` and `port` into a hostname and service using `getnameinfo`.
	**/
	static function lookupService(address:String, port:Int):Promise<DnsPromisesLookupServiceResult>;

	/**
		Uses the DNS protocol to resolve a hostname into an array of the record types specified by `rrtype`.
	**/
	@:overload(function(hostname:String):Promise<Array<DnsResolvedAddress>> {})
	static function resolve(hostname:String, rrtype:DnsRrtype):Promise<Array<DnsResolvedAddress>>;

	/**
		Uses the DNS protocol to resolve IPv4 addresses (`A` records) for the `hostname`.
	**/
	static function resolve4(hostname:String):Promise<Array<String>>;

	/**
		Uses the DNS protocol to resolve IPv6 addresses (`AAAA` records) for the `hostname`.
	**/
	static function resolve6(hostname:String):Promise<Array<String>>;

	/**
		Uses the DNS protocol to resolve mail exchange records (`MX` records) for the `hostname`.
	**/
	static function resolveMx(hostname:String):Promise<Array<DnsResolvedAddressMX>>;

	/**
		Uses the DNS protocol to resolve text queries (`TXT` records) for the `hostname`.
	**/
	static function resolveTxt(hostname:String):Promise<Array<Array<String>>>;

	/**
		Uses the DNS protocol to resolve service records (`SRV` records) for the `hostname`.
	**/
	static function resolveSrv(hostname:String):Promise<Array<DnsResolvedAddressSRV>>;

	/**
		Uses the DNS protocol to resolve pointer records (`PTR` records) for the `hostname`.
	**/
	static function resolvePtr(hostname:String):Promise<Array<String>>;

	/**
		Uses the DNS protocol to resolve a start of authority record (`SOA` record) for the `hostname`.
	**/
	static function resolveSoa(hostname:String):Promise<DnsResolvedAddressSOA>;

	/**
		Uses the DNS protocol to resolve name server records (`NS` records) for the `hostname`.
	**/
	static function resolveNs(hostname:String):Promise<Array<String>>;

	/**
		Uses the DNS protocol to resolve `CNAME` records for the `hostname`.
	**/
	static function resolveCname(hostname:String):Promise<Array<String>>;

	/**
		Performs a reverse DNS query that resolves an IPv4 or IPv6 address to an array of hostnames.
	**/
	static function reverse(ip:String):Promise<Array<String>>;

	/**
		Sets the IP address and port of servers to be used when performing DNS resolution.
	**/
	static function setServers(servers:Array<String>):Void;
}

/**
	Result of `DnsPromises.lookup` when `all` is not `true`.
**/
typedef DnsPromisesLookupResult = {
	var address:String;
	var family:DnsAddressFamily;
}

/**
	Result of `DnsPromises.lookupService`.
**/
typedef DnsPromisesLookupServiceResult = {
	var hostname:String;
	var service:String;
}
