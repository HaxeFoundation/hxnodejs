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
import js.lib.Error;
import js.node.Buffer;
import js.node.Tls.TlsCreateServerOptions;
import js.node.events.EventEmitter.Event;
import js.node.tls.SecureContext;
import js.node.tls.SecureContext.SecureContextOptions;
import js.node.tls.TLSSocket;

/**
	Events emitted by `tls.Server` in addition to its parent `net.Server` events.
**/
enum abstract ServerEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted after a new connection has successfully completed the handshake.
	**/
	var SecureConnection:ServerEvent<(socket:TLSSocket) -> Void> = "secureConnection";

	/**
		Emitted when a client connection reports an error before the secure connection is established.

		Listener arguments:
			`exception` - error object
			`tlsSocket` - the `TLSSocket` the error originated from
	**/
	var TlsClientError:ServerEvent<(exception:Error, tlsSocket:TLSSocket) -> Void> = "tlsClientError";

	/**
		Legacy spelling of the `'tlsClientError'` event.

		@see https://nodejs.org/api/tls.html#event-tlsclienterror
	**/
	@:deprecated("Use ServerEvent.TlsClientError / 'tlsClientError' instead")
	var ClientError:ServerEvent<(exception:Error, tlsSocket:TLSSocket) -> Void> = "clientError";

	/**
		Emitted when key material is generated or received from a client for generating TLS session tickets.
	**/
	var Keylog:ServerEvent<(line:Buffer, tlsSocket:TLSSocket) -> Void> = "keylog";

	/**
		Emitted when a new TLS session is created.
		May be used to store sessions in external storage.

		`callback` must eventually be invoked, otherwise data will not be sent or received.

		Listener arguments:
			`sessionId`
			`sessionData`
			`callback`
	**/
	var NewSession:ServerEvent<(sessionId:Buffer, sessionData:Buffer, callback:() -> Void) -> Void> = "newSession";

	/**
		Emitted when a client wants to resume a previous TLS session.

		Look up `sessionId` in external storage and invoke `callback(null, sessionData)`.
		If the session cannot be resumed, call `callback(null, null)`.
		Calling `callback(err)` terminates the incoming connection.

		Listener arguments:
			`sessionId`
			`callback`
	**/
	var ResumeSession:ServerEvent<(sessionId:Buffer, callback:(Null<Error>, Null<Buffer>) -> Void) -> Void> = "resumeSession";

	/**
		Emitted when the client sends a certificate status request.

		Parse the server certificate to obtain an OCSP URL/id, then invoke `callback(null, resp)`
		with an OCSP response `Buffer`, or `callback(null, null)` for no response.
		Calling `callback(err)` destroys the socket with that error.

		`certificate` and `issuer` are DER-encoded buffers for the leaf and issuer certificates.
	**/
	var OCSPRequest:ServerEvent<(certificate:Buffer, issuer:Buffer, callback:(Null<Error>, Null<Buffer>) -> Void) -> Void> = "OCSPRequest";
}

/**
	A `net.Server` subclass that accepts TLS/SSL connections instead of raw TCP.

	@see https://nodejs.org/api/tls.html#class-tlsserver
**/
@:jsRequire("tls", "Server")
extern class Server extends js.node.net.Server {
	/**
		Returns a 48-byte `Buffer` of the keys currently used for TLS session ticket encryption.
	**/
	function getTicketKeys():Buffer;

	/**
		Updates the keys used for encryption/decryption of TLS session tickets.

		`keys` must be 48 bytes. See the server `ticketKeys` option.
		Only future connections use the new keys; existing connections keep the previous keys.
	**/
	function setTicketKeys(keys:Buffer):Void;

	/**
		Adds a secure context used when the client's SNI hostname matches `hostname` (wildcards allowed).
		When multiple contexts match, the most recently added is used.
	**/
	function addContext(hostname:String, context:EitherType<SecureContext, SecureContextOptions>):Void;

	/**
		Replaces the secure context of an existing server.
		Existing connections are not interrupted.
	**/
	function setSecureContext(options:SecureContextOptions):Void;

	/**
		Removed in Node.js 24 (DEP0122). Pass options to `Tls.createServer` instead.
	**/
	@:deprecated("Removed in Node.js 24 (DEP0122). Pass options to Tls.createServer instead")
	function setOptions(options:TlsCreateServerOptions):Void;
}
