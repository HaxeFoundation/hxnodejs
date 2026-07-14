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
import js.node.inspector.promises.Session;

/**
	Promise-based `inspector` API (`inspector/promises`).

	Stability: 1 - Experimental.

	Module-level helpers match `Inspector`; use `js.node.inspector.promises.Session`
	for a `Session` whose `post` returns a `Promise`.

	@see https://nodejs.org/api/inspector.html#promises-api
**/
@:jsRequire("inspector/promises")
extern class InspectorPromises {
	/**
		Activate inspector on host and port.

		Returns a Disposable (`{ [Symbol.dispose](): void }`) that calls `close()`.
		Typed as `Dynamic` because hxnodejs does not yet model the Web IDL `Disposable` interface.
	**/
	static function open(?port:Int, ?host:String, ?wait:Bool):Dynamic;

	/**
		Attempts to close all remaining connections, blocking the event loop until all are closed.
	**/
	static function close():Void;

	/**
		Return the URL of the active inspector, or `undefined` if there is none.
	**/
	static function url():Null<String>;

	/**
		Blocks until a client has sent `Runtime.runIfWaitingForDebugger`.
	**/
	static function waitForDebugger():Void;

	/**
		An object to send messages to the remote inspector console.
	**/
	static var console(default, null):InspectorConsole;
}
