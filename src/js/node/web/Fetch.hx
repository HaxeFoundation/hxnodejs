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

package js.node.web;

import js.lib.Promise;
import js.node.url.URL;
import js.node.web.Request.RequestInit;

/**
	Browser-compatible `fetch()` (undici), exposed as a static on `globalThis`.

	Stable since Node.js v21.0.0. Usage: `Fetch.fetch(url)` / `Fetch.fetch(url, init)`,
	or `js.Node.fetch(url)`.

	@see https://nodejs.org/api/globals.html#fetch
**/
@:native("globalThis")
extern class Fetch {
	/**
		Starts the process of fetching a resource from the network.
	**/
	@:overload(function(input:Request, ?init:RequestInit):Promise<Response> {})
	@:overload(function(input:URL, ?init:RequestInit):Promise<Response> {})
	static function fetch(input:String, ?init:RequestInit):Promise<Response>;
}
