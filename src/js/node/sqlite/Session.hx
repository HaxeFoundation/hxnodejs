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

package js.node.sqlite;

import js.lib.Uint8Array;

/**
	Tracks changes for later changeset / patchset application.

	Created via `DatabaseSync.createSession()`.
	Implements `Symbol.dispose` (closes the session; no-op if already closed).

	@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#class-session
**/
@:jsRequire("node:sqlite", "Session")
extern class Session {
	/**
		Binary changeset of all tracked changes.
	**/
	function changeset():Uint8Array;

	/**
		More compact binary patchset of tracked changes.
	**/
	function patchset():Uint8Array;

	/**
		Closes the session.
	**/
	function close():Void;
}
