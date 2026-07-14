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

package js.node.dns;

import haxe.extern.EitherType;
import js.lib.Promise;
import js.node.Dns;

/**
	Promise-based independent resolver for DNS requests (`dns/promises.Resolver`).

	@see https://nodejs.org/docs/latest-v24.x/api/dns.html#class-dnspromisesresolver
**/
@:jsRequire("dns/promises", "Resolver")
extern class PromisesResolver {
	function new(?options:DnsResolverOptions);

	/**
		Cancel all outstanding DNS queries made by this resolver.
		The corresponding promises will be rejected with an error with the code `ECANCELLED`.
	**/
	function cancel():Void;

	/**
		The resolver instance will send its requests from the specified IP address.
		This allows programs to specify outbound interfaces when used on multi-homed systems.

		Uses the v4 local address when making requests to IPv4 DNS servers,
		and the v6 local address when making requests to IPv6 DNS servers.
	**/
	function setLocalAddress(?ipv4:String, ?ipv6:String):Void;

	/**
		Returns an array of IP address strings, formatted according to RFC 5952,
		that are currently configured for this resolver.
	**/
	function getServers():Array<String>;

	/**
		Sets the IP address and port of servers to be used by this resolver.
		The `servers` argument is an array of RFC 5952 formatted addresses.
	**/
	function setServers(servers:Array<String>):Void;

	@:overload(function(hostname:String):Promise<Array<String>> {})
	function resolve(hostname:String, rrtype:DnsRrtype):Promise<DnsResolveRecords>;

	@:overload(function(hostname:String, options:DnsResolveOptions):Promise<EitherType<Array<String>, Array<DnsRecordWithTtl>>> {})
	function resolve4(hostname:String):Promise<Array<String>>;

	@:overload(function(hostname:String, options:DnsResolveOptions):Promise<EitherType<Array<String>, Array<DnsRecordWithTtl>>> {})
	function resolve6(hostname:String):Promise<Array<String>>;

	function resolveAny(hostname:String):Promise<Array<DnsAnyRecord>>;
	function resolveCaa(hostname:String):Promise<Array<DnsResolvedAddressCAA>>;
	function resolveCname(hostname:String):Promise<Array<String>>;
	function resolveMx(hostname:String):Promise<Array<DnsResolvedAddressMX>>;
	function resolveNaptr(hostname:String):Promise<Array<DnsResolvedAddressNAPTR>>;
	function resolveNs(hostname:String):Promise<Array<String>>;
	function resolvePtr(hostname:String):Promise<Array<String>>;
	function resolveSoa(hostname:String):Promise<DnsResolvedAddressSOA>;
	function resolveSrv(hostname:String):Promise<Array<DnsResolvedAddressSRV>>;
	function resolveTlsa(hostname:String):Promise<Array<DnsResolvedAddressTLSA>>;
	function resolveTxt(hostname:String):Promise<Array<Array<String>>>;
	function reverse(ip:String):Promise<Array<String>>;
}
