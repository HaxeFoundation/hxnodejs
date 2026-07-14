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

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.lib.ArrayBufferView;
import js.lib.Error;
import js.node.Buffer;
import js.node.Dns.DnsLookupCallbackSingle;
import js.node.Dns.DnsLookupOptions;
import js.node.stream.Duplex.IDuplex;
import js.node.tls.SecureContext;
import js.node.tls.SecureContext.SecureContextOptions;
import js.node.tls.SecureContext.SecureContextPemArray;
import js.node.tls.SecurePair;
import js.node.tls.Server;
import js.node.tls.TLSSocket;

/**
	ALPN protocol list accepted by several TLS option bags.

	Array forms include homogeneous `Array<String>` / `Array<Buffer>` for Haxe 4.0.5.
**/
typedef TlsAlpnProtocols = EitherType<SecureContextPemArray, EitherType<Buffer, ArrayBufferView>>;

/**
	Shared TLS option fields for clients and servers.
**/
typedef TlsOptionsBase = {
	/**
		If true the server will reject any connection which is not authorized with the list of supplied CAs.
		This option only has an effect if `requestCert` is true.
		Default: `true` for servers, typical client default is also `true`.
	**/
	@:optional var rejectUnauthorized:Bool;

	/**
		Possible NPN protocols ordered by priority.

		NPN support was removed from Node.js; use `ALPNProtocols` instead.
	**/
	@:deprecated("Use ALPNProtocols instead")
	@:optional var NPNProtocols:EitherType<Array<String>, Buffer>;

	/**
		An array of strings or a Buffer / TypedArray / DataView naming possible ALPN protocols
		(ordered by preference).
	**/
	@:optional var ALPNProtocols:TlsAlpnProtocols;
}

typedef TlsServerOptionsBase = {
	> TlsOptionsBase,

	/**
		If true the server will request a certificate from clients that connect
		and attempt to verify that certificate.
		Default: false.
	**/
	@:optional var requestCert:Bool;

	/**
		Called if the client supports the SNI TLS extension.
		Invoke `cb(null, ctx)` with a `SecureContext` from `Tls.createSecureContext`,
		or omit `ctx` to use the server's default secure context.
	**/
	@:optional var SNICallback:(servername:String, cb:(Null<Error>, SecureContext) -> Void) -> Void;
}

/**
	Client PSK negotiation result for `TlsConnectOptions.pskCallback`.
**/
typedef TlsPskCallbackNegotiation = {
	var psk:EitherType<Buffer, ArrayBufferView>;
	var identity:String;
}

typedef TlsClientOptionsBase = {
	> TlsOptionsBase,

	/**
		A Buffer containing a TLS session (for session resumption).
	**/
	@:optional var session:Buffer;

	/**
		If true, the OCSP status request extension is added to ClientHello,
		and an `OCSPResponse` event is emitted on the socket before establishing secure communication.
	**/
	@:optional var requestOCSP:Bool;
}

/**
	Options for `Tls.createServer`.

	@see https://nodejs.org/api/tls.html#tlscreateserveroptions-secureconnectionlistener
**/
typedef TlsCreateServerOptions = {
	> TlsServerOptionsBase,
	> SecureContextOptions,

	/**
		Abort the connection if the SSL/TLS handshake does not finish in this many milliseconds.
		Default: 120000 (120 seconds).
		A `'tlsClientError'` is emitted on the `tls.Server` whenever a handshake times out.
	**/
	@:optional var handshakeTimeout:Int;

	/**
		Seconds after which TLS session identifiers and session tickets created by the server time out.
		Default: 300. See Session Resumption.
	**/
	@:optional var sessionTimeout:Int;

	/**
		A 48-byte `Buffer` used to encrypt/decrypt TLS session tickets across instances.
		Automatically shared between `cluster` module workers.
	**/
	@:optional var ticketKeys:Buffer;

	/**
		If true, `TLSSocket.enableTrace()` is called on new connections.
	**/
	@:optional var enableTrace:Bool;

	/**
		Optional TLS context; creating a secure context via identity options
		(`pfx`, `key`/`cert`, or `pskCallback`) is usual for servers.
	**/
	@:optional var secureContext:SecureContext;

	/**
		Called when a client opens a connection using the ALPN extension.
		Return one of the client's protocols, or `undefined` / `null` to reject.
		Cannot be combined with `ALPNProtocols`.
	**/
	@:optional var ALPNCallback:(arg:{servername:String, protocols:Array<String>}) -> Null<String>;

	/**
		TLS-PSK callback. Given the client identity, return a PSK buffer compatible with the
		selected cipher, or `null` to stop negotiation.
	**/
	@:optional var pskCallback:(socket:TLSSocket, identity:String) -> Null<EitherType<Buffer, ArrayBufferView>>;

	/**
		Optional hint sent to the client to help select a PSK identity (ignored in TLS 1.3).
	**/
	@:optional var pskIdentityHint:String;
}

