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

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import js.lib.Error;
import js.node.Buffer;
import js.node.Tls.DetailedPeerCertificate;
import js.node.Tls.PeerCertificate;
import js.node.Tls.TlsClientOptionsBase;
import js.node.Tls.TlsServerOptionsBase;
import js.node.crypto.X509Certificate;
import js.node.events.EventEmitter.Event;
import js.node.stream.Duplex.IDuplex;
import js.node.tls.SecureContext.SecureContextOptions;

/**
	Events emitted by `TLSSocket` in addition to its parent `net.Socket` events.
**/
enum abstract TLSSocketEvent<T:Function>(Event<T>) to Event<T> {
	/**
		Emitted when the handshaking process for a new connection has successfully completed.
		The listener runs whether or not the server certificate was authorized.

		Check `authorized` to see if the peer certificate was signed by a configured CA.
		If `authorized` is false, see `authorizationError`. When ALPN was used, see `alpnProtocol`.
	**/
	var SecureConnect:TLSSocketEvent<() -> Void> = "secureConnect";

	/**
		Emitted when the session has been established (server-side companion of `'secureConnect'`).
	**/
	var Secure:TLSSocketEvent<() -> Void> = "secure";

	/**
		Emitted if the `requestOCSP` option was set.

		`response` is a `Buffer` containing the server's OCSP response.
	**/
	var OCSPResponse:TLSSocketEvent<(response:Buffer) -> Void> = "OCSPResponse";

	/**
		Emitted when key material is generated or received for generating a TLS session ticket.
	**/
	var Keylog:TLSSocketEvent<(line:Buffer) -> Void> = "keylog";

	/**
		Emitted on session establishment or update with the TLS session `Buffer`.
	**/
	var Session:TLSSocketEvent<(session:Null<Buffer>) -> Void> = "session";
}

/**
	Options for constructing a `TLSSocket`.
**/
typedef TLSSocketOptions = {
	> TlsServerOptionsBase,
	> TlsClientOptionsBase,
	> SecureContextOptions,

	/**
		Optional TLS context from `Tls.createSecureContext`.
		If omitted, one is created from the remaining options.
	**/
	@:optional var secureContext:SecureContext;

	/**
		If true, the TLS socket is instantiated in server mode.

		Default: false.
	**/
	@:optional var isServer:Bool;

	/**
		Optional `net.Server` instance.
	**/
	@:optional var server:js.node.net.Server;

	/**
		If true, TLS packet trace information is written to `stderr`.

		Default: false.
	**/
	@:optional var enableTrace:Bool;
}

