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

package js.node.url;

import js.node.web.Blob;

/**
	Browser-compatible `URL` class, implemented by following the WHATWG URL Standard.
	Examples of parsed URLs may be found in the Standard itself.
	The `URL` class is also available on the global object.

	@see https://nodejs.org/api/url.html#class-url
	@see https://url.spec.whatwg.org/#example-url-parsing
**/
@:jsRequire("url", "URL")
extern class URL {
	/**
		Creates a new `URL` object by parsing the `input` relative to the `base`.
		If `base` is passed as a string, it will be parsed equivalent to `new URL(base)`.

		@see https://nodejs.org/api/url.html#new-urlinput-base
	**/
	@:overload(function(input:String, ?base:URL):Void {})
	function new(input:String, ?base:String):Void;

	/**
		Checks whether `input` can be successfully parsed as a URL relative to `base`.

		@see https://nodejs.org/api/url.html#urlcanparseinput-base
	**/
	@:overload(function(input:String, ?base:URL):Bool {})
	static function canParse(input:String, ?base:String):Bool;

	/**
		Parses `input` relative to `base` into a `URL` object, or returns `null` on failure.

		@see https://nodejs.org/api/url.html#urlparseinput-base
	**/
	@:overload(function(input:String, ?base:URL):Null<URL> {})
	static function parse(input:String, ?base:String):Null<URL>;

	/**
		Creates a `'blob:nodedata:...'` URL string that represents the given `Blob` and can
		be used to retrieve it later (e.g. via `js.node.buffer.Buffer.resolveObjectURL`).

		The data is retained in memory until `revokeObjectURL` is called.

		@see https://nodejs.org/api/url.html#urlcreateobjecturlblob
	**/
	static function createObjectURL(blob:Blob):String;

	/**
		Removes the `Blob` object identified by a prior `createObjectURL` id.
		Attempting to revoke an unregistered id silently fails.

		@see https://nodejs.org/api/url.html#urlrevokeobjecturlid
	**/
	static function revokeObjectURL(id:String):Void;

	/**
		Gets and sets the fragment portion of the URL.

		@see https://nodejs.org/api/url.html#urlhash
	**/
	var hash:String;

	/**
		Gets and sets the host portion of the URL.

		@see https://nodejs.org/api/url.html#urlhost
	**/
	var host:String;

	/**
		Gets and sets the hostname portion of the URL.
		The key difference between `url.host` and `url.hostname` is that `url.hostname` does not include the port.

		@see https://nodejs.org/api/url.html#urlhostname
	**/
	var hostname:String;

	/**
		Gets and sets the serialized URL.

		@see https://nodejs.org/api/url.html#urlhref
	**/
	var href:String;

	/**
		Gets the read-only serialization of the URL's origin.

		@see https://nodejs.org/api/url.html#urlorigin
	**/
	var origin(default, null):String;

	/**
		Gets and sets the password portion of the URL.

		@see https://nodejs.org/api/url.html#urlpassword
	**/
	var password:String;

	/**
		Gets and sets the path portion of the URL.

		@see https://nodejs.org/api/url.html#urlpathname
	**/
	var pathname:String;

	/**
		Gets and sets the port portion of the URL.

		The port value may be a number or a string containing a number in the range `0` to `65535` (inclusive).
		Setting the value to the default port of the `URL` objects given `protocol` will result in the port value becoming the empty string (`''`).

		@see https://nodejs.org/api/url.html#urlport
	**/
	var port:String;

	/**
		Gets and sets the protocol portion of the URL.

		@see https://nodejs.org/api/url.html#urlprotocol
	**/
	var protocol:String;

	/**
		Gets and sets the serialized query portion of the URL.

		@see https://nodejs.org/api/url.html#urlsearch
	**/
	var search:String;

	/**
		Gets the `URLSearchParams` object representing the query parameters of the URL.
		This property is read-only; to replace the entirety of query parameters of the URL, use the `url.search` setter.

		@see https://nodejs.org/api/url.html#urlsearchparams
	**/
	var searchParams(default, null):URLSearchParams;

	/**
		Gets and sets the username portion of the URL.

		@see https://nodejs.org/api/url.html#urlusername
	**/
	var username:String;

	/**
		The `toString()` method on the `URL` object returns the serialized URL.
		The value returned is equivalent to that of `url.href` and `url.toJSON()`.

		Because of the need for standard compliance, this method does not allow users to customize the serialization process of the URL.
		For more flexibility, `js.node.Url.format` might be of interest.

		@see https://nodejs.org/api/url.html#urltostring
	**/
	function toString():String;

	/**
		The `toJSON()` method on the `URL` object returns the serialized URL.
		The value returned is equivalent to that of `url.href` and `url.toString()`.

		This method is automatically called when an `URL` object is serialized with `JSON.stringify()`.

		@see https://nodejs.org/api/url.html#urltojson
	**/
	function toJSON():String;
}
