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

/**
	A prepared statement created via `DatabaseSync.prepare()`.

	Cannot be constructed directly. All APIs execute synchronously.

	@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#class-statementsync
**/
@:jsRequire("node:sqlite", "StatementSync")
extern class StatementSync {
	/**
		Source SQL with parameter placeholders replaced by the most recent bound values.
	**/
	var expandedSQL(default, null):String;

	/**
		Source SQL used to create this prepared statement.
	**/
	var sourceSQL(default, null):String;

	/**
		Executes the statement and returns all result rows.

		Accepts an optional named-parameters object followed by anonymous bind values
		(Node's `all([namedParameters][, ...anonymousParameters])`).

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#statementallnamedparameters-anonymousparameters
	**/
	function all(args:Rest<Any>):Array<Any>;

	/**
		Column metadata for the prepared statement result set.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#statementcolumns
	**/
	function columns():Array<StatementColumnInfo>;

	/**
		Executes the statement and returns the first result row, or `undefined`.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#statementgetnamedparameters-anonymousparameters
	**/
	function get(args:Rest<Any>):Null<Any>;

	/**
		Executes the statement and returns an iterator of result rows.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#statementiteratenamedparameters-anonymousparameters
	**/
	function iterate(args:Rest<Any>):Iterator<Any>;

	/**
		Executes a mutating statement and returns a change summary.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#statementrunnamedparameters-anonymousparameters
	**/
	function run(args:Rest<Any>):StatementResult;

	/**
		Allows binding named parameters without the SQL prefix character.
	**/
	function setAllowBareNamedParameters(enabled:Bool):Void;

	/**
		Ignores unknown named parameters when binding.
	**/
	function setAllowUnknownNamedParameters(enabled:Bool):Void;

	/**
		When enabled, `all` / `get` / `iterate` return rows as arrays.
	**/
	function setReturnArrays(enabled:Bool):Void;

	/**
		When enabled, `INTEGER` columns are read as JavaScript BigInt values.

		Typed loosely until hxnodejs exposes a `BigInt` type.
	**/
	function setReadBigInts(enabled:Bool):Void;
}

/**
	Result of `StatementSync.run` / `SQLTagStore.run`.
**/
typedef StatementResult = {
	/**
		Rows modified. Number or BigInt depending on statement configuration.
	**/
	var changes:Any;

	/**
		Most recently inserted rowid. Number or BigInt depending on configuration.
	**/
	var lastInsertRowid:Any;
}

/**
	Column metadata from `StatementSync.columns`.
**/
typedef StatementColumnInfo = {
	var name:String;
	var column:Null<String>;
	var database:Null<String>;
	var table:Null<String>;
	var type:Null<String>;
}
