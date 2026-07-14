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

/**
	Default writer for a `WritableStream`.

	@see https://nodejs.org/api/globals.html#class-writablestreamdefaultwriter
	@see https://nodejs.org/api/webstreams.html#class-writablestreamdefaultwriter
**/
@:native("WritableStreamDefaultWriter")
extern class WritableStreamDefaultWriter {
	function new(stream:WritableStream):Void;

	var closed(default, null):Promise<Void>;
	var ready(default, null):Promise<Void>;
	var desiredSize(default, null):Null<Float>;

	function abort(?reason:Any):Promise<Void>;
	function close():Promise<Void>;
	function releaseLock():Void;
	function write(?chunk:Any):Promise<Void>;
}
