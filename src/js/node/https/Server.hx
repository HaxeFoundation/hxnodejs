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

package js.node.https;

import js.node.net.Socket;

/**
	This class is a subclass of `tls.Server` and emits the same events as `http.Server`.

	See `http.Server` for HTTP request/response events and behavior.
	`listen()` is identical to `net.Server.listen()`.

	`[Symbol.asyncDispose]()` (calls `close()` and returns a promise) is not typed here;
	use `close` / promise wrappers as needed.

	@see https://nodejs.org/docs/latest-v24.x/api/https.html#class-httpsserver
**/
@:jsRequire("https", "Server")
extern class Server extends js.node.tls.Server {
	/**
		Limit the amount of time the parser will wait to receive the complete HTTP headers.

		See `http.Server.headersTimeout`.

		Default: `60000`.
	**/
	var headersTimeout:Int;

	/**
		Sets the timeout value in milliseconds for receiving the entire request from the client.

		See `http.Server.requestTimeout`.

		Default: `300000`.
	**/
	var requestTimeout:Int;

	/**
		Limits maximum incoming headers count. If set to 0, no limit will be applied.

		See `http.Server.maxHeadersCount`.

		Default: `2000`.
	**/
	var maxHeadersCount:Null<Int>;

	/**
		Sets the timeout value for sockets, and emits a `'timeout'` event on the Server object,
		passing the socket as an argument, if a timeout occurs.

		See `http.Server.setTimeout()`.

		Default `msecs`: `120000` (2 minutes).
	**/
	@:overload(function(?callback:(socket:Socket) -> Void):Server {})
	function setTimeout(msecs:Int, ?callback:(socket:Socket) -> Void):Server;

	/**
		The number of milliseconds of inactivity before a socket is presumed to have timed out.

		A value of `0` disables the timeout behavior on incoming connections.

		See `http.Server.timeout`.

		Default: `0` (no timeout).
	**/
	var timeout:Int;

	/**
		The number of milliseconds of inactivity a server needs to wait for additional incoming data,
		after it has finished writing the last response, before a socket will be destroyed.

		See `http.Server.keepAliveTimeout`.

		Default: `5000` (5 seconds).
	**/
	var keepAliveTimeout:Int;

	/**
		Closes all connections connected to this server.

		See `http.Server.closeAllConnections()`.
	**/
	function closeAllConnections():Void;

	/**
		Closes all connections connected to this server which are not sending a request
		or waiting for a response.

		See `http.Server.closeIdleConnections()`.
	**/
	function closeIdleConnections():Void;
}
