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

package js.node.http2;

import js.node.Http2.Http2Headers;
import js.node.Http2.Http2Settings;
import js.node.events.EventEmitter.Event;
import js.node.stream.Duplex.IDuplex;
import js.lib.Error;

/**
	Events emitted by `Http2SecureServer` in addition to its parent `tls.Server` events.
**/
enum abstract Http2SecureServerEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted each time a request with an HTTP `Expect: 100-continue` is received.
	**/
	var CheckContinue:Http2SecureServerEvent<(request:Http2ServerRequest, response:Http2ServerResponse) -> Void> = "checkContinue";

	/**
		Emitted when a new TCP stream is established, before the TLS handshake begins.
	**/
	var Connection:Http2SecureServerEvent<(socket:IDuplex) -> Void> = "connection";

	/**
		Emitted each time there is a request. See the Compatibility API.
	**/
	var Request:Http2SecureServerEvent<(request:Http2ServerRequest, response:Http2ServerResponse) -> Void> = "request";

	/**
		Emitted when a new `Http2Session` is created by the `Http2SecureServer`.
	**/
	var Session:Http2SecureServerEvent<(session:ServerHttp2Session) -> Void> = "session";

	/**
		Emitted when an `'error'` event is emitted by an `Http2Session` associated with the server.
	**/
	var SessionError:Http2SecureServerEvent<(error:Error, session:ServerHttp2Session) -> Void> = "sessionError";

	/**
		Emitted when a `'stream'` event has been emitted by an `Http2Session` associated with the server.
	**/
	var Stream:Http2SecureServerEvent<(stream:ServerHttp2Stream, headers:Http2Headers, flags:Int, rawHeaders:Array<String>) -> Void> = "stream";

	/**
		Emitted when there is no activity on the Server for a given number of milliseconds.
	**/
	var Timeout:Http2SecureServerEvent<() -> Void> = "timeout";

	/**
		Emitted when a connecting client fails to negotiate an allowed protocol (HTTP/2 or HTTP/1.1).
	**/
	var UnknownProtocol:Http2SecureServerEvent<(socket:IDuplex) -> Void> = "unknownProtocol";
}

/**
	Instances of `Http2SecureServer` are created using `http2.createSecureServer()`.
	The class is not exported directly by the `node:http2` module.

	@see https://nodejs.org/api/http2.html#class-http2secureserver
**/
extern class Http2SecureServer extends js.node.tls.Server {
	/**
		Used to set the timeout value for http2 secure server requests.
	**/
	@:overload(function(?callback:() -> Void):Http2SecureServer {})
	function setTimeout(?msecs:Int, ?callback:() -> Void):Http2SecureServer;

	/**
		The number of milliseconds of inactivity before a socket is presumed to have timed out.
		Default: `0` (no timeout).
	**/
	var timeout:Int;

	/**
		Used to update the server with the provided settings.
	**/
	function updateSettings(?settings:Http2Settings):Void;
}