/**
	A duplex stream that performs transparent TLS encryption of written data
	and the required TLS negotiation.

	Its `encrypted` property is always `true`.

	@see https://nodejs.org/api/tls.html#class-tlstlssocket
**/
@:jsRequire("tls", "TLSSocket")
extern class TLSSocket extends js.node.net.Socket {
	/**
		Construct a new `TLSSocket` from an existing duplex stream (typically a `net.Socket`).
	**/
	function new(socket:IDuplex, ?options:TLSSocketOptions);

	/**
		`true` if the peer certificate was signed by one of the specified CAs, otherwise `false`.
	**/
	var authorized(default, null):Bool;

	/**
		The reason why the peer's certificate has not been verified.
		Set only when `authorized` is `false`.
	**/
	var authorizationError(default, null):Null<Error>;

	/**
		Server name requested via the SNI TLS extension, when available.
	**/
	var servername(default, null):Null<EitherType<String, Bool>>;

	/**
		Negotiated protocol name via NPN.

		NPN was superseded by ALPN; use `alpnProtocol` instead.
	**/
	@:deprecated("Use alpnProtocol instead")
	var npnProtocol(default, null):String;

	/**
		The selected ALPN protocol.
		`null` before the handshake completes; `false` if ALPN was not negotiated / disabled;
		otherwise the protocol string (may be empty if none was selected).
	**/
	var alpnProtocol(default, null):Null<EitherType<String, Bool>>;

	/**
		Returns an object representing the peer's certificate.

		If `detailed` is true, the full chain is returned via `issuerCertificate`.
		If the peer provides no certificate, an empty object is returned.
		If the socket has been destroyed, `null` is returned.
	**/
	@:overload(function(detailed:Bool):Null<DetailedPeerCertificate> {})
	function getPeerCertificate(?detailed:Bool):Null<PeerCertificate>;

	/**
		Returns the local certificate as an object, or an empty object / `null` if none.
	**/
	function getCertificate():Null<PeerCertificate>;

	/**
		Returns the cipher name and TLS protocol version of the current connection.

		Example: `{ name: 'AES256-SHA', standardName: '...', version: 'TLSv1.2' }`.
	**/
	function getCipher():{name:String, standardName:String, version:String};

	/**
		Returns the type, name, and size of an ephemeral key exchange parameter
		used for Perfect Forward Secrecy on a client connection.
		Returns `null`/empty when the key exchange is not ephemeral.
	**/
	function getEphemeralKeyInfo():Null<{type:String, ?name:String, size:Int}>;

	/**
		Returns the latest `Finished` message sent to the peer as a `Buffer`, if available.
	**/
	function getFinished():Null<Buffer>;

	/**
		Returns the latest `Finished` message received from the peer as a `Buffer`, if available.
	**/
	function getPeerFinished():Null<Buffer>;

	/**
		Returns signature algorithms shared between server and client, most preferred first.
	**/
	function getSharedSigalgs():Array<String>;

	/**
		Returns `true` if the session was reused, `false` otherwise.
	**/
	function isSessionReused():Bool;

	/**
		Disables TLS renegotiation for this socket. Subsequent renegotiation attempts emit `'error'`.
	**/
	function disableRenegotiation():Void;

	/**
		Enables TLS packet trace data for debugging (written to `stderr`).
	**/
	function enableTrace():Void;

	/**
		Exports keying material for channel-binding validations.

		@see https://nodejs.org/api/tls.html#tlssocketexportkeyingmateriallength-label-context
	**/
	function exportKeyingMaterial(length:Int, label:String, ?context:Buffer):Buffer;

	/**
		Sets the socket's key and certificate (for delayed credentials or session-ticket flows).
	**/
	function setKeyCert(context:EitherType<SecureContext, SecureContextOptions>):Void;

	/**
		Returns the peer certificate as an `X509Certificate`, or `null` if none / destroyed.
	**/
	function getPeerX509Certificate():Null<X509Certificate>;

	/**
		Returns the local certificate as an `X509Certificate`, or `null` if none / destroyed.
	**/
	function getX509Certificate():Null<X509Certificate>;

	/**
		Initiates TLS renegotiation.

		`options` may include `rejectUnauthorized` and `requestCert` (see `Tls.createServer`).
		`callback` is invoked with `null` once renegotiation completes successfully.

		When running as a server, the socket may be destroyed after `handshakeTimeout`.
	**/
	function renegotiate(options:{?rejectUnauthorized:Bool, ?requestCert:Bool}, ?callback:(err:Null<Error>) -> Void):Bool;

	/**
		Sets the maximum TLS fragment size (default and max: 16384, min: 512).
		Returns `true` on success, `false` otherwise.
	**/
	function setMaxSendFragment(size:Int):Bool;

	/**
		Returns the negotiated TLS protocol version string.

		Returns `'unknown'` for connected sockets that have not finished handshaking.
		Returns `null` for server sockets or disconnected client sockets.
	**/
	function getProtocol():Null<String>;

	/**
		Returns the ASN.1 encoded TLS session, or `null` if none was negotiated.
	**/
	function getSession():Null<Buffer>;

	/**
		Returns the TLS session ticket, or `null` if none was negotiated (client sockets).
		Useful for debugging; for session reuse provide `session` to `Tls.connect`.
	**/
	function getTLSTicket():Null<Buffer>;
}
