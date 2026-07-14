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

/**
	A browser-compatible implementation of `TransformStream`.

	@see https://nodejs.org/api/globals.html#class-transformstream
	@see https://nodejs.org/api/webstreams.html#class-transformstream
**/
@:native("TransformStream")
extern class TransformStream {
	var readable(default, null):ReadableStream;
	var writable(default, null):WritableStream;

	function new(?transformer:Transformer, ?writableStrategy:QueuingStrategy, ?readableStrategy:QueuingStrategy):Void;
}

/**
	Transformer callbacks for `TransformStream`.
**/
typedef Transformer = {
	@:optional var start:TransformStreamDefaultController->Any;
	@:optional var transform:Any->TransformStreamDefaultController->Any;
	@:optional var flush:TransformStreamDefaultController->Any;
	@:optional var cancel:Any->Any;
	@:optional var readableType:Any;
	@:optional var writableType:Any;
}
