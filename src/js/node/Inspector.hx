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

package js.node;

import js.node.inspector.InspectorConsole;

/**
	The `inspector` module provides an API for interacting with the V8 inspector.

	Related types live under `js.node.inspector` (`Session`, `Network`, `NetworkResources`, `DomStorage`).

	@see https://nodejs.org/docs/latest-v24.x/api/inspector.html
**/
@:jsRequire("inspector")
extern class Inspector {
	/**
		Activate inspector on host and port. Equivalent to `node --inspect=[[host:]port]`,
		but can be done programmatically after node has started.

		If `wait` is `true`, will block until a client has connected to the inspect port
		and flow control has been passed to the debugger client.

		Returns a Disposable (`{ [Symbol.dispose](): void }`) that calls `inspector.close()`.

		// TODO: model Web IDL `Disposable` / `Symbol.dispose` instead of `Dynamic`.
	**/
	static function open(?port:Int, ?host:String, ?wait:Bool):Dynamic;

	/**
		Attempts to close all remaining connections, blocking the event loop until all are closed.
		Once all connections are closed, deactivates the inspector.
	**/
	static function close():Void;

	/**
		Return the URL of the active inspector, or `undefined` if there is none.
	**/
	static function url():Null<String>;

	/**
		Blocks until a client (existing or connected later) has sent
		`Runtime.runIfWaitingForDebugger` command.

		An exception will be thrown if there is no active inspector.
	**/
	static function waitForDebugger():Void;

	/**
		An object to send messages to the remote inspector console.

		The inspector console does not have API parity with Node.js console.
	**/
	static var console(default, null):InspectorConsole;
}
