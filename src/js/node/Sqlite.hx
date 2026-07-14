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

package js.node;

import haxe.extern.EitherType;
import js.lib.Promise;
import js.node.Buffer;
import js.node.sqlite.DatabaseSync;
import js.node.url.URL;

/**
	The `node:sqlite` module facilitates working with SQLite databases.

	Stability: 1.2 - Release candidate.

	Available only under the `node:` scheme.

	@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html
**/
@:jsRequire("node:sqlite")
extern class Sqlite {
	/**
		Constants used by authorizer callbacks and changeset conflict handlers.
	**/
	static var constants(default, never):SqliteConstants;

	/**
		Makes a backup of `sourceDb` to `path`.

		Returns a promise that fulfills with the total number of backed-up pages.

		@see https://nodejs.org/docs/latest-v24.x/api/sqlite.html#sqlitebackupsourcedb-path-options
	**/
	static function backup(sourceDb:DatabaseSync, path:SqlitePath, ?options:SqliteBackupOptions):Promise<Float>;
}

/**
	Path accepted by SQLite open / backup APIs (`string`, `Buffer`, or `URL`).
**/
typedef SqlitePath = EitherType<String, EitherType<Buffer, URL>>;

/**
	Options for `Sqlite.backup`.
**/
typedef SqliteBackupOptions = {
	/**
		Name of the source database. Default: `"main"`.
	**/
	@:optional var source:String;

	/**
		Name of the target database. Default: `"main"`.
	**/
	@:optional var target:String;

	/**
		Number of pages transmitted in each backup batch. Default: `100`.
	**/
	@:optional var rate:Int;

	/**
		Called after each backup step with progress information.
	**/
	@:optional var progress:SqliteBackupProgress->Void;
}

/**
	Progress info passed to `SqliteBackupOptions.progress`.
**/
typedef SqliteBackupProgress = {
	var totalPages:Float;
	var remainingPages:Float;
}

/**
	Constants exported by `node:sqlite` (`Sqlite.constants`).

	Includes authorizer action codes, authorizer results, and changeset conflict codes.
**/
typedef SqliteConstants = {
	var SQLITE_OK(default, never):Int;
	var SQLITE_DENY(default, never):Int;
	var SQLITE_IGNORE(default, never):Int;

	var SQLITE_CHANGESET_OMIT(default, never):Int;
	var SQLITE_CHANGESET_REPLACE(default, never):Int;
	var SQLITE_CHANGESET_ABORT(default, never):Int;
	var SQLITE_CHANGESET_DATA(default, never):Int;
	var SQLITE_CHANGESET_NOTFOUND(default, never):Int;
	var SQLITE_CHANGESET_CONFLICT(default, never):Int;
	var SQLITE_CHANGESET_CONSTRAINT(default, never):Int;
	var SQLITE_CHANGESET_FOREIGN_KEY(default, never):Int;

	var SQLITE_CREATE_INDEX(default, never):Int;
	var SQLITE_CREATE_TABLE(default, never):Int;
	var SQLITE_CREATE_TEMP_INDEX(default, never):Int;
	var SQLITE_CREATE_TEMP_TABLE(default, never):Int;
	var SQLITE_CREATE_TEMP_TRIGGER(default, never):Int;
	var SQLITE_CREATE_TEMP_VIEW(default, never):Int;
	var SQLITE_CREATE_TRIGGER(default, never):Int;
	var SQLITE_CREATE_VIEW(default, never):Int;
	var SQLITE_DELETE(default, never):Int;
	var SQLITE_DROP_INDEX(default, never):Int;
	var SQLITE_DROP_TABLE(default, never):Int;
	var SQLITE_DROP_TEMP_INDEX(default, never):Int;
	var SQLITE_DROP_TEMP_TABLE(default, never):Int;
	var SQLITE_DROP_TEMP_TRIGGER(default, never):Int;
	var SQLITE_DROP_TEMP_VIEW(default, never):Int;
	var SQLITE_DROP_TRIGGER(default, never):Int;
	var SQLITE_DROP_VIEW(default, never):Int;
	var SQLITE_INSERT(default, never):Int;
	var SQLITE_PRAGMA(default, never):Int;
	var SQLITE_READ(default, never):Int;
	var SQLITE_SELECT(default, never):Int;
	var SQLITE_TRANSACTION(default, never):Int;
	var SQLITE_UPDATE(default, never):Int;
	var SQLITE_ATTACH(default, never):Int;
	var SQLITE_DETACH(default, never):Int;
	var SQLITE_ALTER_TABLE(default, never):Int;
	var SQLITE_REINDEX(default, never):Int;
	var SQLITE_ANALYZE(default, never):Int;
	var SQLITE_CREATE_VTABLE(default, never):Int;
	var SQLITE_DROP_VTABLE(default, never):Int;
	var SQLITE_FUNCTION(default, never):Int;
	var SQLITE_SAVEPOINT(default, never):Int;
	var SQLITE_COPY(default, never):Int;
	var SQLITE_RECURSIVE(default, never):Int;
}
