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

import js.lib.Uint8Array;

/**
	WHATWG Encoding Standard `TextEncoder` (global).

	Also available via `js.node.util.TextEncoder` (`require("util").TextEncoder`),
	which mirrors this `encode` / `encodeInto` surface.

	@see https://nodejs.org/api/globals.html#class-textencoder
**/
@:native("TextEncoder")
extern class TextEncoder {
	/**
		Always `'utf-8'`.
	**/
	var encoding(default, null):String;

	function new():Void;

	/**
		UTF-8 encodes `input` and returns a `Uint8Array` of the encoded bytes.
	**/
	function encode(?input:String):Uint8Array;

	/**
		Encodes `source` into `destination` and returns how many code units / bytes were written.
	**/
	function encodeInto(source:String, destination:Uint8Array):TextEncoderEncodeIntoResult;
}

/**
	Result of `TextEncoder.encodeInto`.
**/
typedef TextEncoderEncodeIntoResult = {
	var read:Int;
	var written:Int;
}
