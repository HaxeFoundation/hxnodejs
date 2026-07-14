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
import js.node.dns.Resolver as ResolverObject;
import js.lib.ArrayBuffer;
import js.lib.Error;

/**
	Enumeration of possible Int `options` / callback `family` values for `Dns.lookup`.
**/
enum abstract DnsAddressFamily(Int) from Int to Int {
	/**
		Either an IPv4 or IPv6 address may be returned (default when omitted).
		Also used in lookup results when the address is not IPv4/IPv6.
	**/
	var Unspecified = 0;
	var IPv4 = 4;
	var IPv6 = 6;
}

/**
	Values for the `order` option of `Dns.lookup` / `DnsPromises.lookup`
	and for `Dns.setDefaultResultOrder` / `Dns.getDefaultResultOrder`.
**/
enum abstract DnsResultOrder(String) from String to String {
	var Ipv4First = "ipv4first";
	var Ipv6First = "ipv6first";
	var Verbatim = "verbatim";
}

/**
	Type of the `options` argument for `Dns.lookup`.
**/
typedef DnsLookupOptions = {
	/**
		The record family. Must be `4`, `6`, or `0`.
		For compatibility, `'IPv4'` and `'IPv6'` are also accepted.
		The value `0` indicates that either an IPv4 or IPv6 address is returned.
	**/
	@:optional var family:EitherType<DnsAddressFamily, String>;

	/**
		If present, it should be one or more of the supported `getaddrinfo` flags.
		If hints is not provided, then no flags are passed to `getaddrinfo`.
		Multiple flags can be passed through hints by logically ORing their values.
	**/
	@:optional var hints:Int;

	/**
		When true, the callback returns all resolved addresses in an array, otherwise returns a single address.
		Defaults to false.
	**/
	@:optional var all:Bool;

	/**
		When `verbatim`, the resolved addresses are returned unsorted.
		When `ipv4first` / `ipv6first`, addresses are sorted accordingly.
		Default is configurable via `Dns.setDefaultResultOrder`.
	**/
	@:optional var order:DnsResultOrder;

	/**
		When `true`, the callback receives IPv4 and IPv6 addresses in the order the DNS resolver returned them.
		When `false`, IPv4 addresses are placed before IPv6 addresses.

		Deprecated in favor of `order`. When both are specified, `order` has higher precedence.
	**/
	@:deprecated("Use order instead")
	@:optional var verbatim:Bool;
}

/**
	Options for `Dns.resolve4` / `Dns.resolve6`.
**/
typedef DnsResolveOptions = {
	/**
		When `true`, each record includes its TTL (in seconds).
	**/
	@:optional var ttl:Bool;
}

/**
	Options for constructing a `dns.Resolver`.
**/
typedef DnsResolverOptions = {
	/**
		Query timeout in milliseconds, or `-1` to use the default timeout.
	**/
	@:optional var timeout:Int;

	/**
		The number of tries the resolver will try contacting each name server before giving up.
		Default: `4`.
	**/
	@:optional var tries:Int;

	/**
		The max retry timeout, in milliseconds. Default: `0` (disabled).
	**/
	@:optional var maxTimeout:Int;
}

/**
	Enumeration of possible `rrtype` value for `Dns.resolve`.
**/
enum abstract DnsRrtype(String) from String to String {
	/**
		IPV4 addresses, default
	**/
	var A = "A";

	/**
		IPV6 addresses
	**/
	var AAAA = "AAAA";

	/**
		any records
	**/
	var ANY = "ANY";

	/**
		CA authorization records
	**/
	var CAA = "CAA";

	/**
		mail exchange records
	**/
	var MX = "MX";

	/**
		text records
	**/
	var TXT = "TXT";

	/**
		SRV records
	**/
	var SRV = "SRV";

	/**
		certificate associations
	**/
	var TLSA = "TLSA";

	/**
		used for reverse IP lookups
	**/
	var PTR = "PTR";

	/**
		name authority pointer records
	**/
	var NAPTR = "NAPTR";

	/**
		name server records
	**/
	var NS = "NS";

	/**
		canonical name records
	**/
	var CNAME = "CNAME";

	/**
		start of authority record
	**/
	var SOA = "SOA";
}

/**
	Types of address data returned by `resolve` functions.
**/
typedef DnsResolvedAddressMX = {priority:Int, exchange:String};

