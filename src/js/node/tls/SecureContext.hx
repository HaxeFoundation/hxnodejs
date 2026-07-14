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

package js.node.tls;

import haxe.extern.EitherType;
import js.lib.ArrayBufferView;
import js.node.Buffer;

/**
	Private key entry for `SecureContextOptions.key` arrays.
**/
typedef SecureContextKeyObject = {
	var pem:EitherType<String, Buffer>;
	@:optional var passphrase:String;
}

/**
	PFX entry for `SecureContextOptions.pfx` arrays.
**/
typedef SecureContextPfxObject = {
	var buf:EitherType<String, Buffer>;
	@:optional var passphrase:String;
}

/**
	Options for `Tls.createSecureContext`.

	@see https://nodejs.org/api/tls.html#tlscreatesecurecontextoptions
**/
typedef SecureContextOptions = {
	/**
		PFX or PKCS12 encoded private key and certificate chain.
		Alternative to providing `key` and `cert` individually.
	**/
	@:optional var pfx:EitherType<EitherType<String, Buffer>, Array<EitherType<EitherType<String, Buffer>, SecureContextPfxObject>>>;

	/**
		Shared passphrase used for a single private key and/or a PFX.
	**/
	@:optional var passphrase:String;

	/**
		Private keys in PEM format. Multiple keys may be provided as an array of
		buffers/strings or `{ pem, passphrase? }` objects.
	**/
	@:optional var key:EitherType<EitherType<String, Buffer>, Array<EitherType<EitherType<String, Buffer>, SecureContextKeyObject>>>;

	/**
		Cert chains in PEM format. One cert chain should be provided per private key.
	**/
	@:optional var cert:EitherType<EitherType<String, Buffer>, Array<EitherType<String, Buffer>>>;

	/**
		Optionally override the trusted CA certificates.
		Default is the same as `Tls.getCACertificates('default')`.
	**/
	@:optional var ca:EitherType<EitherType<String, Buffer>, Array<EitherType<String, Buffer>>>;

	/**
		PEM encoded CRLs (Certificate Revocation Lists).
	**/
	@:optional var crl:EitherType<EitherType<String, Buffer>, Array<EitherType<String, Buffer>>>;

	/**
		Cipher suite specification, replacing the default.
		See modifying the default TLS cipher suite in the Node.js TLS docs.
		Permitted ciphers can be obtained via `Tls.getCiphers()`.
	**/
	@:optional var ciphers:String;

	/**
		Named curve or colon-separated list of curves for ECDH key agreement.
		Use `'auto'` to select automatically. Default: `Tls.DEFAULT_ECDH_CURVE`.
	**/
	@:optional var ecdhCurve:String;

	/**
		`'auto'` or custom Diffie-Hellman parameters for non-ECDHE perfect forward secrecy.
		If omitted or invalid, parameters are discarded and DHE ciphers are unavailable.
	**/
	@:optional var dhparam:EitherType<String, Buffer>;

	/**
		Legacy mechanism to select the TLS protocol version.
		Does not support independent min/max control or limiting to TLSv1.3 alone.
		Prefer `minVersion` / `maxVersion`.
	**/
	@:optional var secureProtocol:String;

	/**
		Opaque identifier used by servers to ensure session state is not shared between applications.
		Unused by clients.
	**/
	@:optional var sessionIdContext:String;

	/**
		Attempt to use the server's cipher suite preferences instead of the client's.
		Default: `true` when creating servers via `Tls.createServer`.
	**/
	@:optional var honorCipherOrder:Bool;

	/**
		Optionally set the minimum TLS version to allow.
		One of `'TLSv1.3'`, `'TLSv1.2'`, `'TLSv1.1'`, or `'TLSv1'`.
		Cannot be specified together with `secureProtocol`.
	**/
	@:optional var minVersion:String;

	/**
		Optionally set the maximum TLS version to allow.
		One of `'TLSv1.3'`, `'TLSv1.2'`, `'TLSv1.1'`, or `'TLSv1'`.
		Cannot be specified together with `secureProtocol`.
	**/
	@:optional var maxVersion:String;

	/**
		An array of strings, or a Buffer / TypedArray / DataView, naming possible ALPN protocols.
	**/
	@:optional var ALPNProtocols:EitherType<Array<EitherType<String, Buffer>>, EitherType<Buffer, ArrayBufferView>>;

	/**
		Name of an OpenSSL engine to get a private key from.
		Should be used together with `privateKeyIdentifier`.

		Deprecated: custom engine support is deprecated in OpenSSL 3.
	**/
	@:deprecated("OpenSSL custom engines are deprecated")
	@:optional var privateKeyEngine:String;

	/**
		Identifier of a private key managed by an OpenSSL engine.
		Should be used together with `privateKeyEngine`.

		Deprecated: custom engine support is deprecated in OpenSSL 3.
	**/
	@:deprecated("OpenSSL custom engines are deprecated")
	@:optional var privateKeyIdentifier:String;

	/**
		Name of an OpenSSL engine which can provide the client certificate.

		Deprecated: custom engine support is deprecated in OpenSSL 3.
	**/
	@:deprecated("OpenSSL custom engines are deprecated")
	@:optional var clientCertEngine:String;

	/**
		Colon-separated list of supported signature algorithms.
	**/
	@:optional var sigalgs:String;

	/**
		Treat intermediate (non-self-signed) certificates in the trust CA list as trusted.

		@since Node.js v22.9.0, v20.18.0
	**/
	@:optional var allowPartialTrustChain:Bool;

	/**
		Numeric bitmask of OpenSSL `SSL_OP_*` options.
		Affects protocol behavior; use carefully.
	**/
	@:optional var secureOptions:Int;

	/**
		48 bytes of cryptographically strong pseudo-random data used as TLS session ticket keys.
		See Session Resumption in the Node.js TLS docs.
	**/
	@:optional var ticketKeys:Buffer;

	/**
		Seconds after which a TLS session created by the server is no longer resumable.

		Default: 300.
	**/
	@:optional var sessionTimeout:Int;
}

/**
	Opaque TLS secure context.

	Created by `Tls.createSecureContext`. Has no public methods.
**/
extern class SecureContext {}
