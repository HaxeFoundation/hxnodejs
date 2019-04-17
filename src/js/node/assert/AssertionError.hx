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
package js.node.assert;

#if haxe4
import js.lib.Error;
#else
import js.Error;
#end

typedef AssertionErrorOptions = {
	@:optional var actual:Dynamic;
	@:optional var expected:Dynamic;
	#if (haxe_ver < 4)
	@:optional var operator:String;
	#end
	@:optional var message:String;
	@:optional var stackStartFunction:Dynamic;
}

@:jsRequire("assert", "AssertionError")
extern class AssertionError extends Error {
	var actual:Dynamic;
	var expected:Dynamic;
	@:native("operator") var operator_:String;
	var generatedMessage:Bool;
	function new(options:AssertionErrorOptions);
}