typedef DnsResolvedAddressSRV = {priority:Int, weight:Int, port:Int, name:String};
typedef DnsResolvedAddressSOA = {nsname:String, hostmaster:String, serial:Int, refresh:Int, retry:Int, expire:Int, minttl:Int};

typedef DnsResolvedAddressCAA = {
	var critical:Int;
	@:optional var issue:String;
	@:optional var issuewild:String;
	@:optional var iodef:String;
	@:optional var contactemail:String;
	@:optional var contactphone:String;
};

typedef DnsResolvedAddressNAPTR = {
	var flags:String;
	var service:String;
	var regexp:String;
	var replacement:String;
	var order:Int;
	var preference:Int;
};

typedef DnsResolvedAddressTLSA = {
	var certUsage:Int;
	var selector:Int;
	var match:Int;
	var data:ArrayBuffer;
};

/**
	Address record that includes TTL, returned by `resolve4`/`resolve6` when `ttl` is true.
**/
typedef DnsRecordWithTtl = {
	var address:String;
	var ttl:Int;
};

typedef DnsAnyARecord = {
	> DnsRecordWithTtl,
	var type:String;
};

typedef DnsAnyAaaaRecord = {
	> DnsRecordWithTtl,
	var type:String;
};

typedef DnsAnyCaaRecord = {
	> DnsResolvedAddressCAA,
	var type:String;
};

typedef DnsAnyMxRecord = {
	> DnsResolvedAddressMX,
	var type:String;
};

typedef DnsAnyNaptrRecord = {
	> DnsResolvedAddressNAPTR,
	var type:String;
};

typedef DnsAnySoaRecord = {
	> DnsResolvedAddressSOA,
	var type:String;
};

typedef DnsAnySrvRecord = {
	> DnsResolvedAddressSRV,
	var type:String;
};

typedef DnsAnyTlsaRecord = {
	> DnsResolvedAddressTLSA,
	var type:String;
};

typedef DnsAnyTxtRecord = {
	var type:String;
	var entries:Array<String>;
};

typedef DnsAnyNsRecord = {
	var type:String;
	var value:String;
};

typedef DnsAnyPtrRecord = {
	var type:String;
	var value:String;
};

typedef DnsAnyCnameRecord = {
	var type:String;
	var value:String;
};

typedef DnsAnyRecord = EitherType<DnsAnyARecord,
	EitherType<DnsAnyAaaaRecord,
		EitherType<DnsAnyCaaRecord,
			EitherType<DnsAnyCnameRecord,
				EitherType<DnsAnyMxRecord,
					EitherType<DnsAnyNaptrRecord,
						EitherType<DnsAnyNsRecord,
							EitherType<DnsAnyPtrRecord,
								EitherType<DnsAnySoaRecord,
									EitherType<DnsAnySrvRecord, EitherType<DnsAnyTlsaRecord, DnsAnyTxtRecord>>>>>>>>>>>;

typedef DnsResolvedAddress = EitherType<String,
	EitherType<Array<String>,
		EitherType<DnsResolvedAddressMX,
			EitherType<DnsResolvedAddressSOA,
				EitherType<DnsResolvedAddressSRV,
					EitherType<DnsResolvedAddressCAA, EitherType<DnsResolvedAddressNAPTR, DnsResolvedAddressTLSA>>>>>>>;

/**
	Records returned by `Dns.resolve` / `DnsPromises.resolve`, depending on `rrtype`.
	Note: `SOA` resolves to a single object (not an array); `TXT` resolves to `Array<Array<String>>`.
**/
typedef DnsResolveRecords = EitherType<Array<String>,
	EitherType<Array<DnsAnyRecord>,
		EitherType<Array<DnsResolvedAddressCAA>,
			EitherType<Array<DnsResolvedAddressMX>,
				EitherType<Array<DnsResolvedAddressNAPTR>,
					EitherType<DnsResolvedAddressSOA,
						EitherType<Array<DnsResolvedAddressSRV>,
							EitherType<Array<DnsResolvedAddressTLSA>,
								EitherType<Array<Array<String>>, Array<DnsResolvedAddress>>>>>>>>>>;

/**
	Error objects returned by dns lookups are of this type
**/
extern class DnsError extends Error {
	/**
		Values for error codes are listed in `Dns` class.
	**/
	var code(default, null):DnsErrorCode;
}

