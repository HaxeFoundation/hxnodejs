/*
 * Copyright (C)2014-2020 Haxe Foundation
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

import haxe.extern.EitherType;

/**
	The `URLPattern` API provides pattern matching for URLs.

	@see https://nodejs.org/api/url.html#class-urlpattern
**/
@:jsRequire("url", "URLPattern")
extern class URLPattern {
	@:overload(function(input:EitherType<String, URLPatternInit>, baseURL:String, ?options:URLPatternOptions):Void {})
	function new(?input:EitherType<String, URLPatternInit>, ?options:URLPatternOptions):Void;

	final hasRegExpGroups:Bool;
	final hash:String;
	final hostname:String;
	final password:String;
	final pathname:String;
	final port:String;
	final protocol:String;
	final search:String;
	final username:String;

	function exec(?input:EitherType<String, URLPatternInit>, ?baseURL:String):Null<URLPatternResult>;
	function test(?input:EitherType<String, URLPatternInit>, ?baseURL:String):Bool;
}

/**
	Initialization object for `URLPattern`.
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
	@:optional var ignoreCase:Bool;
}

/**
	Result of `URLPattern.exec`.
**/
typedef URLPatternResult = {
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
	var input:String;
	var groups:haxe.DynamicAccess<Null<String>>;
}
