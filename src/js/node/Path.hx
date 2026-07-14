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

/**
	The `path` module provides utilities for working with file and directory paths.

	@see https://nodejs.org/docs/latest-v24.x/api/path.html#path_path
**/
@:jsRequire("path")
extern class Path {
	/**
		The `path.basename()` methods returns the last portion of a `path`, similar to the Unix `basename` command. Trailing directory separators are ignored, see path.sep.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#path_path_basename_path_ext
	**/
	static function basename(path:String, ?ext:String):String;

	/**
		Platform-specific path delimiter:

		`;` for Windows
		`:` for POSIX

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#path_path_delimiter
	**/
	static final delimiter:String;

	/**
		The `path.dirname()` method returns the directory name of a `path`, similar to the Unix `dirname` command. Trailing directory separators are ignored, see path.sep.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathdirnamepath
	**/
	static function dirname(path:String):String;

	/**
		The `path.extname()` method returns the extension of the `path`, from the last occurrence of the `.` (period) character to end of string in the last portion of the `path`.
		If there is no `.` in the last portion of the `path`, or if there are no `.` characters other than the first character of the basename of `path` (see `path.basename()`) ,
		an empty string is returned.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathextnamepath
	**/
	static function extname(path:String):String;

	/**
		The path.format() method returns a path string from an object. This is the opposite of path.parse().

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathformatpathobject
	**/
	static function format(pathObject:PathObject):String;

	/**
		The `path.isAbsolute()` method determines if `path` is an absolute path.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathisabsolutepath
	**/
	static function isAbsolute(path:String):Bool;

	/**
		The `path.join()` method joins all given `path` segments together using the platform-specific separator as a delimiter, then normalizes the resulting path.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathjoinpaths
	**/
	static function join(paths:haxe.extern.Rest<String>):String;

	/**
		The `path.matchesGlob()` method determines if `path` matches the `pattern`.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathmatchesglobpath-pattern
	**/
	static function matchesGlob(path:String, pattern:String):Bool;

	/**
		The `path.normalize()` method normalizes the given `path`, resolving `'..'` and `'.'` segments.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathnormalizepath
	**/
	static function normalize(path:String):String;

	/**
		The `path.parse()` method returns an object whose properties represent significant elements of the `path`. Trailing directory separators are ignored, see path.sep.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathparsepath
	**/
	static function parse(path:String):PathObject;

	/**
		The `path.posix` property provides access to POSIX specific implementations of the `path` methods.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathposix
	**/
	static final posix:PathModule;

	/**
		The `path.relative()` method returns the relative path from `from` to `to` based on the current working directory.
		If `from` and `to` each resolve to the same path (after calling path.resolve() on each), a zero-length string is returned.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathrelativefrom-to
	**/
	static function relative(from:String, to:String):String;

	/**
		The `path.resolve()` method resolves a sequence of paths or path segments into an absolute path.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathresolvepaths
	**/
	static function resolve(paths:haxe.extern.Rest<String>):String;

	/**
		Provides the platform-specific path segment separator:

		`\` on Windows
		`/` on POSIX

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathsep
	**/
	static final sep:String;

	/**
		On Windows systems only, returns an equivalent namespace-prefixed path for the given `path`. If `path` is not a string, `path` will be returned without modifications.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathtonamespacedpathpath
	**/
	static function toNamespacedPath(path:String):String;

	/**
		The path.win32 property provides access to Windows-specific implementations of the path methods.

		@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathwin32
	**/
	static final win32:PathModule;
}

/**
	Path object returned from `Path.parse` and taken by `Path.format`.

	Fields are optional when used as input to `Path.format` (Node accepts a partial object).

	@see https://nodejs.org/docs/latest-v24.x/api/path.html#pathformatpathobject
**/
typedef PathObject = {
	/**
		E.g. "C:\path\dir" for "C:\path\dir\index.html"
	**/
	@:optional var dir:String;

	/**
		E.g. "C:\" for "C:\path\dir\index.html"
	**/
	@:optional var root:String;

	/**
		E.g. "index.html" for "C:\path\dir\index.html"
	**/
	@:optional var base:String;

	/**
		E.g. "index" for "C:\path\dir\index.html"
	**/
	@:optional var name:String;

	/**
		E.g. ".html" for "C:\path\dir\index.html"
	**/
	@:optional var ext:String;
}

// IMPORTANT: this structure should contain a set of fields
// matching statics of the `Path` class and is used as a type
// for `posix` and `win32` fields of `Path` class.
// We should probably generate this from a macro, but let's keep
// things simple for now.
private typedef PathModule = {
	function normalize(path:String):String;
	function join(paths:haxe.extern.Rest<String>):String;
	function resolve(paths:haxe.extern.Rest<String>):String;
	function isAbsolute(path:String):Bool;
	function relative(from:String, to:String):String;
	function dirname(path:String):String;
	function basename(path:String, ?ext:String):String;
	function extname(path:String):String;
	function matchesGlob(path:String, pattern:String):Bool;
	final sep:String;
	final delimiter:String;
	function parse(pathString:String):PathObject;
	function format(pathObject:PathObject):String;
	function toNamespacedPath(path:String):String;
}
