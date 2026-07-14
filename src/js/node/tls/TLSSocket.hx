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

package js.node.tls;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import js.node.Buffer;
import js.node.Tls.TlsClientOptionsBase;
import js.node.Tls.TlsServerOptionsBase;
import js.node.events.EventEmitter.Event;
import js.node.tls.SecureContext.SecureContextOptions;
import js.lib.Error;

/**
	Enumeration of events emitted by `TLSSocket` objects in addition to its parent class events.
**/
enum abstract TLSSocketEvent<T:Function>(Event<T>) to Event<T> {
	/**
		This event is emitted after a new connection has been successfully handshaked.

		The listener will be called no matter if the server's certificate was authorized or not.

		It is up to the user to test `TLSSocket.authorized` to see if the server certificate
		was signed by one of the specified CAs. If `TLSSocket.authorized` is false then the error
		can be found in `TLSSocket.authorizationError`. Also if NPN was used - you can
		check `TLSSocket.npnProtocol` for negotiated protocol.
	**/
	var SecureConnect:TLSSocketEvent<Void->Void> = "secureConnect";

	/**
		Emitted once when the connection is established and the handshake completes (server-side companion of secureConnect).
	**/
	var Secure:TLSSocketEvent<Void->Void> = "secure";

	/**
		This event will be emitted if `requestOCSP` option was set.

		`response` is a `Buffer` object, containing server's OCSP response.

		Traditionally, the response is a signed object from the server's CA
		that contains information about server's certificate revocation status.
	**/
	var OCSPResponse:TLSSocketEvent<Buffer->Void> = "OCSPResponse";

	/**
		Emitted when key material is generated / received for the purpose of generating a TLS session ticket.
	**/
	var Keylog:TLSSocketEvent<Buffer->Void> = "keylog";

	/**
		Emitted on session establishment / update with the TLS session `Buffer`.
	**/
	var Session:TLSSocketEvent<Null<Buffer>->Void> = "session";
}

typedef TLSSocketOptions = {
	> TlsServerOptionsBase,
	> TlsClientOptionsBase,

	/**
		An optional TLS context object from `Tls.createSecureContext`
	**/
	@:optional var secureContext:SecureContext;

	/**
		If true - TLS socket will be instantiated in server-mode
	**/
	@:optional var isServer:Bool;

	@:optional var server:js.node.net.Server;
}

