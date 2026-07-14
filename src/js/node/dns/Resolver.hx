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

package js.node.dns;

import haxe.extern.EitherType;
import js.node.Dns;

/**
	An independent resolver for DNS requests.

	Creating a new resolver uses the default server settings.
	Setting the servers used for a resolver using `setServers()` does not affect other resolvers.

	@see https://nodejs.org/docs/latest-v22.x/api/dns.html#class-dnsresolver
**/
@:jsRequire("dns", "Resolver")
extern class Resolver {
	function new(?options:DnsResolverOptions);

	/**
		Cancel all outstanding DNS queries made by this resolver.
		The corresponding callbacks will be called with an error with code `ECANCELLED`.
	**/
	function cancel():Void;

	/**
		The resolver instance will send its requests from the specified IP address.
		This allows programs to specify outbound interfaces when used on multi-homed systems.
	**/
	function setLocalAddress(?ipv4:String, ?ipv6:String):Void;

	function getServers():Array<String>;
	function setServers(servers:Array<String>):Void;

	@:overload(function(hostname:String, callback:DnsError->Array<DnsResolvedAddress>->Void):Void {})
	function resolve(hostname:String, rrtype:DnsRrtype, callback:DnsError->Array<DnsResolvedAddress>->Void):Void;

	@:overload(function(hostname:String, options:DnsResolveOptions,
		callback:DnsError->EitherType<Array<String>, Array<DnsRecordWithTtl>>->Void):Void {})
	function resolve4(hostname:String, callback:DnsError->Array<String>->Void):Void;

	@:overload(function(hostname:String, options:DnsResolveOptions,
		callback:DnsError->EitherType<Array<String>, Array<DnsRecordWithTtl>>->Void):Void {})
	function resolve6(hostname:String, callback:DnsError->Array<String>->Void):Void;

	function resolveAny(hostname:String, callback:DnsError->Array<DnsAnyRecord>->Void):Void;
	function resolveCaa(hostname:String, callback:DnsError->Array<DnsResolvedAddressCAA>->Void):Void;
	function resolveCname(hostname:String, callback:DnsError->Array<String>->Void):Void;
	function resolveMx(hostname:String, callback:DnsError->Array<DnsResolvedAddressMX>->Void):Void;
	function resolveNaptr(hostname:String, callback:DnsError->Array<DnsResolvedAddressNAPTR>->Void):Void;
	function resolveNs(hostname:String, callback:DnsError->Array<String>->Void):Void;
	function resolvePtr(hostname:String, callback:DnsError->Array<String>->Void):Void;
	function resolveSoa(hostname:String, callback:DnsError->DnsResolvedAddressSOA->Void):Void;
	function resolveSrv(hostname:String, callback:DnsError->Array<DnsResolvedAddressSRV>->Void):Void;
	function resolveTlsa(hostname:String, callback:DnsError->Array<DnsResolvedAddressTLSA>->Void):Void;
	function resolveTxt(hostname:String, callback:DnsError->Array<Array<String>>->Void):Void;
	function reverse(ip:String, callback:DnsError->Array<String>->Void):Void;
}