/**
	Each DNS query can return one of the following error codes
**/
@:jsRequire("dns")
extern enum abstract DnsErrorCode(String) {
	/**
		DNS server returned answer with no data.
	**/
	var NODATA;

	/**
		DNS server claims query was misformatted.
	**/
	var FORMERR;

	/**
		DNS server returned general failure.
	**/
	var SERVFAIL;

	/**
		Domain name not found.
	**/
	var NOTFOUND;

	/**
		DNS server does not implement requested operation.
	**/
	var NOTIMP;

	/**
		DNS server refused query.
	**/
	var REFUSED;

	/**
		Misformatted DNS query.
	**/
	var BADQUERY;

	/**
		Misformatted domain name.
	**/
	var BADNAME;

	/**
		Unsupported address family.
	**/
	var BADFAMILY;

	/**
		Misformatted DNS reply.
	**/
	var BADRESP;

	/**
		Could not contact DNS servers.
	**/
	var CONNREFUSED;

	/**
		Timeout while contacting DNS servers.
	**/
	var TIMEOUT;

	/**
		End of file.
	**/
	var EOF;

	/**
		Error reading file.
	**/
	var FILE;

	/**
		Out of memory.
	**/
	var NOMEM;

	/**
		Channel is being destroyed.
	**/
	var DESTRUCTION;

	/**
		Misformatted string.
	**/
	var BADSTR;

	/**
		Illegal flags specified.
	**/
	var BADFLAGS;

	/**
		Given hostname is not numeric.
	**/
	var NONAME;

	/**
		Illegal hints flags specified.
	**/
	var BADHINTS;

	/**
		c-ares library initialization not yet performed.
	**/
	var NOTINITIALIZED;

	/**
		Error loading iphlpapi.dll.
	**/
	var LOADIPHLPAPI;

	/**
		Could not find GetNetworkParams function.
	**/
	var ADDRGETNETWORKPARAMS;

	/**
		DNS query cancelled.
	**/
	var CANCELLED;
}

typedef DnsLookupCallbackSingle = (err:DnsError, address:String, family:DnsAddressFamily) -> Void;

typedef DnsLookupCallbackAll = (err:DnsError, addresses:Array<DnsLookupCallbackAllEntry>) -> Void;

typedef DnsLookupCallbackAllEntry = {
	var address:String;
	var family:DnsAddressFamily;
};

/**
	`Dns.lookup` / `DnsPromises.lookup` options with `all: true`.
**/
typedef DnsLookupAllOptions = {
	> DnsLookupOptions,
	var all:Bool;
};

typedef DnsLookupServiceCallback = (err:DnsError, hostname:String, service:String) -> Void;

typedef DnsResolveCallback<T> = (err:DnsError, records:T) -> Void;

