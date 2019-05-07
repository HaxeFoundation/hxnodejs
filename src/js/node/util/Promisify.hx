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
package js.node.util;

import haxe.extern.Rest;
import haxe.Constraints.Function;
#if haxe4
import js.lib.Promise;
#else
import js.Promise;
#end

@:jsRequire("util", "promisify")
extern class Promisify {
	/**
		Takes a function following the common error-first callback style, i.e. taking an `(err, value) => ...`
		callback as the last argument, and returns a version that returns promises.

		If there is an `original[util.promisify.custom]` property present, promisify will return its value.

		`promisify()` assumes that `original` is a function taking a callback as its final argument in all cases.
		If `original` is not a function, `promisify()` will throw an error. If original is a function but its last
		argument is not an error-first callback, it will still be passed an error-first callback as its last argument.
	**/
	@:selfCall
	static function promisify(original:Function):Rest<Dynamic>->Promise<Dynamic>;

	/**
		A `<symbol>` that can be used to declare custom promisified variants of functions.
	**/
	#if haxe4
	static final custom:js.lib.Symbol;
	#else
	static var custom(default,never):Dynamic;
	#end
}