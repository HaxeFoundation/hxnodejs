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

/**
	A partial browser-compatible `Navigator` implementation exposed as the
	`navigator` global in Node.js.

	Also available as `js.Node.navigator`.

	@see https://nodejs.org/api/globals.html#class-navigator
	@see https://nodejs.org/api/globals.html#navigator
**/
@:native("Navigator")
extern class Navigator {
	/**
		The number of logical processors available.
	**/
	var hardwareConcurrency(default, null):Int;

	/**
		The Web Locks API interface.
	**/
	var locks(default, null):LockManager;

	/**
		Preferred language of the Node.js instance.
	**/
	var language(default, null):String;

	/**
		An array of preferred languages.
	**/
	var languages(default, null):Array<String>;

	/**
		The user agent of this Node.js instance.
	**/
	var userAgent(default, null):String;

	/**
		The platform of this Node.js instance.
	**/
	var platform(default, null):String;
}
