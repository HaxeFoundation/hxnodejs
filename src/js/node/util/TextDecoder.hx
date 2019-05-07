/*
 * Copyright (C)2014-2019 Haxe Foundation
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
package js.node.util;

#if haxe4
import js.lib.ArrayBuffer;
import js.lib.DataView;
#else
import js.html.ArrayBuffer;
import js.html.DataView;
#end

/**
	An implementation of the WHATWG Encoding Standard TextDecoder API.
**/
@:jsRequire("util", "TextDecoder")
extern class TextDecoder {
	/**
		Creates an new `TextDecoder` instance.
		
		The `encoding` may specify one of the supported encodings or an alias.
	**/
	function new(?encoding:String, ?options:TextDecoderOptions);

	/**
		Decodes the `input` and returns a string.
		If `options.stream` is `true`, any incomplete byte sequences occurring at the end of the `input`
		are buffered internally and emitted after the next call to `decode()`.

		If `fatal` is `true`, decoding errors that occur will result in a `TypeError` being thrown.
	**/
	@:overload(function(?input:DataView, ?options:TextDecodeOptions):String {})
	@:overload(function(?input:js.Node.TypedArray, ?options:TextDecodeOptions):String {})
	function decode(?input:ArrayBuffer, ?options:TextDecodeOptions):String;

	/**
		The encoding supported by the `TextDecoder` instance.
	**/
	var encoding(default,null):String;

	/**
		The value will be `true` if decoding errors result in a `TypeError` being thrown.
	**/
	var fatal(default,null):Bool;

	/**
		The value will be `true` if the decoding result will include the byte order mark.
	**/
	var ignoreBOM(default,null):Bool;
}

typedef TextDecoderOptions = {
	/**
		`true` if decoding failures are fatal. This option is only supported when ICU is enabled (see Internationalization).
		
		Default: `false`.
	**/
	@:optional var fatal:Bool;

	/**
		When `true`, the TextDecoder will include the byte order mark in the decoded result.
		
		When `false`, the byte order mark will be removed from the output.
		
		This option is only used when encoding is 'utf-8', 'utf-16be' or 'utf-16le'.
		
		Default: `false`.
	**/
	@:optional var ignoreBOM:Bool;
}

typedef TextDecodeOptions = {
	/**
		true if additional chunks of data are expected.
		
		Default: false.
	**/
	@:optional var stream:Bool;
}