/**
	Options for `Tls.connect`.

	@see https://nodejs.org/api/tls.html#tlsconnectoptions-callback
**/
typedef TlsConnectOptions = {
	> TlsClientOptionsBase,
	> SecureContextOptions,

	/**
		Host the client should connect to. Defaults to `'localhost'`.
	**/
	@:optional var host:String;

	/**
		Port the client should connect to.
	**/
	@:optional var port:Int;

	/**
		Establish a secure connection on a given socket rather than creating a new one.
		Typically a `net.Socket`, but any Duplex stream is allowed.
		When set, `host` / `port` / `path` are ignored except for certificate validation.
	**/
	@:optional var socket:EitherType<js.node.net.Socket, IDuplex>;

	/**
		Creates a unix socket connection to `path`.
		When set, `host` and `port` are ignored.
	**/
	@:optional var path:String;

	/**
		Server name for the SNI TLS extension (must be a host name, not an IP).
		Required to enable SNI; `Tls.connect` does not set it from `host` automatically.
	**/
	@:optional var servername:String;

	/**
		Override for checking the server hostname against the certificate.
		Return an `Error` if verification fails, or `undefined` / `null` if passing.
	**/
	@:optional var checkServerIdentity:(servername:String, cert:PeerCertificate) -> Null<Error>;

	/**
		Optional TLS context from `Tls.createSecureContext`.
		If omitted, one is created from the remaining options.
	**/
	@:optional var secureContext:SecureContext;

	/**
		If true, `TLSSocket.enableTrace()` is called on the socket.
	**/
	@:optional var enableTrace:Bool;

	/**
		If set to `false`, the socket automatically ends the writable side when the readable side ends.
		Has no effect when `socket` is set. See `net.Socket` `allowHalfOpen`.
		Default: false.
	**/
	@:optional var allowHalfOpen:Bool;

	/**
		Minimum size of the DH parameter in bits to accept for DHE ciphers.
		Default: 1024.
	**/
	@:optional var minDHSize:Int;

	/**
		High water mark for the underlying readable stream.
		Default: 16 * 1024.
	**/
	@:optional var highWaterMark:Int;

	/**
		Socket timeout in milliseconds.
	**/
	@:optional var timeout:Int;

	/**
		Custom DNS lookup function (same shape as `net.Socket` `lookup` option).
	**/
	@:optional var lookup:(hostname:String, options:DnsLookupOptions, callback:DnsLookupCallbackSingle) -> Void;

	/**
		TLS-PSK callback. Given an optional server `hint` (`null` for TLS 1.3),
		return `{ psk, identity }` or `null` to stop negotiation.
	**/
	@:optional var pskCallback:(hint:Null<String>) -> Null<TlsPskCallbackNegotiation>;
}

/**
	Certificate object returned by `TLSSocket.getPeerCertificate` / `getCertificate`.

	@see https://nodejs.org/api/tls.html#certificate-object
**/
typedef PeerCertificate = {
	/**
		`true` if this is a Certificate Authority certificate.
	**/
	@:optional var ca:Bool;

	@:optional var subject:CertificateSubject;
	@:optional var issuer:CertificateSubject;
	@:optional var subjectaltname:String;
	@:optional var infoAccess:DynamicAccess<Array<String>>;
	@:optional var modulus:String;
	@:optional var exponent:String;
	@:optional var valid_from:String;
	@:optional var valid_to:String;
	@:optional var fingerprint:String;
	@:optional var fingerprint256:String;
	@:optional var fingerprint512:String;
	@:optional var serialNumber:String;
	@:optional var raw:Buffer;

	/**
		Extended key usage OIDs.
	**/
	@:optional var ext_key_usage:Array<String>;

	/**
		RSA or EC key size in bits.
	**/
	@:optional var bits:Int;

	/**
		Public key bytes.
	**/
	@:optional var pubkey:Buffer;

	/**
		ASN.1 name of the elliptic curve OID (EC keys).
	**/
	@:optional var asn1Curve:String;

	/**
		NIST name for the elliptic curve when assigned (EC keys).
	**/
	@:optional var nistCurve:String;

	/**
		Present when `detailed` is true. May be a circular reference for self-signed certs.
	**/
	@:optional var issuerCertificate:PeerCertificate;
}

/**
	Detailed peer certificate (full chain). Same shape as `PeerCertificate`
	with `issuerCertificate` populated when requested via `getPeerCertificate(true)`.
**/
typedef DetailedPeerCertificate = PeerCertificate;

/**
	Subject / issuer Name fields. Individual RDN values may be a string or string array.
**/
typedef CertificateSubject = {
	@:optional var C:EitherType<String, Array<String>>;
	@:optional var ST:EitherType<String, Array<String>>;
	@:optional var L:EitherType<String, Array<String>>;
	@:optional var O:EitherType<String, Array<String>>;
	@:optional var OU:EitherType<String, Array<String>>;
	@:optional var CN:EitherType<String, Array<String>>;
}

