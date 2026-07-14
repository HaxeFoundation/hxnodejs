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

package js.node.assert;

/**
	Options for `new assert.Assert([options])`.

	@see https://nodejs.org/docs/latest-v24.x/api/assert.html#new-assertassertoptions
**/
typedef AssertOptions = {
	/**
		If set to `Full`, shows the full diff in assertion errors. Defaults to `Simple`.
	**/
	@:optional var diff:AssertDiff;

	/**
		If `true`, non-strict methods behave like their corresponding strict methods.
		Defaults to `true`.
	**/
	@:optional var strict:Bool;

	/**
		If `true`, skips prototype and constructor comparison in deep equality checks.
		Defaults to `false`. Added in Node.js v24.9.0.
	**/
	@:optional var skipPrototype:Bool;
}
