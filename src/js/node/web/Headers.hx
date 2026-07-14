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

import haxe.DynamicAccess;
import js.node.Iterator;
import js.node.KeyValue;

/**
	HTTP headers for `fetch` / `Request` / `Response` (undici).

	@see https://nodejs.org/api/globals.html#class-headers
**/
@:native("Headers")
extern class Headers {
	@:overload(function(?init:Array<Array<String>>):Void {})
	@:overload(function(?init:DynamicAccess<String>):Void {})
	function new(?init:Headers):Void;

	/**
		Appends a new value onto an existing header, or adds the header if it does not exist.
	**/
	function append(name:String, value:String):Void;

	/**
		Deletes a header.
	**/
	function delete(name:String):Void;

	/**
		Returns the value of a header with the given name, or `null` if not present.
	**/
	function get(name:String):Null<String>;

	/**
		Returns an array containing the values of all `Set-Cookie` headers.
	**/
	function getSetCookie():Array<String>;

	/**
		Returns whether a header with the given name exists.
	**/
	function has(name:String):Bool;

	/**
		Sets a new value for an existing header, or adds the header if it does not exist.
	**/
	function set(name:String, value:String):Void;

	function entries():Iterator<KeyValue<String, String>>;
	function keys():Iterator<String>;
	function values():Iterator<String>;
	function forEach(callback:String->String->Headers->Void, ?thisArg:Any):Void;
}