/**
	The `node:tls` module provides Transport Layer Security and Secure Socket Layer
	encrypted stream communication built on OpenSSL.

	@see https://nodejs.org/api/tls.html
**/
@:jsRequire("tls")
extern class Tls {
	/**
		Maximum number of renegotiation requests. Default: `3`.
	**/
	static var CLIENT_RENEG_LIMIT:Int;

	/**
		Renegotiation window in seconds. Default: `600` (10 minutes).
	**/
	static var CLIENT_RENEG_WINDOW:Int;

	/**
		Default value of the `ciphers` option of `Tls.createSecureContext`.
		Assignable to any supported OpenSSL cipher list string.
	**/
	static var DEFAULT_CIPHERS:String;

	/**
		Default named curve for ECDH key agreement in a TLS server.
		Default value is `'auto'`.
	**/
	static var DEFAULT_ECDH_CURVE:String;

	/**
		Default value of the `maxVersion` option of `Tls.createSecureContext`.
		One of `'TLSv1.3'`, `'TLSv1.2'`, `'TLSv1.1'`, or `'TLSv1'`.
	**/
	static var DEFAULT_MAX_VERSION:String;

	/**
		Default value of the `minVersion` option of `Tls.createSecureContext`.
		One of `'TLSv1.3'`, `'TLSv1.2'`, `'TLSv1.1'`, or `'TLSv1'`.
	**/
	static var DEFAULT_MIN_VERSION:String;

	/**
		Immutable array of PEM root certificates from the bundled Mozilla CA store
		shipped with the current Node.js version.
	**/
	static var rootCertificates(default, null):Array<String>;

	/**
		Size of the slab buffer used by all TLS servers and clients.
		Default: `10 * 1024 * 1024`.
	**/
	static var SLAB_BUFFER_SIZE:Int;

	/**
		Returns CA certificates from various sources depending on `type`.

		Valid values: `'default'`, `'system'`, `'bundled'`, `'extra'`. Default: `'default'`.

		@see https://nodejs.org/api/tls.html#tlsgetcacertificatestype
	**/
	static function getCACertificates(?type:String):Array<String>;

	/**
		Sets the default CA certificates used by Node.js TLS clients.
		Successfully parsed certificates become the default list returned by
		`getCACertificates()` and used by subsequent TLS connections that omit their own CAs.

		@see https://nodejs.org/api/tls.html#tlssetdefaultcacertificatescerts
	**/
	static function setDefaultCACertificates(certs:Array<EitherType<String, EitherType<Buffer, ArrayBufferView>>>):Void;

	/**
		Returns the names of the supported TLS ciphers (historically lower-cased;
		uppercase them when passing to the `ciphers` option).
	**/
	static function getCiphers():Array<String>;

	/**
		Verifies that `cert` was issued to `hostname`.
		Returns an `Error` on failure, or `undefined` / `null` on success.
	**/
	static function checkServerIdentity(hostname:String, cert:PeerCertificate):Null<Error>;

	/**
		Converts the given ALPN protocols list into the wire format expected by OpenSSL.

		@see https://nodejs.org/api/tls.html#tlsconvertalpnprotocolsprotocols-out
	**/
	static function convertALPNProtocols(protocols:TlsAlpnProtocols, out:{}):Void;

	/**
		Creates a new `tls.Server`.
		`secureConnectionListener` is automatically added for the `'secureConnection'` event.
	**/
	@:overload(function(?secureConnectionListener:TLSSocket->Void):Server {})
	static function createServer(options:TlsCreateServerOptions, ?secureConnectionListener:TLSSocket->Void):Server;

	/**
		Creates a client connection to `options.port` / `options.host`, or to the given `port` / `host` / `path`.
		If `host` is omitted it defaults to `'localhost'`.
	**/
	@:overload(function(port:Int, ?callback:Void->Void):TLSSocket {})
	@:overload(function(port:Int, options:TlsConnectOptions, ?callback:Void->Void):TLSSocket {})
	@:overload(function(port:Int, host:String, ?callback:Void->Void):TLSSocket {})
	@:overload(function(port:Int, host:String, options:TlsConnectOptions, ?callback:Void->Void):TLSSocket {})
	@:overload(function(path:String, ?options:TlsConnectOptions, ?callback:Void->Void):TLSSocket {})
	static function connect(options:TlsConnectOptions, ?callback:Void->Void):TLSSocket;

	/**
		Creates a `SecureContext` usable with several TLS APIs.
		Has no public methods.
	**/
	static function createSecureContext(?details:SecureContextOptions):SecureContext;

	/**
		Creates a secure pair with encrypted and cleartext streams.

		Removed in Node.js 24 (DEP0064). Use `tls.TLSSocket` instead.
	**/
	@:deprecated("Removed in Node.js 24 (DEP0064). Use TLSSocket instead")
	static function createSecurePair(?context:SecureContext, ?isServer:Bool, ?requestCert:Bool, ?rejectUnauthorized:Bool):SecurePair;
}
