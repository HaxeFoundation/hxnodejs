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

import haxe.DynamicAccess;
import js.node.Buffer;
import js.node.events.EventEmitter.Event;
import js.node.tls.TLSSocket;

/**
	Events emitted by `https.Agent` in addition to inherited `http.Agent` / `EventEmitter` events.

	@see https://nodejs.org/docs/latest-v24.x/api/https.html#event-keylog
**/
enum abstract AgentEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when key material is generated or received by a connection managed by this agent
		(typically before handshake has completed, but not necessarily).

		Listener arguments:
			line - ASCII text in NSS `SSLKEYLOGFILE` format
			tlsSocket - the `tls.TLSSocket` instance on which it was generated
	**/
	var Keylog:AgentEvent<(line:Buffer, tlsSocket:TLSSocket) -> Void> = "keylog";
}

/**
	An Agent object for HTTPS similar to `http.Agent`.

	Like `http.Agent`, `createConnection(options[, callback])` can be overridden to customize
	how TLS connections are established.

	@see https://nodejs.org/docs/latest-v24.x/api/https.html#class-httpsagent
**/
@:jsRequire("https", "Agent")
extern class Agent extends js.node.http.Agent {
	function new(?options:HttpsAgentOptions);
}

/**
	Options for `https.Agent`.

	Accepts the same fields as `http.Agent`, plus TLS session / SNI options and
	Node.js v24.5+ proxy / default port fields listed below.
**/
typedef HttpsAgentOptions = {
	> js.node.http.Agent.HttpAgentOptions,

	/**
		Maximum number of TLS cached sessions. Use `0` to disable TLS session caching.

		Default: `100`.
	**/
	@:optional var maxCachedSessions:Int;

	/**
		The value of [Server Name Indication extension](https://en.wikipedia.org/wiki/Server_Name_Indication) to be sent to the server.
		Use empty string `''` to disable sending the extension.

		Default: hostname of the target server, unless the target server is specified using an IP address, in which case the default is `''` (no extension).

		Since Node.js v12.5.0, `servername` is not automatically set when the target host was specified using an IP address.
	**/
	@:optional var servername:String;

	/**
		Environment variables for proxy configuration. See Node.js built-in proxy support.

		Default: `undefined`. Added in Node.js v24.5.0.
	**/
	@:optional var proxyEnv:DynamicAccess<String>;

	/**
		Default port to use when the port is not specified in requests.

		Default: `443`. Added in Node.js v24.5.0.
	**/
	@:optional var defaultPort:Int;

	/**
		The protocol to use for the agent.

		Default: `'https:'`. Added in Node.js v24.5.0.
	**/
	@:optional var protocol:String;
}
