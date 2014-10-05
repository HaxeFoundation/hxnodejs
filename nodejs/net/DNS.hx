package nodejs.net;

/**
 * DNS Error Type enumeration.
 */
@:native("(require('dns'))")
extern class DNSErrorType
{
	/**
	 * DNS server returned answer with no data.
	 */
	static var NODATA				: Int; 
	/**
	 * DNS server claims query was misformatted.
	 */
	static var FORMERR				: Int; 
	/**
	 * DNS server returned general failure.
	 */
	static var SERVFAIL				: Int; 
	/**
	 * Domain name not found.
	 */
	static var NOTFOUND				: Int; 
	/**
	 * DNS server does not implement requested operation.
	 */
	static var NOTIMP				: Int; 
	/**
	 * DNS server refused query.
	 */
	static var REFUSED				: Int; 
	/**
	 * Misformatted DNS query.
	 */
	static var BADQUERY				: Int; 
	/**
	 * Misformatted domain name.
	 */
	static var BADNAME				: Int; 
	/**
	 * Unsupported address family.
	 */
	static var BADFAMILY			: Int; 
	/**
	 * Misformatted DNS reply.
	 */
	static var BADRESP				: Int; 
	/**
	 * Could not contact DNS servers.
	 */
	static var CONNREFUSED			: Int; 
	/**
	 * Timeout while contacting DNS servers.
	 */
	static var TIMEOUT				: Int; 
	/**
	 * End of file.
	 */
	static var EOF					: Int; 
	/**
	 * Error reading file.
	 */
	static var FILE					: Int; 
	/**
	 * Out of memory.
	 */
	static var NOMEM				: Int; 
	/**
	 * Channel is being destroyed.
	 */
	static var DESTRUCTION			: Int; 
	/**
	 * Misformatted string.
	 */
	static var BADSTR				: Int; 
	/**
	 * Illegal flags specified.
	 */
	static var BADFLAGS				: Int; 
	/**
	 * Given hostname is not numeric.
	 */
	static var NONAME				: Int; 
	/**
	 * Illegal hints flags specified.
	 */
	static var BADHINTS				: Int; 
	/**
	 * c-ares library initialization not yet performed.
	 */
	static var NOTINITIALIZED		: Int; 
	/**
	 * Error loading iphlpapi.dll.
	 */
	static var LOADIPHLPAPI			: Int; 
	/**
	 * Could not find GetNetworkParams function.
	 */
	static var ADDRGETNETWORKPARAMS	: Int; 
	/**
	 * DNS query cancelled.
	 */
	static var CANCELLED			: Int; 
	
}

/**
 * Use require('dns') to access this module. All methods in the dns module use C-Ares except for dns.lookup which uses getaddrinfo(3) in a thread pool. 
 * C-Ares is much faster than getaddrinfo but the system resolver is more consistent with how other programs operate. When a user does net.connect(80, 'google.com')
 * or http.get({ host: 'google.com' }) the dns.lookup method is used. Users who need to do a large number of lookups quickly should use the methods that go through C-Ares.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('dns'))")
extern class DNS
{
	var lookup			: Dynamic;//	(domain, [family], callback)
	var resolve			: Dynamic;//	(domain, [rrtype], callback)
	var resolve4		: Dynamic;//	(domain, callback)
	var resolve6		: Dynamic;//	(domain, callback)
	var resolveMx		: Dynamic;//	(domain, callback)
	var resolveTxt		: Dynamic;//	(domain, callback)
	var resolveSrv		: Dynamic;//	(domain, callback)
	var resolveNs		: Dynamic;//	(domain, callback)
	var resolveCname	: Dynamic;//	(domain, callback)
	var reverse			: Dynamic;//	(ip, callback)
	
	
}