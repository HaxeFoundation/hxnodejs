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

package js.node;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.Buffer;
import js.node.url.URL;

/**
	The `node:url` module provides utilities for URL resolution and parsing.

	@see https://nodejs.org/api/url.html
**/
@:jsRequire("url")
extern class Url {
	/**
		Returns the Punycode ASCII serialization of the `domain`. If `domain` is an invalid domain, the empty string is returned.

		It performs the inverse operation to `url.domainToUnicode()`.

		@see https://nodejs.org/api/url.html#urldomaintoasciidomain
	**/
	static function domainToASCII(domain:String):String;

	/**
		Returns the Unicode serialization of the `domain`. If `domain` is an invalid domain, the empty string is returned.

		It performs the inverse operation to `url.domainToASCII()`.

		@see https://nodejs.org/api/url.html#urldomaintounicodedomain
	**/
	static function domainToUnicode(domain:String):String;

	/**
		This function ensures the correct decodings of percent-encoded characters as well as ensuring a cross-platform valid absolute path string.

		@see https://nodejs.org/api/url.html#urlfileurltopathurl-options
	**/
	@:overload(function(url:String, ?options:FileUrlToPathOptions):String {})
	static function fileURLToPath(url:URL, ?options:FileUrlToPathOptions):String;

	/**
		Like `fileURLToPath` but returns a `Buffer` containing the path.
		Useful when the input URL contains percent-encoded segments that are not valid UTF-8 / Unicode sequences.

		@see https://nodejs.org/api/url.html#urlfileurltopathbufferurl-options
	**/
	@:overload(function(url:String, ?options:FileUrlToPathOptions):Buffer {})
	static function fileURLToPathBuffer(url:URL, ?options:FileUrlToPathOptions):Buffer;

	/**
		Returns a customizable serialization of a URL `String` representation of a [WHATWG URL](https://nodejs.org/api/url.html#the-whatwg-url-api) object.

		The URL object has both a `toString()` method and `href` property that return string serializations of the URL.
		These are not, however, customizable in any way.
		The `url.format(URL[, options])` method allows for basic customization of the output.

		Legacy `format(urlObject)` / `format(urlString)` overloads remain for compatibility;
		`format(urlString)` is application-deprecated since Node.js v24 — prefer the WHATWG `URL` API.

		@see https://nodejs.org/api/url.html#urlformaturl-options
	**/
	@:overload(function(urlObject:UrlObject):String {})
	@:overload(function(urlObject:String):String {})
	static function format(url:URL, ?options:UrlFormatOptions):String;

	/**
		This function ensures that `path` is resolved absolutely,
		and that the URL control characters are correctly encoded when converting into a File URL.

		@see https://nodejs.org/api/url.html#urlpathtofileurlpath-options
	**/
	static function pathToFileURL(path:String, ?options:PathToFileUrlOptions):URL;

	/**
		Takes a URL string, parses it, and returns a URL object.

		If `parseQueryString` is true, the `query` property will always be set to an object returned by the `Querystring.parse` method.
		If false, the `query` property on the returned URL object will be an unparsed, undecoded string.
		Defaults to false.

		If `slashesDenoteHost` is true, the first token after the literal string `//` and preceding the next `/` will be interpreted as the host.
		For instance, given `//foo/bar`, the result would be `{host: 'foo', pathname: '/bar'}` rather than `{pathname: '//foo/bar'}`.
		Defaults to false.

		Stability: Deprecated (application deprecation since Node.js v24). Prefer the WHATWG `URL` API.

		@see https://nodejs.org/api/url.html#urlparseurlstring-parsequerystring-slashesdenotehost
	**/
	@:deprecated("Use js.node.url.URL instead")
	static function parse(urlString:String, ?parseQueryString:Bool, ?slashesDenoteHost:Bool):UrlObject;

	/**
		Resolves a target URL relative to a base URL in a manner similar to that of a Web browser resolving an anchor tag HREF.

		Examples:

		```haxe
		resolve('/one/two/three', 'four')         // '/one/two/four'
		resolve('http://example.com/', '/one')    // 'http://example.com/one'
		resolve('http://example.com/one', '/two') // 'http://example.com/two'
		```

		Stability: Deprecated. Prefer the WHATWG `URL` API.

		@see https://nodejs.org/api/url.html#urlresolvefrom-to
	**/
	@:deprecated("Use js.node.url.URL instead")
	static function resolve(from:String, to:String):String;

	/**
		Deprecated legacy helper similar to `resolve`, operating on URL objects.

		@see https://nodejs.org/api/url.html
	**/
	@:deprecated("Use js.node.url.URL instead")
	static function resolveObject(source:EitherType<String, UrlObject>, relative:EitherType<String, UrlObject>):UrlObject;

	/**
		This utility function converts a URL object into an ordinary options object as expected by the `http.request()` and `https.request()` APIs.

		@see https://nodejs.org/api/url.html#urlurltohttpoptionsurl
	**/
	static function urlToHttpOptions(url:URL):UrlHttpOptions;
}

