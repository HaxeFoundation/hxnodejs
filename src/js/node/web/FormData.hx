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

import haxe.extern.EitherType;
import js.node.Iterator;
import js.node.KeyValue;

/**
	A browser-compatible `FormData` implementation (undici / fetch).

	@see https://nodejs.org/api/globals.html#class-formdata
**/
@:native("FormData")
extern class FormData {
	function new():Void;

	/**
		Appends a new value onto an existing key, or adds the key if it does not exist.
	**/
	@:overload(function(name:String, value:Blob, ?filename:String):Void {})
	function append(name:String, value:String):Void;

	/**
		Deletes a key/value pair.
	**/
	function delete(name:String):Void;

	/**
		Returns the first value associated with a given key.
	**/
	function get(name:String):Null<EitherType<String, EitherType<Blob, File>>>;

	/**
		Returns all values associated with a given key.
	**/
	function getAll(name:String):Array<EitherType<String, EitherType<Blob, File>>>;

	/**
		Returns whether a key exists.
	**/
	function has(name:String):Bool;

	/**
		Sets a new value for an existing key, or adds the key if it does not exist.
	**/
	@:overload(function(name:String, value:Blob, ?filename:String):Void {})
	function set(name:String, value:String):Void;

	function entries():Iterator<KeyValue<String, EitherType<String, EitherType<Blob, File>>>>;
	function keys():Iterator<String>;
	function values():Iterator<EitherType<String, EitherType<Blob, File>>>;
	function forEach(callback:EitherType<String, EitherType<Blob, File>>->String->FormData->Void, ?thisArg:Any):Void;
}
