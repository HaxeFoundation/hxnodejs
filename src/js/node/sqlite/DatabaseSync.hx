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

import haxe.Constraints.Function;
import js.lib.Uint8Array;
import js.node.Sqlite.SqlitePath;
import js.node.sqlite.SQLTagStore;
import js.node.sqlite.Session as SqliteSession;
import js.node.sqlite.StatementSync;

/**
	A single synchronous connection to a SQLite database.

	All APIs exposed by this class execute synchronously.
	Implements `Symbol.dispose` (closes the connection; no-op if already closed).

	@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#class-databasesync
**/
@:jsRequire("node:sqlite", "DatabaseSync")
extern class DatabaseSync {
	/**
		Constructs a new database connection.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#new-databasesyncpath-options
	**/
	function new(path:SqlitePath, ?options:DatabaseSyncOptions);

	/**
		Whether the database connection is open.
	**/
	var isOpen(default, null):Bool;

	/**
		Whether a transaction is currently active.
	**/
	var isTransaction(default, null):Bool;

	/**
		SQLite run-time limits for this connection.

		Each property can be read or written. Setting a property to `Infinity`
		resets that limit to its compile-time maximum.

		Added in: v24.15.0

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaselimits
	**/
	var limits(default, null):DatabaseSyncLimits;

	/**
		Registers an aggregate function.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaseaggregatename-options
	**/
	function aggregate(name:String, options:SqliteAggregateOptions):Void;

	/**
		Applies a binary changeset or patchset.

		`changeset` must be a `Uint8Array` (Node `Buffer` is accepted).

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaseapplychangesetchangeset-options
	**/
	function applyChangeset(changeset:Uint8Array, ?options:ApplyChangesetOptions):Bool;

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
		Replaces database contents with a serialized buffer.

		`buffer` must be a `Uint8Array` (Node `Buffer` is accepted).
		The deserialized database is writable.

		Added in: v24.16.0

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databasedeserializebuffer-options
	**/
	function deserialize(buffer:Uint8Array, ?options:DatabaseDeserializeOptions):Void;

	/**
		Enables or disables defensive mode.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaseenabledefensiveenabled
	**/
	function enableDefensive(enabled:Bool):Void;

	/**
		Enables or disables the `loadExtension` SQL function / method.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaseenableloadextensionallow
	**/
	function enableLoadExtension(enabled:Bool):Void;

	/**
		Executes one or more SQL statements without returning results.
	**/
	function exec(sql:String):Void;

	/**
		Registers a SQL function callable from SQL.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databasefunctionname-options-function
	**/
	@:native("function")
	@:overload(function(name:String, fn:Function):Void {})
	function function_(name:String, options:SqliteFunctionOptions, fn:Function):Void;

	/**
		Loads a shared library into the connection.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaseloadextensionpath-entrypoint
	**/
	function loadExtension(path:String, ?entryPoint:String):Void;

	/**
		Location of the database file, or `null` for in-memory databases.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaselocationdbname
	**/
	function location(?dbName:String):Null<String>;

	/**
		Opens the database when constructed with `{ open: false }`.
	**/
	function open():Void;

	/**
		Creates a new prepared statement.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databasepreparesql-options
	**/
	function prepare(sql:String, ?options:StatementPrepareOptions):StatementSync;

	/**
		Serializes the database. Returns a `Uint8Array`.

		Added in: v24.16.0

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databaseserializedbname
	**/
	function serialize(?dbName:String):Uint8Array;

	/**
		Sets the authorizer callback used during statement compilation.

		Pass `null` to clear the current authorizer.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#databasesetauthorizercallback
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
	@:optional var limits:DatabaseSyncLimitsOptions;
}

/**
	Partial SQLite run-time limits for `DatabaseSyncOptions.limits`.
**/
typedef DatabaseSyncLimitsOptions = {
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
	SQLite run-time limits exposed by `DatabaseSync.limits`.

	Values may be set to `Infinity` to reset a limit to its compile-time maximum.
**/
typedef DatabaseSyncLimits = {
	var length:Float;
	var sqlLength:Float;
	var column:Float;
	var exprDepth:Float;
	var compoundSelect:Float;
	var vdbeOp:Float;
	var functionArg:Float;
	var attach:Float;
	var likePatternLength:Float;
	var variableNumber:Float;
	var triggerDepth:Float;
}

/**
	Options for `DatabaseSync.aggregate`.
**/
typedef SqliteAggregateOptions = {
	@:optional var deterministic:Bool;
	@:optional var directOnly:Bool;
	@:optional var useBigIntArguments:Bool;
	@:optional var varargs:Bool;
	/**
		Identity value for the aggregation, or a function that returns it.
	**/
	var start:Any;
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
	Options for `DatabaseSync.deserialize`.
**/
typedef DatabaseDeserializeOptions = {
	/**
		Name of the database to deserialize into. Default: `"main"`.
	**/
	@:optional var dbName:String;
}

/**
	Options for `DatabaseSync.prepare`.

	When omitted, values inherit from the corresponding `DatabaseSync` options.
**/
typedef StatementPrepareOptions = {
	@:optional var readBigInts:Bool;
	@:optional var returnArrays:Bool;
	@:optional var allowBareNamedParameters:Bool;
	@:optional var allowUnknownNamedParameters:Bool;
}
