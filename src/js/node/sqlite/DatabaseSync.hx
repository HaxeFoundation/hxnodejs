/*
 * Copyright (C)2014-2020 Haxe Foundation
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

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import js.lib.ArrayBuffer;
import js.lib.Uint8Array;
import js.node.Sqlite.SqlitePath;
import js.node.sqlite.SQLTagStore;
import js.node.sqlite.Session as SqliteSession;
import js.node.sqlite.StatementSync;

/**
	A single synchronous connection to a SQLite database.

	@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#class-databasesync
**/
@:jsRequire("node:sqlite", "DatabaseSync")
extern class DatabaseSync {
	/**
		Constructs a new database connection.
	**/
	function new(path:SqlitePath, ?options:DatabaseSyncOptions);

	/**
		Registers an aggregate function.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaseaggregatename-options
	**/
	function aggregate(name:String, options:SqliteAggregateOptions):Void;

	/**
		Applies a binary changeset or patchset.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaseapplychangesetchangeset-options
	**/
	function applyChangeset(changeset:EitherType<ArrayBuffer, Uint8Array>, ?options:ApplyChangesetOptions):Bool;

	/**
		Closes the database connection.
	**/
	function close():Void;

	/**
		Creates and attaches a session used to track changes.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databasecreatesessionoptions
	**/
	function createSession(?options:CreateSessionOptions):SqliteSession;

	/**
		Creates an LRU cache of prepared statements (SQL tag store).

		Added in: v24.9.0

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databasecreatetagstoremaxsize
	**/
	function createTagStore(?maxSize:Int):SQLTagStore;

	/**
		Replace database contents with a serialized buffer.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databasedeserializebuffer-options
	**/
	function deserialize(buffer:EitherType<ArrayBuffer, Uint8Array>, ?options:DatabaseSerializeOptions):Void;

	/**
		Enable or disable defensive mode.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaseenabledefensiveenabled
	**/
	function enableDefensive(enabled:Bool):Void;

	/**
		Enable or disable the `loadExtension` SQL function / method.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaseenableloadextensionenabled
	**/
	function enableLoadExtension(enabled:Bool):Void;

	/**
		Execute one or more SQL statements without returning results.
	**/
	function exec(sql:String):Void;

	/**
		Registers a SQL function callable from SQL.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databasefunctionname-options-func
	**/
	@:native("function")
	@:overload(function(name:String, fn:Function):Void {})
	function function_(name:String, options:SqliteFunctionOptions, fn:Function):Void;

	/**
		Loads a shared library into the connection.
	**/
	function loadExtension(path:String, ?entryPoint:String):Void;

	/**
		Location of the database file, or `null` for in-memory databases.
	**/
	function location(?dbName:String):Null<String>;

	/**
		Opens the database when constructed with `{ open: false }`.
	**/
	function open():Void;

	/**
		Creates a new prepared statement.
	**/
	function prepare(sql:String):StatementSync;

	/**
		Serialize the database. Returns a `Uint8Array`.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaseserializedbname
	**/
	function serialize(?dbName:String):Uint8Array;

	/**
		Sets the authorizer callback used during statement compilation.
	**/
	function setAuthorizer(?callback:Null<Int->Null<String>->Null<String>->Null<String>->Null<String>->Int>):Void;
}

/**
	Options for `new DatabaseSync`.
**/
typedef DatabaseSyncOptions = {
	@:optional var open:Bool;
	@:optional var readOnly:Bool;
	@:optional var enableForeignKeyConstraints:Bool;
	@:optional var enableDoubleQuotedStringLiterals:Bool;
	@:optional var allowExtension:Bool;
	@:optional var timeout:Float;
	@:optional var readBigInts:Bool;
	@:optional var returnArrays:Bool;
	@:optional var allowBareNamedParameters:Bool;
	@:optional var allowUnknownNamedParameters:Bool;
	@:optional var defensive:Bool;
	@:optional var limits:DatabaseSyncLimits;
}

/**
	SQLite run-time limits for `DatabaseSyncOptions.limits`.
**/
typedef DatabaseSyncLimits = {
	@:optional var length:Float;
	@:optional var sqlLength:Float;
	@:optional var column:Float;
	@:optional var exprDepth:Float;
	@:optional var compoundSelect:Float;
	@:optional var vdbeOp:Float;
	@:optional var functionArg:Float;
	@:optional var attach:Float;
	@:optional var likePatternLength:Float;
	@:optional var variableNumber:Float;
	@:optional var triggerDepth:Float;
}

/**
	Options for `DatabaseSync.aggregate`.
**/
typedef SqliteAggregateOptions = {
	@:optional var deterministic:Bool;
	@:optional var directOnly:Bool;
	@:optional var useBigIntArguments:Bool;
	@:optional var varargs:Bool;
	@:optional var start:Dynamic;
	var step:Function;
	@:optional var result:Function;
	@:optional var inverse:Function;
}

/**
	Options for `DatabaseSync.function_`.
**/
typedef SqliteFunctionOptions = {
	@:optional var deterministic:Bool;
	@:optional var directOnly:Bool;
	@:optional var useBigIntArguments:Bool;
	@:optional var varargs:Bool;
}

/**
	Options for `DatabaseSync.createSession`.
**/
typedef CreateSessionOptions = {
	@:optional var table:String;
	@:optional var db:String;
}

/**
	Options for `DatabaseSync.applyChangeset`.
**/
typedef ApplyChangesetOptions = {
	@:optional var filter:String->Bool;
	@:optional var onConflict:Int->Int;
}

/**
	Options for `deserialize`.
**/
typedef DatabaseSerializeOptions = {
	@:optional var readOnly:Bool;
}
