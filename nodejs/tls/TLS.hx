package nodejs.tls;

/**
 * Use require('tls') to access this module.
 * The tls module uses OpenSSL to provide Transport Layer Security and/or Secure Socket Layer: encrypted stream communication.
 * TLS/SSL is a public/private key infrastructure.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("require('tls')")
extern class TLS
{
	/**
	 * Size of slab buffer used by all tls servers and clients. Default: 10 * 1024 * 1024.
	 * Don't change the defaults unless you know what you are doing.
	 */
	static var SLAB_BUFFER_SIZE  : Int;
	
	static var getCiphers			: Dynamic;//		()
	static var createServer			: Dynamic;//		(options, [secureConnectionListener])
	static var connect				: Dynamic;//		(options, [callback])
	static var connect				: Dynamic;//		(port, [host], [options], [callback])
	static var createSecurePair		: Dynamic;//		([credentials], [isServer], [requestCert], [rejectUnauthorized])
	
}