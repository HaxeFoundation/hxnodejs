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
package js.node;

/**
	API for decoding `Buffer` objects into strings in a manner that preserves encoded multi-byte UTF-8 and UTF-16 characters.
**/
@:jsRequire("string_decoder", "StringDecoder")
extern class StringDecoder {
	/**
		`encoding` defaults to `utf8`
	**/
	function new(?encoding:String);

	/**
		Returns a decoded string, ensuring that any incomplete multibyte characters at the end of the `Buffer` are
		omitted from the returned string and stored in an internal buffer for the next call to `write` or `end`.
	**/
	function write(buffer:Buffer):String;

	/**
		Returns any remaining input stored in the internal buffer as a string.
		Bytes representing incomplete UTF-8 and UTF-16 characters will be replaced with
		substitution characters appropriate for the character encoding.

		If the `buffer` argument is provided, one final call to `write` is performed before returning the remaining input.
	**/
	function end(?buffer:Buffer):String;
}
