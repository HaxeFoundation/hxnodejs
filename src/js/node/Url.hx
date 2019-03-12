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

import haxe.DynamicAccess;

/**
	This module has utilities for URL resolution and parsing.
**/
@:jsRequire("url")
extern class Url {
	/**
		Takes a URL string, parses it, and returns a URL object.

		If `parseQueryString` is true, the `query` property will always be set to an object returned by the `Querystring.parse` method.
		If false, the `query` property on the returned URL object will be an unparsed, undecoded string.
		Defaults to false.

		If `slashesDenoteHost` is true, the first token after the literal string `//` and preceding the next `/` will be interpreted as the host.
		For instance, given `//foo/bar`, the result would be `{host: 'foo', pathname: '/bar'}` rather than `{pathname: '//foo/bar'}`.
		Defaults to false.
	**/
	static function parse(urlString:String, ?parseQueryString:Bool, ?slashesDenoteHost:Bool):UrlObject;

	/**
		Returns a formatted URL string derived from `urlObject`.

		If `urlObject` is a string, it is converted to an object by passing it to `Url.parse`.
	**/
	@:overload(function(urlObject:String):String {})
	static function format(urlObject:UrlObject):String;

	/**
		Resolves a target URL relative to a base URL in a manner similar to that of a Web browser resolving an anchor tag HREF.

		Examples:
			resolve('/one/two/three', 'four')         // '/one/two/four'
			resolve('http://example.com/', '/one')    // 'http://example.com/one'
			resolve('http://example.com/one', '/two') // 'http://example.com/two'
	**/
	static function resolve(from:String, to:String):String;
}

/**
	Parsed URL objects have some or all of the following fields, depending on whether or not they exist in the URL string.
	Any parts that are not in the URL string will not be in the parsed object.
**/
typedef UrlObject = {
	/**
		The full URL string that was parsed with both the `protocol` and `host` components converted to lower-case.

		For example: 'http://user:pass@host.com:8080/p/a/t/h?query=string#hash'
	**/
	@:optional var href:String;

	/**
		The URL's lower-cased protocol scheme.

		For example: 'http:'
	**/
	@:optional var protocol:String;

	/**
		True if two ASCII forward-slash characters (`/`) are required following the colon in the `protocol`.
	**/
	@:optional var slashes:Bool;

	/**
		The full lower-cased host portion of the URL, including the `port` if specified.

		For example: 'host.com:8080'
	**/
	@:optional var host:String;

	/**
		The username and password portion of the URL, also referred to as "userinfo".
		This string subset follows the `protocol` and double slashes (if present) and precedes the `host` component,
		delimited by an ASCII "at sign" (`@`).

		The format of the string is `{username}[:{password}]`, with the `[:{password}]` portion being optional.

		For example: 'user:pass'
	**/
	@:optional var auth:String;

	/**
		The lower-cased host name portion of the `host` component without the `port` included.

		For example: 'host.com'
	**/
	@:optional var hostname:String;

	/**
		The numeric port portion of the `host` component.

		For example: '8080'
	**/
	@:optional var port:String;

	/**
		The entire path section of the URL. This is everything following the `host` (including the `port`) and
		before the start of the `query` or `hash` components, delimited by either the ASCII question mark (`?`) or
		hash (`#`) characters.

		For example '/p/a/t/h'

		No decoding of the path string is performed.
	**/
	@:optional var pathname:String;

	/**
		The entire "query string" portion of the URL, including the leading ASCII question mark (`?`) character.

		For example: '?query=string'

		No decoding of the query string is performed.
	**/
	@:optional var search:String;

	/**
		Concatenation of the `pathname` and `search` components.

		For example: '/p/a/t/h?query=string'

		No decoding of the path is performed.
	**/
	@:optional var path:String;

	/**
		Either the query string without the leading ASCII question mark (`?`),
		or an object returned by the `Querystring.parse` method.

		Whether the `query` property is a string or object is determined by the `parseQueryString` argument passed to `Url.parse`.

		For example: 'query=string' or {'query': 'string'}

		If returned as a string, no decoding of the query string is performed.
		If returned as an object, both keys and values are decoded.

		The type of this field can be implicitly converted to `String` or `DynamicAccess<String>`,
		where either one is expected, so if you know the actual type, just assign it
		to properly typed variable (e.g. var s:String = url.query)
	**/
	@:optional var query:haxe.extern.EitherType<String,DynamicAccess<String>>;

	/**
		The "fragment" portion of the URL including the leading ASCII hash (`#`) character.

		For example: '#hash'
	**/
	@:optional var hash:String;
}

@:dox(hide) @:deprecated("Use UrlObject instead") typedef UrlData = UrlObject;
