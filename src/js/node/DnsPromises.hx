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

package js.node;

import haxe.extern.EitherType;
import js.lib.Promise;
import js.node.Dns;
import js.node.dns.PromisesResolver as PromisesResolverObject;

/**
	The `dns/promises` API provides an alternative set of asynchronous DNS methods
	that return `Promise` objects rather than using callbacks.

	The API is accessible via `require('dns/promises')` or `require('dns').promises`.

	`ADDRCONFIG`, `V4MAPPED`, and `ALL` are not exported by `dns/promises` (they are `undefined`
	there). For lookup `hints`, use `Dns.ADDRCONFIG`, `Dns.V4MAPPED`, and `Dns.ALL`.

	Error codes (`NODATA`, `NOTFOUND`, …) are also exported by this module; their values match `DnsErrorCode`.

	@see https://nodejs.org/docs/latest-v24.x/api/dns.html#dns-promises-api
**/
@:jsRequire("dns/promises")
extern class DnsPromises {
	/**
		Returns an array of IP address strings, formatted according to
		[RFC 5952](https://tools.ietf.org/html/rfc5952), that are currently configured for DNS resolution.
		A string will include a port section if a custom port is used.
	**/
	static function getServers():Array<String>;

	/**
		Resolves a `hostname` into the first found A (IPv4) or AAAA (IPv6) record.

		With `all: false` (default), fulfills with `{ address, family }`.
		With `all: true`, fulfills with an array of such objects.
	**/
	@:overload(function(hostname:String):Promise<DnsPromisesLookupResult> {})
	@:overload(function(hostname:String, options:DnsAddressFamily):Promise<DnsPromisesLookupResult> {})
	@:overload(function(hostname:String, options:DnsLookupAllOptions):Promise<Array<DnsLookupCallbackAllEntry>> {})
	static function lookup(hostname:String,
		options:EitherType<DnsAddressFamily, DnsLookupOptions>):Promise<EitherType<DnsPromisesLookupResult, Array<DnsLookupCallbackAllEntry>>>;

	/**
		Resolves the given `address` and `port` into a hostname and service using `getnameinfo`.
	**/
	static function lookupService(address:String, port:Int):Promise<DnsPromisesLookupServiceResult>;

	/**
		Uses the DNS protocol to resolve a hostname into the record types specified by `rrtype` (default `'A'`).
		`SOA` fulfills with a single object; `TXT` with `Array<Array<String>>`.
	**/
	@:overload(function(hostname:String):Promise<Array<String>> {})
	static function resolve(hostname:String, rrtype:DnsRrtype):Promise<DnsResolveRecords>;

	/**
		Uses the DNS protocol to resolve IPv4 addresses (`A` records) for the `hostname`.

		When `options.ttl` is `true`, each entry is `{ address, ttl }` instead of a string.
	**/
	@:overload(function(hostname:String, options:DnsResolveOptions):Promise<EitherType<Array<String>, Array<DnsRecordWithTtl>>> {})
	static function resolve4(hostname:String):Promise<Array<String>>;

	/**
		Uses the DNS protocol to resolve IPv6 addresses (`AAAA` records) for the `hostname`.

		When `options.ttl` is `true`, each entry is `{ address, ttl }` instead of a string.
	**/
	@:overload(function(hostname:String, options:DnsResolveOptions):Promise<EitherType<Array<String>, Array<DnsRecordWithTtl>>> {})
	static function resolve6(hostname:String):Promise<Array<String>>;

	/**
		Uses the DNS protocol to resolve all records (also known as `ANY` or `*` query).

		DNS server operators may choose not to respond to `ANY` queries; prefer specific `resolve*` methods when possible.
	**/
	static function resolveAny(hostname:String):Promise<Array<DnsAnyRecord>>;

	/**
		Uses the DNS protocol to resolve `CAA` records for the `hostname`.
	**/
	static function resolveCaa(hostname:String):Promise<Array<DnsResolvedAddressCAA>>;

	/**
		Uses the DNS protocol to resolve `CNAME` records for the `hostname`.
	**/
	static function resolveCname(hostname:String):Promise<Array<String>>;

	/**
		Uses the DNS protocol to resolve mail exchange records (`MX` records) for the `hostname`.
	**/
	static function resolveMx(hostname:String):Promise<Array<DnsResolvedAddressMX>>;

	/**
		Uses the DNS protocol to resolve regular expression-based records (`NAPTR` records) for the `hostname`.
	**/
	static function resolveNaptr(hostname:String):Promise<Array<DnsResolvedAddressNAPTR>>;

	/**
		Uses the DNS protocol to resolve name server records (`NS` records) for the `hostname`.
	**/
	static function resolveNs(hostname:String):Promise<Array<String>>;

	/**
		Uses the DNS protocol to resolve pointer records (`PTR` records) for the `hostname`.
	**/
	static function resolvePtr(hostname:String):Promise<Array<String>>;

	/**
		Uses the DNS protocol to resolve a start of authority record (`SOA` record) for the `hostname`.
	**/
	static function resolveSoa(hostname:String):Promise<DnsResolvedAddressSOA>;

	/**
		Uses the DNS protocol to resolve service records (`SRV` records) for the `hostname`.
	**/
	static function resolveSrv(hostname:String):Promise<Array<DnsResolvedAddressSRV>>;

	/**
		Uses the DNS protocol to resolve certificate associations (`TLSA` records) for the `hostname`.
	**/
	static function resolveTlsa(hostname:String):Promise<Array<DnsResolvedAddressTLSA>>;

	/**
		Uses the DNS protocol to resolve text queries (`TXT` records) for the `hostname`.
	**/
	static function resolveTxt(hostname:String):Promise<Array<Array<String>>>;

	/**
		Performs a reverse DNS query that resolves an IPv4 or IPv6 address to an array of hostnames.
	**/
	static function reverse(ip:String):Promise<Array<String>>;

	/**
		Sets the IP address and port of servers to be used when performing DNS resolution.
		The `servers` argument is an array of RFC 5952 formatted addresses.
		If the port is the IANA default DNS port (53) it can be omitted.
	**/
	static function setServers(servers:Array<String>):Void;

	/**
		Get the default value for `order` in `Dns.lookup` and `DnsPromises.lookup`.
	**/
	static function getDefaultResultOrder():DnsResultOrder;

	/**
		Set the default value of `order` in `Dns.lookup` and `DnsPromises.lookup`.
		The default is `verbatim`. This call has higher priority than `--dns-result-order`.
	**/
	static function setDefaultResultOrder(order:DnsResultOrder):Void;

	/**
		DNS server returned answer with no data.
	**/
	static final NODATA:DnsErrorCode;

	/**
		DNS server claims query was misformatted.
	**/
	static final FORMERR:DnsErrorCode;

	/**
		DNS server returned general failure.
	**/
	static final SERVFAIL:DnsErrorCode;

	/**
		Domain name not found.
	**/
	static final NOTFOUND:DnsErrorCode;

	/**
		DNS server does not implement requested operation.
	**/
	static final NOTIMP:DnsErrorCode;

	/**
		DNS server refused query.
	**/
	static final REFUSED:DnsErrorCode;

	/**
		Misformatted DNS query.
	**/
	static final BADQUERY:DnsErrorCode;

	/**
		Misformatted domain name.
	**/
	static final BADNAME:DnsErrorCode;

	/**
		Unsupported address family.
	**/
	static final BADFAMILY:DnsErrorCode;

	/**
		Misformatted DNS reply.
	**/
	static final BADRESP:DnsErrorCode;

	/**
		Could not contact DNS servers.
	**/
	static final CONNREFUSED:DnsErrorCode;

	/**
		Timeout while contacting DNS servers.
	**/
	static final TIMEOUT:DnsErrorCode;

	/**
		End of file.
	**/
	static final EOF:DnsErrorCode;

	/**
		Error reading file.
	**/
	static final FILE:DnsErrorCode;

	/**
		Out of memory.
	**/
	static final NOMEM:DnsErrorCode;

	/**
		Channel is being destroyed.
	**/
	static final DESTRUCTION:DnsErrorCode;

	/**
		Misformatted string.
	**/
	static final BADSTR:DnsErrorCode;

	/**
		Illegal flags specified.
	**/
	static final BADFLAGS:DnsErrorCode;

	/**
		Given hostname is not numeric.
	**/
	static final NONAME:DnsErrorCode;

	/**
		Illegal hints flags specified.
	**/
	static final BADHINTS:DnsErrorCode;

	/**
		c-ares library initialization not yet performed.
	**/
	static final NOTINITIALIZED:DnsErrorCode;

	/**
		Error loading iphlpapi.dll.
	**/
	static final LOADIPHLPAPI:DnsErrorCode;

	/**
		Could not find GetNetworkParams function.
	**/
	static final ADDRGETNETWORKPARAMS:DnsErrorCode;

	/**
		DNS query cancelled.
	**/
	static final CANCELLED:DnsErrorCode;

	/**
		`Resolver` class constructor for an independent promise-based DNS resolver.

		@see https://nodejs.org/docs/latest-v24.x/api/dns.html#class-dnspromisesresolver
	**/
	static final Resolver:Class<PromisesResolverObject>;
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
