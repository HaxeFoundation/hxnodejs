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
	Web Storage API `Storage` interface used by `localStorage` / `sessionStorage`.

	Stability: 1.2 - Release candidate. Enable with `--experimental-webstorage`.
	`localStorage` persists to the file given by `--localstorage-file`.

	Also available as `js.Node.localStorage` and `js.Node.sessionStorage`.

	@see https://nodejs.org/api/globals.html#class-storage
	@see https://nodejs.org/api/globals.html#localstorage
**/
@:native("Storage")
extern class Storage {
	var length(default, null):Int;

	function key(index:Int):Null<String>;
	function getItem(key:String):Null<String>;
	function setItem(key:String, value:String):Void;
	function removeItem(key:String):Void;
	function clear():Void;
}
