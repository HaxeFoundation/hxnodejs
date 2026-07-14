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

import js.lib.Promise;

/**
	Web Locks API (`navigator.locks`). Node.js exposes a partial implementation.

	Not constructed as a global class; obtained via `navigator.locks`.

	@see https://nodejs.org/api/globals.html#navigatorlocks
**/
extern class LockManager {
	/**
		Requests a lock and runs `callback` while holding it.
	**/
	@:overload(function(name:String, options:LockOptions, callback:Lock->Any):Promise<Any> {})
	function request(name:String, callback:Lock->Any):Promise<Any>;

	/**
		Returns a promise for a snapshot of held and pending locks.
	**/
	function query():Promise<LockManagerSnapshot>;
}

/**
	Options for `LockManager.request`.
**/
typedef LockOptions = {
	@:optional var mode:String;
	@:optional var ifAvailable:Bool;
	@:optional var steal:Bool;
	@:optional var signal:AbortSignal;
}

/**
	A held lock passed to the `LockManager.request` callback.
**/
typedef Lock = {
	var name(default, null):String;
	var mode(default, null):String;
}

/**
	Result of `LockManager.query()`.
**/
typedef LockManagerSnapshot = {
	var held:Array<Lock>;
	var pending:Array<Lock>;
}
