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

import haxe.extern.EitherType;
import js.lib.ArrayBuffer;
import js.lib.ArrayBufferView;

/**
	WHATWG Encoding Standard `TextDecoder` (global).

	Also available via `js.node.util.TextDecoder`.

	@see https://nodejs.org/api/globals.html#class-textdecoder
**/
@:native("TextDecoder")
extern class TextDecoder {
	var encoding(default, null):String;
	var fatal(default, null):Bool;
	var ignoreBOM(default, null):Bool;

	function new(?label:String, ?options:TextDecoderOptions):Void;

	/**
		Decodes `input` and returns a string. When `stream` is true, incomplete
		byte sequences may be buffered until a subsequent `decode` call.
	**/
	function decode(?input:EitherType<ArrayBuffer, ArrayBufferView>, ?options:{@:optional var stream:Bool;}):String;
}

/**
	Options for the `TextDecoder` constructor.
**/
typedef TextDecoderOptions = {
	@:optional var fatal:Bool;
	@:optional var ignoreBOM:Bool;
}
