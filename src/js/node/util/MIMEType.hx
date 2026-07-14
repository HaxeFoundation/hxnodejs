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

import haxe.extern.EitherType;

/**
	An implementation of the MIMEType class.

	@see https://nodejs.org/api/util.html#class-utilmimetype
**/
@:jsRequire("util", "MIMEType")
extern class MIMEType {
	/**
		Gets the essence of the MIME.
	**/
	final essence:String;

	/**
		Gets the `MIMEParams` object representing the parameters of the MIME.
	**/
	final params:MIMEParams;

	/**
		Gets and sets the subtype portion of the MIME.
	**/
	var subtype:String;

	/**
		Gets and sets the type portion of the MIME.
	**/
	var type:String;

	/**
		Creates a new `MIMEType` object by parsing the `input`.
	**/
	function new(input:EitherType<String, {toString:() -> String}>);

	/**
		Alias for `toString()`.
	**/
	function toJSON():String;

	/**
		Returns the serialized MIME.
	**/
	function toString():String;
}