/**
	This is a wrapped version of `net.Socket` that does transparent encryption
	of written data and all required TLS negotiation.

	Its `encrypted` field is always true.
**/
@:jsRequire("tls", "TLSSocket")
extern class TLSSocket extends js.node.net.Socket {
	/**
		Construct a new TLSSocket object from existing TCP socket.
	**/
	function new(socket:js.node.net.Socket, options:TLSSocketOptions);

	/**
		true if the peer certificate was signed by one of the specified CAs, otherwise false
	**/
	var authorized(default, null):Bool;

	/**
		The reason why the peer's certificate has not been verified.

		This property becomes available only when `authorized` is false.
	**/
	var authorizationError(default, null):Null<String>;

	/**
		Negotiated protocol name via NPN.

		@deprecated Use `alpnProtocol` instead.
	**/
	@:deprecated("Use alpnProtocol instead")
	var npnProtocol(default, null):String;

	/**
		String containing the selected ALPN protocol. When ALPN has no selected protocol, this is
		the empty string. When ALPN has not been negotiated / disabled, this is `false`.
	**/
	var alpnProtocol(default, null):EitherType<String, Bool>;

	/**
		Returns an object representing the peer's certificate.

		The returned object has some properties corresponding to the field of the certificate.
		If `detailed` argument is true - the full chain with issuer property will be returned,
		if false - only the top certificate without issuer property.
	**/
	function getPeerCertificate(?detailed:Bool):js.node.Tls.PeerCertificate;

	/**
		Returns the local certificate as an object.
	**/
	function getCertificate():Null<js.node.Tls.PeerCertificate>;

	/**
		Returns an object representing the cipher name and the SSL/TLS protocol version of the current connection.

		Example: { name: 'AES256-SHA', version: 'TLSv1/SSLv3' }

		See SSL_CIPHER_get_name() and SSL_CIPHER_get_version() in http://www.openssl.org/docs/ssl/ssl.html#DEALING_WITH_CIPHERS for more information.
	**/
	function getCipher():{name:String, standardName:String, version:String};

	/**
		Returns an object representing the type, name, and size of parameter of an ephemeral key exchange
		in Perfect Forward Secrecy on a client connection. Returns empty object when key exchange is not ephemeral.
	**/
	function getEphemeralKeyInfo():Null<{type:String, name:String, size:Int}>;

	/**
		As the `Finished` messages are message digests of the complete handshake
		(with a total of 192 bits for TLS 1.0 and more for SSL 3.0), they can
		be used for external authentication procedures when the authentication provided by SSL/TLS is not desired or is not enough.
	**/
	function getFinished():Null<Buffer>;

	/**
		Returns the latest `Finished` message received from the peer as a `Buffer`.
	**/
	function getPeerFinished():Null<Buffer>;

	/**
		Returns a list of signature algorithms shared between the server and the client in order of decreasing preference.
	**/
	function getSharedSigalgs():Array<String>;

	/**
		Returns `true` if the session was reused, `false` otherwise.
	**/
	function isSessionReused():Bool;

	/**
		Disables TLS renegotiation for this `TLSSocket` instance.
	**/
	function disableRenegotiation():Void;

	/**
		Enables TLS trace data for debugging.
	**/
	function enableTrace():Void;

	/**
		Keying material is used for validations for secure channel integrity and confidentially.
	**/
	function exportKeyingMaterial(length:Int, label:String, ?context:Buffer):Buffer;

	/**
		See `Socket.setKeyCert` / set credentials for the socket when using tickets for session resumption or for delayed certificate availability.
	**/
	function setKeyCert(context:EitherType<SecureContext, SecureContextOptions>):Void;

	/**
		Returns the peer certificate as an `X509Certificate` object.

		// TODO(section-3): type against crypto.X509Certificate once crypto audit exposes it
	**/
	function getPeerX509Certificate():Any;

	/**
		Returns the local certificate as an `X509Certificate` object.

		// TODO(section-3): type against crypto.X509Certificate once crypto audit exposes it
	**/
	function getX509Certificate():Any;

	/**
		Initiate TLS renegotiation process.

		The `options` may contain the following fields: rejectUnauthorized, requestCert (See `Tls.createServer` for details).

		`callback(err)` will be executed with null as err, once the renegotiation is successfully completed.

		NOTE: Can be used to request peer's certificate after the secure connection has been established.
		ANOTHER NOTE: When running as the server, socket will be destroyed with an error after handshakeTimeout timeout.
	**/
	function renegotiate(options:{?rejectUnauthorized:Bool, ?requestCert:Bool}, ?callback:Error->Void):Bool;

	/**
		Set maximum TLS fragment size (default and maximum value is: 16384, minimum is: 512).

		Returns true on success, false otherwise.

		Smaller fragment size decreases buffering latency on the client: large fragments are buffered by the TLS layer
		until the entire fragment is received and its integrity is verified; large fragments can span multiple roundtrips,
		and their processing can be delayed due to packet loss or reordering. However, smaller fragments add
		extra TLS framing bytes and CPU overhead, which may decrease overall server throughput.
	**/
	function setMaxSendFragment(size:Int):Bool;

	/**
		Returns a string containing the negotiated SSL/TLS protocol version of the current connection.

		'unknown' will be returned for connected sockets that have not completed the handshaking process.
		`null` will be returned for server sockets or disconnected client sockets.
	**/
	function getProtocol():String;

	/**
		Return ASN.1 encoded TLS session or null if none was negotiated.
		Could be used to speed up handshake establishment when reconnecting to the server.
	**/
	function getSession():Null<Buffer>;

	/**
		NOTE: Works only with client TLS sockets.

		Useful only for debugging, for session reuse provide session option to tls.connect.

		Return TLS session ticket or null if none was negotiated.
	**/
	function getTLSTicket():Null<Buffer>;
}
