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

import haxe.extern.EitherType;
import haxe.DynamicAccess;

/**
	Options used for `Querystring.parse` method.
**/
typedef QuerystringParseOptions = {
	/**
		Specifies the maximum number of keys to parse.
		Defaults to 1000.
		Specify 0 to remove key counting limitations.
	**/
	@:optional var maxKeys:Int;

	/**
		The function to use when decoding percent-encoded characters in the query string.
		Defaults to `Querystring.unescape`.
	**/
	@:optional var decodeURIComponent:String->String;
}

/**
	Options for `Querystring.stringify` method.
**/
typedef QuerystringStringifyOptions = {
	/**
		The function to use when converting URL-unsafe characters to percent-encoding in the query string.
		Defaults to `Querystring.escape`.
	**/
	@:optional var encodeURIComponent:String->String;
}

/**
	The result type of `Querystring.parse`. Is a collection of either strings or array of strings.
**/
typedef QuerystringParseResult = DynamicAccess<EitherType<String,Array<String>>>;

/**
	This module provides utilities for dealing with query strings.
**/
@:jsRequire("querystring")
extern class Querystring {
	/**
		Produces a URL query string from a given `obj` by iterating through the object's "own properties".

		If `sep` is provided, it is used to delimit key and value pairs in the query string. Defaults to '&'.
		If `eq` is provided, it is used to delimit keys and values in the query string. Defaults to '='.

		By default, characters requiring percent-encoding within the query string will be encoded as UTF-8.
		If an alternative encoding is required, then an alternative `encodeURIComponent` option will need to be specified.
	**/
	@:overload(function(obj:{}, ?sep:String):String {})
	static function stringify(obj:{}, sep:String, eq:String, ?options:QuerystringStringifyOptions):String;

	/**
		Parses a URL query string (`str`) into a collection of key and value pairs.

		If `sep` is provided, it is used to delimit key and value pairs in the query string. Defaults to '&'.
		If `eq` is provided, it is used to delimit keys and values in the query string. Defaults to '='.

		By default, percent-encoded characters within the query string will be assumed to use UTF-8 encoding.
		If an alternative character encoding is used, then an alternative `decodeURIComponent` option will need to be specified.
	**/
	@:overload(function(str:String, ?sep:String):QuerystringParseResult {})
	static function parse(str:String, sep:String, eq:String, ?options:QuerystringParseOptions):QuerystringParseResult;

	/**
		Performs URL percent-encoding on the given `str` in a manner that is optimized for
		the specific requirements of URL query strings.

		This method is used by `stringify` and is generally not expected to be used directly.
		It is exported primarily to allow application code to provide a replacement percent-encoding implementation
		if necessary by assigning `Querystring.escape` to an alternative function.
	**/
	static dynamic function escape(str:String):String;

	/**
		Performs decoding of URL percent-encoded characters on the given `str`.

		This method is used by `Querystring.parse` and is generally not expected to be used directly.
		It is exported primarily to allow application code to provide a replacement decoding implementation
		if necessary by assigning `Querystring.unescape` to an alternative function.

		By default, this method will attempt to use the JavaScript built-in `decodeURIComponent` method to decode.
		If that fails, a safer equivalent that does not throw on malformed URLs will be used.
	**/
	static dynamic function unescape(str:String):Dynamic;
}
