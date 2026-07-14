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

package js.node.util;

import js.node.Iterator;
import js.node.KeyValue;

/**
	The `MIMEParams` API provides read and write access to the parameters of a `MIMEType`.

	@see https://nodejs.org/api/util.html#class-utilmimeparams
**/
@:jsRequire("util", "MIMEParams")
extern class MIMEParams {
	/**
		Creates a new `MIMEParams` object with empty parameters.
	**/
	function new();

	/**
		Remove all name-value pairs whose name is `name`.
	**/
	function delete(name:String):Void;

	/**
		Returns an iterator over each of the name-value pairs in the parameters.
	**/
	function entries():Iterator<KeyValue<String, String>>;

	/**
		Returns the value of the first name-value pair whose name is `name`.
		If there are no such pairs, `null` is returned.
	**/
	function get(name:String):Null<String>;

	/**
		Returns a value indicating whether there is at least one name-value pair whose name is `name`.
	**/
	function has(name:String):Bool;

	/**
		Returns an iterator over the names of each name-value pair.
	**/
	function keys():Iterator<String>;

	/**
		Sets the value in the `MIMEParams` object associated with `name` to `value`.
		If there are any pre-existing name-value pairs whose names are `name`, set the first such pair's value to `value`.
	**/
	function set(name:String, value:String):Void;

	/**
		Returns an iterator over the values of each name-value pair.
	**/
	function values():Iterator<String>;

	/**
		Returns the serialized parameters.
	**/
	function toString():String;

	/**
		Alias for `toString()`.
	**/
	function toJSON():String;
}