/**
	This module contains functions that belong to two different categories:

	1) Functions that use the underlying operating system facilities to perform name resolution,
	and that do not necessarily do any network communication. This category contains only one function: `lookup`.
	Developers looking to perform name resolution in the same way that other applications on the same operating
	system behave should use `lookup`.

	2) Functions that connect to an actual DNS server to perform name resolution,
	and that always use the network to perform DNS queries. This category contains all functions in the dns module but `lookup`.
	These functions do not use the same set of configuration files than what `lookup` uses. For instance,
	they do not use the configuration from /etc/hosts. These functions should be used by developers who do not want
	to use the underlying operating system's facilities for name resolution, and instead want to always perform DNS queries.

	@see https://nodejs.org/docs/latest-v24.x/api/dns.html
**/
@:jsRequire("dns")
extern class Dns {
	/**
		Resolves a `hostname` (e.g. `'google.com'`) into the first found A (IPv4) or AAAA (IPv6) record.

		If `options` is not provided, then either IPv4 or IPv6 addresses, or both, are returned if found.

		The `family` can be `4`, `6`, or `0` (either). String forms `'IPv4'` / `'IPv6'` are also accepted.
		Defaults to `0`.

		The `callback` has arguments `(err, address, family)`.
		The `address` argument is a string representation of an IPv4 or IPv6 address.
		The `family` argument is `4` or `6` and denotes the family of `address`
		(not necessarily the value initially passed to lookup), or `0` if the address is not IPv4/IPv6.

		With the `all` option set, the arguments change to `(err, addresses)`, with addresses being an array of objects
		with the properties `address` and `family`.

		Keep in mind that `err.code` will be set to `'ENOTFOUND'` not only when the hostname does not exist but
		also when the lookup fails in other ways such as no available file descriptors.

		`lookup` doesn't necessarily have anything to do with the DNS protocol. It's only an operating system facility
		that can associate name with addresses, and vice versa.
	**/
	@:overload(function(hostname:String, options:DnsLookupAllOptions, callback:DnsLookupCallbackAll):Void {})
	@:overload(function(hostname:String, options:EitherType<DnsAddressFamily, DnsLookupOptions>,
		callback:EitherType<DnsLookupCallbackSingle, DnsLookupCallbackAll>):Void {})
	static function lookup(hostname:String, callback:DnsLookupCallbackSingle):Void;

	/**
		A flag passed in the `hints` argument of `lookup` method.

		Returned address types are determined by the types of addresses supported by the current system.
		For example, IPv4 addresses are only returned if the current system has at least one IPv4 address configured.
		Loopback addresses are not considered.
	**/
	static final ADDRCONFIG:Int;

	/**
		A flag passed in the `hints` argument of `lookup` method.

		If the IPv6 family was specified, but no IPv6 addresses were found, then return IPv4 mapped IPv6 addresses.
		Note that it is not supported on some operating systems (e.g FreeBSD 10.1).
	**/
	static final V4MAPPED:Int;

	/**
		A flag passed in the `hints` argument of `lookup` method.

		If `V4MAPPED` is specified, return resolved IPv6 addresses as well as IPv4 mapped IPv6 addresses.
	**/
	static final ALL:Int;

	/**
		Resolves the given `address` and `port` into a hostname and service using `getnameinfo`.

		The `callback` has arguments `(err, hostname, service)`.
		The `hostname` and `service` arguments are strings (e.g. `'localhost'` and `'http'` respectively).

		On error, `err` is an `Error` object, where `err.code` is the error code.
	**/
	static function lookupService(address:String, port:Int, callback:DnsLookupServiceCallback):Void;

	/**
		Resolves a `hostname` (e.g. `'google.com'`) into the record types specified by `rrtype` (default `'A'`).

		The `callback` has arguments `(err, records)`.
		The type of `records` is determined by the record type,
		and described in the documentation for the corresponding lookup methods below.
		In particular, `SOA` yields a single object and `TXT` yields `Array<Array<String>>`.

		On error, `err` is an `Error` object, where `err.code` is the error code.
	**/
	@:overload(function(hostname:String, callback:DnsResolveCallback<Array<String>>):Void {})
	static function resolve(hostname:String, rrtype:DnsRrtype, callback:DnsResolveCallback<DnsResolveRecords>):Void;

	/**
		The same as `resolve`, but only for IPv4 queries (A records).
		`addresses` is an array of IPv4 addresses (e.g. `['74.125.79.104', '74.125.79.105', '74.125.79.106']`).

		When `options.ttl` is `true`, each entry is `{ address, ttl }` instead of a string.
	**/
	@:overload(function(hostname:String, options:DnsResolveOptions,
		callback:DnsResolveCallback<EitherType<Array<String>, Array<DnsRecordWithTtl>>>):Void {})
	static function resolve4(hostname:String, callback:DnsResolveCallback<Array<String>>):Void;

	/**
		The same as `resolve4` except for IPv6 queries (an AAAA query).

		When `options.ttl` is `true`, each entry is `{ address, ttl }` instead of a string.
	**/
	@:overload(function(hostname:String, options:DnsResolveOptions,
		callback:DnsResolveCallback<EitherType<Array<String>, Array<DnsRecordWithTtl>>>):Void {})
	static function resolve6(hostname:String, callback:DnsResolveCallback<Array<String>>):Void;

	/**
		Uses the DNS protocol to resolve all records (also known as `ANY` or `*` query).

		DNS server operators may choose not to respond to `ANY` queries; prefer specific `resolve*` methods when possible.
	**/
	static function resolveAny(hostname:String, callback:DnsResolveCallback<Array<DnsAnyRecord>>):Void;

	/**
		Uses the DNS protocol to resolve `CAA` records for the `hostname`.
	**/
	static function resolveCaa(hostname:String, callback:DnsResolveCallback<Array<DnsResolvedAddressCAA>>):Void;

	/**
		The same as `resolve`, but only for mail exchange queries (MX records).
		`addresses` is an array of MX records, each with a priority
		and an exchange attribute (e.g. `[{priority: 10, exchange: 'mx.example.com'}, ...]`).
	**/
	static function resolveMx(hostname:String, callback:DnsResolveCallback<Array<DnsResolvedAddressMX>>):Void;

	/**
		Uses the DNS protocol to resolve regular expression-based records (`NAPTR` records) for the `hostname`.
	**/
	static function resolveNaptr(hostname:String, callback:DnsResolveCallback<Array<DnsResolvedAddressNAPTR>>):Void;

	/**
		The same as `resolve`, but only for text queries (TXT records).
		`addresses` is a 2-d array of the text records available for hostname (e.g., `[ ['v=spf1 ip4:0.0.0.0 ', '~all' ] ]`).
		Each sub-array contains TXT chunks of one record. Depending on the use case, these could be either joined together
		or treated separately.
	**/
	static function resolveTxt(hostname:String, callback:DnsResolveCallback<Array<Array<String>>>):Void;

	/**
		The same as `resolve`, but only for service records (SRV records).
		`addresses` is an array of the SRV records available for `hostname`.
		Properties of SRV records are priority, weight, port, and name
		(e.g., `[{priority: 10, weight: 5, port: 21223, name: 'service.example.com'}, ...]`).
	**/
	static function resolveSrv(hostname:String, callback:DnsResolveCallback<Array<DnsResolvedAddressSRV>>):Void;

	/**
		Uses the DNS protocol to resolve certificate associations (`TLSA` records) for the `hostname`.
	**/
	static function resolveTlsa(hostname:String, callback:DnsResolveCallback<Array<DnsResolvedAddressTLSA>>):Void;

	/**
		Uses the DNS protocol to resolve pointer records (PTR records) for the `hostname`.
		The addresses argument passed to the callback function will be an array of strings containing the reply records.
	**/
	static function resolvePtr(hostname:String, callback:DnsResolveCallback<Array<String>>):Void;

	/**
		The same as `resolve`, but only for start of authority record queries (SOA record).

		`addresses` is an object with the following structure:
		```
		{
		  nsname: 'ns.example.com',
		  hostmaster: 'root.example.com',
		  serial: 2013101809,
		  refresh: 10000,
		  retry: 2400,
		  expire: 604800,
		  minttl: 3600
		}
		```
	**/
	static function resolveSoa(hostname:String, callback:DnsResolveCallback<DnsResolvedAddressSOA>):Void;

	/**
		The same as `resolve`, but only for name server records (NS records).
		`addresses` is an array of the name server records available for hostname (e.g., `['ns1.example.com', 'ns2.example.com']`).
	**/
	static function resolveNs(hostname:String, callback:DnsResolveCallback<Array<String>>):Void;

	/**
		The same as `resolve`, but only for canonical name records (CNAME records).
		`addresses` is an array of the canonical name records available for hostname (e.g., `['bar.example.com']`).
	**/
	static function resolveCname(hostname:String, callback:DnsResolveCallback<Array<String>>):Void;

	/**
		Reverse resolves an `ip` address to an array of hostnames.
		The `callback` has arguments `(err, hostnames)`.
	**/
	static function reverse(ip:String, callback:DnsResolveCallback<Array<String>>):Void;

	/**
		Returns an array of IP address strings, formatted according to RFC 5952,
		that are currently configured for DNS resolution.
		A string will include a port section if a custom port is used.
	**/
	static function getServers():Array<String>;

	/**
		Sets the IP address and port of servers to be used when performing DNS resolution.
		The `servers` argument is an array of RFC 5952 formatted addresses.
		If the port is the IANA default DNS port (53) it can be omitted.

		This will throw if you pass invalid input.
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
		Promise-based DNS methods (`require('dns').promises` / `require('dns/promises')`).

		@see https://nodejs.org/docs/latest-v24.x/api/dns.html#dns-promises-api
	**/
	static final promises:DnsPromises;

	/**
		`Resolver` class constructor for an independent DNS resolver.

		@see https://nodejs.org/docs/latest-v24.x/api/dns.html#class-dnsresolver
	**/
	static final Resolver:Class<ResolverObject>;
}
