/*
 * Copyright (C)2014-2015 Haxe Foundation
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

/**
	Enumeration of possible `family` values for `Dns.lookup`.
**/
@:enum abstract DnsAddressFamily(Int) from Int to Int {
	var IPv4 = 4;
	var IPv6 = 6;
}

/**
	Enumeration of possible `rrtype` value for `Dns.resolve`.
**/
@:enum abstract DnsRrtype(String) from String to String {
	/**
		IPV4 addresses, default
	**/
	var A = "A";

	/**
		IPV6 addresses
	**/
	var AAAA = "AAAA";

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
		used for reverse IP lookups
	**/
	var PTR = "PTR";

	/**
		name server records
	**/
	var NS = "NS";

	/**
		canonical name records
	**/
	var CNAME = "CNAME";
}

/**
	Types of address data returned by `resolve` functions.
**/
typedef DnsResolvedAddressMX = {priority:Int, exchange:String};
typedef DnsResolvedAddressSRV = {priority:Int, weight:Int, port:Int, name:String};
typedef DnsResolvedAddress = haxe.extern.EitherType<String,haxe.extern.EitherType<DnsResolvedAddressMX,DnsResolvedAddressSRV>>;

/**
	Error objects returned by dns lookups are of this type
**/
extern class DnsError extends Error {
	/**
		Values for error codes are listed in `Dns` class.
	**/
	var code(default,null):DnsErrorCode;
}


/**
	Each DNS query can return one of the following error codes
**/
@:fakeEnum(String)
@:jsRequire("dns")
extern enum DnsErrorCode {
	/**
		DNS server returned answer with no data.
	**/
	NODATA;

	/**
		DNS server claims query was misformatted.
	**/
	FORMERR;

	/**
		DNS server returned general failure.
	**/
	SERVFAIL;

	/**
		Domain name not found.
	**/
	NOTFOUND;

	/**
		DNS server does not implement requested operation.
	**/
	NOTIMP;

	/**
		DNS server refused query.
	**/
	REFUSED;

	/**
		Misformatted DNS query.
	**/
	BADQUERY;

	/**
		Misformatted domain name.
	**/
	BADNAME;

	/**
		Unsupported address family.
	**/
	BADFAMILY;

	/**
		Misformatted DNS reply.
	**/
	BADRESP;

	/**
		Could not contact DNS servers.
	**/
	CONNREFUSED;

	/**
		Timeout while contacting DNS servers.
	**/
	TIMEOUT;

	/**
		End of file.
	**/
	EOF;

	/**
		Error reading file.
	**/
	FILE;

	/**
		Out of memory.
	**/
	NOMEM;

	/**
		Channel is being destroyed.
	**/
	DESTRUCTION;

	/**
		Misformatted string.
	**/
	BADSTR;

	/**
		Illegal flags specified.
	**/
	BADFLAGS;

	/**
		Given hostname is not numeric.
	**/
	NONAME;

	/**
		Illegal hints flags specified.
	**/
	BADHINTS;

	/**
		c-ares library initialization not yet performed.
	**/
	NOTINITIALIZED;

	/**
		Error loading iphlpapi.dll.
	**/
	LOADIPHLPAPI;

	/**
		Could not find GetNetworkParams function.
	**/
	ADDRGETNETWORKPARAMS;

	/**
		DNS query cancelled.
	**/
	CANCELLED;
}


/**
	All methods in the dns module use C-Ares except for `lookup` which uses getaddrinfo(3) in a thread pool.
	C-Ares is much faster than getaddrinfo but the system resolver is more consistent with how other programs operate.
	When a user does `Net.connect(80, 'google.com')` or `Http.get({ host: 'google.com' })` the `lookup` method is used.
	Users who need to do a large number of lookups quickly should use the methods that go through C-Ares.
**/
@:jsRequire("dns")
extern class Dns {

	/**
		Resolves a `domain` (e.g. 'google.com') into the first found A (IPv4) or AAAA (IPv6) record.
		The `family` can be the integer 4 or 6. Defaults to null that indicates both Ip v4 and v6 address family.

		The `callback` has arguments (err, address, family).
		The `address` argument is a string representation of a IP v4 or v6 address.
		The `family` argument is either the integer 4 or 6 and denotes the family
		of address (not necessarily the value initially passed to lookup).

		Keep in mind that `err.code` will be set to 'ENOENT' not only when the domain does not exist but
		also when the lookup fails in other ways such as no available file descriptors.
	**/
	@:overload(function(domain:String, callback:DnsError->String->DnsAddressFamily->Void):Void {})
	static function lookup(domain:String, family:Null<DnsAddressFamily>, callback:DnsError->String->DnsAddressFamily->Void):Void;

	/**
		Resolves a `domain` (e.g. 'google.com') into an array of the record types specified by `rrtype`.

		The `callback` has arguments (err, addresses).
		The type of each item in `addresses` is determined by the record type,
		and described in the documentation for the corresponding lookup methods below.
	**/
	@:overload(function(domain:String, callback:DnsError->Array<DnsResolvedAddress>->Void):Void {})
	static function resolve(domain:String, rrtype:DnsRrtype, callback:DnsError->Array<DnsResolvedAddress>->Void):Void;

	/**
		The same as `resolve`, but only for IPv4 queries (A records).
		`addresses` is an array of IPv4 addresses (e.g. ['74.125.79.104', '74.125.79.105', '74.125.79.106']).
	**/
	static function resolve4(domain:String, callback:DnsError->Array<String>->Void):Void;

	/**
		The same as `resolve4` except for IPv6 queries (an AAAA query).
	**/
	static function resolve6(domain:String, callback:DnsError->Array<String>->Void):Void;

	/**
		The same as `resolve`, but only for mail exchange queries (MX records).
		`addresses` is an array of MX records, each with a priority
		and an exchange attribute (e.g. [{'priority': 10, 'exchange': 'mx.example.com'},...]).
	**/
	static function resolveMx(domain:String, callback:DnsError->Array<DnsResolvedAddressMX>->Void):Void;

	/**
		The same as `resolve`, but only for text queries (TXT records).
		`addresses` is an array of the text records available for `domain` (e.g., ['v=spf1 ip4:0.0.0.0 ~all']).
	**/
	static function resolveTxt(domain:String, callback:DnsError->Array<String>->Void):Void;

	/**
		The same as `resolve`, but only for service records (SRV records).
		`addresses` is an array of the SRV records available for `domain`.
		Properties of SRV records are priority, weight, port, and name
		(e.g., [{'priority': 10, 'weight': 5, 'port': 21223, 'name': 'service.example.com'}, ...]).
	**/
	static function resolveSrv(domain:String, callback:DnsError->Array<DnsResolvedAddressSRV>->Void):Void;

	/**
		The same as `resolve`, but only for name server records (NS records).
		`addresses` is an array of the name server records available for domain (e.g., ['ns1.example.com', 'ns2.example.com']).
	**/
	static function resolveNs(domain:String, callback:DnsError->Array<String>->Void):Void;

	/**
		The same as `resolve`, but only for canonical name records (CNAME records).
		`addresses` is an array of the canonical name records available for domain (e.g., ['bar.example.com']).
	**/
	static function resolveCname(domain:String, callback:DnsError->Array<String>->Void):Void;

	/**
		Reverse resolves an `ip` address to an array of domain names.
		The `callback` has arguments (err, domains).
	**/
	static function reverse(ip:String, callback:DnsError->Array<String>->Void):Void;
}
