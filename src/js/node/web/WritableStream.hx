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
	A browser-compatible implementation of `WritableStream`.

	@see https://nodejs.org/api/globals.html#class-writablestream
	@see https://nodejs.org/api/webstreams.html#class-writablestream
**/
@:native("WritableStream")
extern class WritableStream {
	var locked(default, null):Bool;

	function new(?underlyingSink:WritableStreamUnderlyingSink, ?strategy:QueuingStrategy):Void;

	function abort(?reason:Any):Promise<Void>;
	function close():Promise<Void>;
	function getWriter():WritableStreamDefaultWriter;
}

/**
	Underlying sink for `WritableStream` construction.
**/
typedef WritableStreamUnderlyingSink = {
	@:optional var type:Any;
	@:optional var start:WritableStreamDefaultController->Any;
	@:optional var write:Any->WritableStreamDefaultController->Any;
	@:optional var close:Void->Any;
	@:optional var abort:Any->Any;
}