/**
	Options object returned by `Url.urlToHttpOptions`, compatible with `http.request` / `https.request`.

	@see https://nodejs.org/api/url.html#urlurltohttpoptionsurl
**/
typedef UrlHttpOptions = {
	/**
		Protocol to use.
	**/
	@:optional var protocol:String;

	/**
		A domain name or IP address of the server to issue the request to.
	**/
	@:optional var hostname:String;

	/**
		The fragment portion of the URL.
	**/
	@:optional var hash:String;

	/**
		The serialized query portion of the URL.
	**/
	@:optional var search:String;

	/**
		The path portion of the URL.
	**/
	@:optional var pathname:String;

	/**
		Request path. Should include query string if any.
		E.g. `'/index.html?page=12'`.
	**/
	@:optional var path:String;

	/**
		The serialized URL.
	**/
	@:optional var href:String;

	/**
		Port of remote server.
	**/
	@:optional var port:EitherType<String, Int>;

	/**
		Basic authentication i.e. `'user:password'` to compute an Authorization header.
	**/
	@:optional var auth:String;
}

/**
	Options for WHATWG `Url.format(url, options)`.

	@see https://nodejs.org/api/url.html#urlformaturl-options
**/
typedef UrlFormatOptions = {
	/**
		`true` if the serialized URL string should include the username and password, `false` otherwise.

		Default: `true`.
	**/
	@:optional var auth:Bool;

	/**
		`true` if the serialized URL string should include the fragment, `false` otherwise.

		Default: `true`.
	**/
	@:optional var fragment:Bool;

	/**
		`true` if the serialized URL string should include the search query, `false` otherwise.

		Default: `true`.
	**/
	@:optional var search:Bool;

	/**
		`true` if Unicode characters appearing in the host component of the URL string should be encoded directly as opposed to being Punycode encoded.

		Default: `false`.
	**/
	@:optional var unicode:Bool;
}

/**
	Parsed URL objects have some or all of the following fields, depending on whether or not they exist in the URL string.
	Any parts that are not in the URL string will not be in the parsed object.

	Legacy URL API — prefer `js.node.url.URL`.

	@see https://nodejs.org/api/url.html#legacy-urlobject
**/
@:deprecated("Use js.node.url.URL instead")
typedef UrlObject = {
	/**
		The full URL string that was parsed with both the `protocol` and `host` components converted to lower-case.

		For example: `'http://user:pass@host.com:8080/p/a/t/h?query=string#hash'`
	**/
	@:optional var href:String;

	/**
		The URL's lower-cased protocol scheme.

		For example: `'http:'`
	**/
	@:optional var protocol:String;

	/**
		True if two ASCII forward-slash characters (`/`) are required following the colon in the `protocol`.
	**/
	@:optional var slashes:Bool;

	/**
		The full lower-cased host portion of the URL, including the `port` if specified.

		For example: `'host.com:8080'`
	**/
	@:optional var host:String;

	/**
		The username and password portion of the URL, also referred to as "userinfo".
		This string subset follows the `protocol` and double slashes (if present) and precedes the `host` component,
		delimited by an ASCII "at sign" (`@`).

		The format of the string is `{username}[:{password}]`, with the `[:{password}]` portion being optional.

		For example: `'user:pass'`
	**/
	@:optional var auth:String;

	/**
		The lower-cased host name portion of the `host` component without the `port` included.

		For example: `'host.com'`
	**/
	@:optional var hostname:String;

	/**
		The numeric port portion of the `host` component.

		For example: `'8080'`
	**/
	@:optional var port:String;

	/**
		The entire path section of the URL. This is everything following the `host` (including the `port`) and
		before the start of the `query` or `hash` components, delimited by either the ASCII question mark (`?`) or
		hash (`#`) characters.

		For example `'/p/a/t/h'`

		No decoding of the path string is performed.
	**/
	@:optional var pathname:String;

	/**
		The entire "query string" portion of the URL, including the leading ASCII question mark (`?`) character.

		For example: `'?query=string'`

		No decoding of the query string is performed.
	**/
	@:optional var search:String;

	/**
		Concatenation of the `pathname` and `search` components.

		For example: `'/p/a/t/h?query=string'`

		No decoding of the path is performed.
	**/
	@:optional var path:String;

	/**
		Either the query string without the leading ASCII question mark (`?`),
		or an object returned by the `Querystring.parse` method.

		Whether the `query` property is a string or object is determined by the `parseQueryString` argument passed to `Url.parse`.

		For example: `'query=string'` or `{'query': 'string'}`

		If returned as a string, no decoding of the query string is performed.
		If returned as an object, both keys and values are decoded.

		The type of this field can be implicitly converted to `String` or `DynamicAccess<String>`,
		where either one is expected, so if you know the actual type, just assign it
		to properly typed variable (e.g. `var s:String = url.query`)
	**/
	@:optional var query:EitherType<String, DynamicAccess<String>>;

	/**
		The "fragment" portion of the URL including the leading ASCII hash (`#`) character.

		For example: `'#hash'`
	**/
	@:optional var hash:String;
}

/**
	Options for `Url.fileURLToPath` / `fileURLToPathBuffer`.
**/
typedef FileUrlToPathOptions = {
	/**
		`true` if the path should be returned as a Windows filepath, `false` for POSIX,
		and omit / `undefined` for the system default.
	**/
	@:optional var windows:Bool;
}

/**
	Options for `Url.pathToFileURL`.
**/
typedef PathToFileUrlOptions = {
	/**
		`true` if the path should be treated as a Windows filepath, `false` for POSIX,
		and omit / `undefined` for the system default.
	**/
	@:optional var windows:Bool;
}
