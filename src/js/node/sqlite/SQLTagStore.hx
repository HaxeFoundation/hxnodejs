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

package js.node.sqlite;

import haxe.extern.Rest;
import js.node.Iterator;
import js.node.sqlite.StatementSync.StatementResult;

/**
	LRU cache of prepared statements created via `DatabaseSync.createTagStore()`.

	Tagged-template call sites pass a `string[]` of template elements followed by
	bound values (Node's template-tag convention). Not constructible directly;
	not exported from `node:sqlite` (created only via `DatabaseSync.createTagStore()`).

	Added in: v24.9.0

	@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#class-sqltagstore
**/
extern class SQLTagStore {
	/**
		Number of prepared statements currently in the cache.
	**/
	var size(default, null):Int;

	/**
		Maximum number of prepared statements the cache can hold.
	**/
	var capacity(default, null):Int;

	/**
		The `DatabaseSync` associated with this store.
	**/
	var db(default, null):DatabaseSync;

	/**
		Executes the query and returns all rows (template-tag style).
	**/
	function all(strings:Array<String>, values:Rest<Any>):Array<Any>;

	/**
		Executes the query and returns the first row (template-tag style).
	**/
	function get(strings:Array<String>, values:Rest<Any>):Null<Any>;

	/**
		Executes the query and iterates rows (template-tag style).
	**/
	function iterate(strings:Array<String>, values:Rest<Any>):Iterator<Any>;

	/**
		Executes a mutating statement (template-tag style).
	**/
	function run(strings:Array<String>, values:Rest<Any>):StatementResult;

	/**
		Clears all cached prepared statements.
	**/
	function clear():Void;
}
