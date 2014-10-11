package js.node;

import haxe.EitherType;

import js.node.Buffer;
import js.node.tls.CleartextStream;
import js.node.tls.Server;
import js.node.tls.SecureContext;

/**
	Base structure for options object used in tls methods.
**/
typedef TlsOptions = {
	/**
		passphrase for the private key or pfx.
	**/
	@:optional var passphrase:String;

	/**
		PEM encoded CRLs (Certificate Revocation List)
	**/
	@:optional var crl:EitherType<String,Array<String>>;

	/**
		ciphers to use or exclude.

		To mitigate BEAST attacks it is recommended that you use this option in conjunction with the `honorCipherOrder`
		option described below to prioritize the non-CBC cipher.

		Defaults to AES128-GCM-SHA256:RC4:HIGH:!MD5:!aNULL:!EDH.

		Consult the OpenSSL cipher list format documentation for details on the format.
		ECDH (Elliptic Curve Diffie-Hellman) ciphers are not yet supported.
	**/
	@:optional var ciphers:String;

	/**
		Abort the connection if the SSL/TLS handshake does not finish in this many milliseconds.
		The default is 120 seconds.
		A 'clientError' is emitted on the tls.Server object whenever a handshake times out.
	**/
	@:optional var handshakeTimeout:Int;

	/**
		When choosing a cipher, use the server's preferences instead of the client preferences.

		Note that if SSLv2 is used, the server will send its list of preferences to the client,
		and the client chooses the cipher.

		Although, this option is disabled by default, it is recommended that you use this option
		in conjunction with the `ciphers` option to mitigate BEAST attacks.
	**/
	@:optional var honorCipherOrder:Bool;

	/**
		If true the server will request a certificate from clients that connect
		and attempt to verify that certificate.
		Default: false.
	**/
	@:optional var requestCert:Bool;

	/**
		If true the server will reject any connection which is not authorized with the list of supplied CAs.
		This option only has an effect if `requestCert` is true.
		Default: false.
	**/
	@:optional var rejectUnauthorized:Bool;

	/**
		possible NPN protocols. (Protocols should be ordered by their priority).
	**/
	@:optional var NPNProtocols:EitherType<Array<Dynamic>,Buffer>;

	/**
		A function that will be called if client supports SNI TLS extension.
		Only one argument will be passed to it: `servername`.
		And SNICallback should return SecureContext instance. (You can use crypto.createCredentials(...).context
		to get proper SecureContext).
		If SNICallback wasn't provided - default callback with high-level API will be used.
	**/
	@:optional var SNICallback:String->SecureContext;

	/**
		opaque identifier for session resumption.
		If `requestCert` is true, the default is MD5 hash value generated from command-line.
		Otherwise, the default is not provided.
	**/
	@:optional var sessionIdContext:String;

	/**
		The SSL method to use, e.g. SSLv3_method to force SSL version 3.
		The possible values depend on your installation of OpenSSL and are defined in the constant SSL_METHODS.
		TODO: make an abstract enum for that
	**/
	@:optional var secureProtocol:String;
}

/**
	Structure to use to configure pfx
**/
typedef TlsOptionsPfx = {
	>TlsOptions,

	/**
		private key, certificate and CA certs of the server in PFX or PKCS12 format.
	**/
	var pfx:EitherType<String,Buffer>;
}

/**
	Structure to use to configure PEM
**/
typedef TlsOptionsPem = {
	>TlsOptions,

	/**
		private key of the server in PEM format.
	**/
	var key:EitherType<String,Buffer>;

	/**
		certificate key of the server in PEM format.
	**/
	var cert:EitherType<String,Buffer>;

	/**
		trusted certificates in PEM format.
		If this is omitted several well known "root" CAs will be used, like VeriSign.
		These are used to authorize connections.
	**/
	@:optional var ca:Array<EitherType<String,Buffer>>;
}


/**
	The tls module uses OpenSSL to provide Transport Layer Security
	and/or Secure Socket Layer: encrypted stream communication.
**/
@:jsRequire("tls")
extern class Tls {

	/**
		renegotiation limit, default is 3.
	**/
	static var CLIENT_RENEG_LIMIT:Int;

	/**
		renegotiation window in seconds, default is 10 minutes.
	**/
	static var CLIENT_RENEG_WINDOW:Int;

	/**
		Size of slab buffer used by all tls servers and clients. Default: 10 * 1024 * 1024.

		Don't change the defaults unless you know what you are doing.
	**/
	static var SLAB_BUFFER_SIZE :Int;

	/**
		Returns an array with the names of the supported SSL ciphers.
	**/
	static function getCiphers():Array<String>;

	/**
		Creates a new `Server`.
		The `connectionListener` argument is automatically set as a listener for the 'secureConnection' event.
	**/
	static function createServer(options:EitherType<TlsOptionsPem,TlsOptionsPfx>, ?secureConnectionListener:CleartextStream->Void):Server;

	static var connect				: Dynamic;//		(port, [host], [options], [callback])
	static var createSecurePair		: Dynamic;//		([credentials], [isServer], [requestCert], [rejectUnauthorized])

}