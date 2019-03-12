/*
 * Copyright (C)2014-2019 Haxe Foundation
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
	var sep(default,null):String;
	var delimiter(default,null):String;
	function parse(pathString:String):PathObject;
	function format(pathObject:PathObject):String;
}


/**
	This module provides utilities for working with file and directory paths.
**/
@:jsRequire("path")
extern class Path {
	/**
		Normalizes the given `path`, resolving '..' and '.' segments.

		When multiple, sequential path segment separation characters are found (e.g. `/` on POSIX and `\` on Windows),
		they are replaced by a single instance of the platform specific path segment separator.
		Trailing separators are preserved.

		If the `path` is a zero-length string, '.' is returned, representing the current working directory.
	**/
	static function normalize(path:String):String;

	/**
		Joins all given `path` segments together using the platform specific separator as a delimiter,
		then normalizes the resulting path.

		Zero-length `path` segments are ignored. If the joined path string is a zero-length string
		then '.' will be returned, representing the current working directory.
	**/
	static function join(paths:haxe.extern.Rest<String>):String;

	/**
		Resolves a sequence of paths or path segments into an absolute path.

		The given sequence of paths is processed from right to left, with each subsequent path prepended
		until an absolute path is constructed. For instance, given the sequence of path segments: `/foo`, `/bar`, `baz`,
		calling `resolve('/foo', '/bar', 'baz')` would return `/bar/baz`.

		If after processing all given path segments an absolute path has not yet been generated,
		the current working directory is used.

		The resulting path is normalized and trailing slashes are removed unless the path is resolved to the root directory.

		Zero-length path segments are ignored.

		If no path segments are passed, `resolve` will return the absolute path of the current working directory.
	**/
	static function resolve(paths:haxe.extern.Rest<String>):String;

	/**
		Determines if path is an absolute path.

		If the given `path` is a zero-length string, false will be returned.
	**/
	static function isAbsolute(path:String):Bool;

	/**
		Returns the relative path from `from` to `to`.

		If `from` and `to` each resolve to the same path (after calling `resolve` on each), a zero-length string is returned.

		If a zero-length string is passed as `from` or `to`, the current working directory will be used
		instead of the zero-length strings.
	**/
	static function relative(from:String, to:String):String;

	/**
		Return the directory name of a `path`. Similar to the Unix `dirname` command.
	**/
	static function dirname(path:String):String;

	/**
		Return the last portion of a `path`. Similar to the Unix `basename` command.
	**/
	static function basename(path:String, ?ext:String):String;

	/**
		Return the extension of the `path`, from the last '.' (period) to end of string in the last portion of the `path`.
		If there is no '.' in the last portion of the `path` or the first character of it is '.',
		then it returns an empty string.
	**/
	static function extname(path:String):String;

	/**
		Platform-specific path segment separator:

		`\` on Windows
		`/` on POSIX
	**/
	static var sep(default,null):String;

	/**
		Platform-specific path delimiter:

		`;` for Windows
		`:` for POSIX
	**/
	static var delimiter(default,null):String;

	/**
		Returns an object whose properties represent significant elements of the `path`.
	**/
	static function parse(path:String):PathObject;

	/**
		Returns a path string from an object, the opposite of `Path.parse` above.
	**/
	static function format(pathObject:PathObject):String;

	/**
		Provides access to POSIX specific implementations of the path methods.
	**/
	static var posix(default,null):PathModule;

	/**
		Provides access to Windows-specific implementations of the path methods.

		Note: On Windows, both the forward slash (/) and backward slash (\) characters are accepted as path delimiters;
		however, only the backward slash (\) will be used in return values.
	**/
	static var win32(default,null):PathModule;
}


/**
	Path object returned from `Path.parse` and taken by `Path.format`.
**/
typedef PathObject = {
	/**
		E.g. "C:\" for "C:\path\dir\index.html"
	**/
	var root:String;

	/**
		E.g. "C:\path\dir" for "C:\path\dir\index.html"
	**/
	var dir:String;

	/**
		E.g. "index.html" for "C:\path\dir\index.html"
	**/
	var base:String;

	/**
		E.g. ".html" for "C:\path\dir\index.html"
	**/
	var ext:String;

	/**
		E.g. "index" for "C:\path\dir\index.html"
	**/
	var name:String;
}
