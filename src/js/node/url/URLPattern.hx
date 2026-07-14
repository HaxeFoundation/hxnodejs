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

import haxe.DynamicAccess;
import haxe.extern.EitherType;

/**
	The `URLPattern` API provides an interface to match URLs or parts of URLs against a pattern.

	Stability: Experimental (Node.js Stability 1).

	@see https://nodejs.org/api/url.html#class-urlpattern
**/
@:jsRequire("url", "URLPattern")
extern class URLPattern {
	/**
		Instantiate a new `URLPattern` from a URL string or pattern init object.
		When `baseURL` is provided, relative patterns are resolved against it.
		`options.ignoreCase` enables case-insensitive matching when `true`.

		The constructor can throw a `TypeError` to indicate parsing failure.

		@see https://nodejs.org/api/url.html#new-urlpatternstring-baseurl-options
		@see https://nodejs.org/api/url.html#new-urlpatternobj-baseurl-options
	**/
	@:overload(function(input:EitherType<String, URLPatternInit>, baseURL:String, ?options:URLPatternOptions):Void {})
	function new(?input:EitherType<String, URLPatternInit>, ?options:URLPatternOptions):Void;

	/**
		Whether the pattern contains any regular-expression capturing groups.
	**/
	final hasRegExpGroups:Bool;

	/**
		Pattern for the URL hash (fragment) component.
	**/
	final hash:String;

	/**
		Pattern for the URL hostname component.
	**/
	final hostname:String;

	/**
		Pattern for the URL password component.
	**/
	final password:String;

	/**
		Pattern for the URL pathname component.
	**/
	final pathname:String;

	/**
		Pattern for the URL port component.
	**/
	final port:String;

	/**
		Pattern for the URL protocol component.
	**/
	final protocol:String;

	/**
		Pattern for the URL search (query) component.
	**/
	final search:String;

	/**
		Pattern for the URL username component.
	**/
	final username:String;

	/**
		Returns match details when `input` matches this pattern, or `null` otherwise.
		`input` may be a URL string or an object providing individual URL parts.
		If `baseURL` is omitted it defaults to `undefined`.

		@see https://nodejs.org/api/url.html#urlpatternexecinput-baseurl
	**/
	function exec(?input:EitherType<String, URLPatternInit>, ?baseURL:String):Null<URLPatternResult>;

	/**
		Returns `true` if `input` matches this pattern.
		`input` may be a URL string or an object providing individual URL parts.
		If `baseURL` is omitted it defaults to `undefined`.

		@see https://nodejs.org/api/url.html#urlpatterntestinput-baseurl
	**/
	function test(?input:EitherType<String, URLPatternInit>, ?baseURL:String):Bool;
}

/**
	Initialization object for `URLPattern` construction / matching.

	Members may be any of `protocol`, `username`, `password`, `hostname`, `port`,
	`pathname`, `search`, `hash`, or `baseURL`.
**/
typedef URLPatternInit = {
	@:optional var protocol:String;
	@:optional var username:String;
	@:optional var password:String;
	@:optional var hostname:String;
	@:optional var port:String;
	@:optional var pathname:String;
	@:optional var search:String;
	@:optional var hash:String;
	@:optional var baseURL:String;
}

/**
	Options for `URLPattern`.
**/
typedef URLPatternOptions = {
	/**
		When `true`, enables case-insensitive matching.
	**/
	@:optional var ignoreCase:Bool;
}

/**
	Result of a successful `URLPattern.exec` call.
**/
typedef URLPatternResult = {
	/**
		The arguments passed into `exec`.
	**/
	var inputs:Array<EitherType<String, URLPatternInit>>;

	var protocol:URLPatternComponentResult;
	var username:URLPatternComponentResult;
	var password:URLPatternComponentResult;
	var hostname:URLPatternComponentResult;
	var port:URLPatternComponentResult;
	var pathname:URLPatternComponentResult;
	var search:URLPatternComponentResult;
	var hash:URLPatternComponentResult;
}

/**
	A single URL component match result.
**/
typedef URLPatternComponentResult = {
	/**
		The matched input for this component.
	**/
	var input:String;

	/**
		Named / numbered capture groups for this component.
	**/
	var groups:DynamicAccess<Null<String>>;
}
