/*
 * Copyright (C)2014-2015 Haxe Foundation
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
	function normalize(p:String):String;
	function join(paths:haxe.extern.Rest<String>):String;
	@:overload(function(args:haxe.extern.Rest<String>):String {})
	@:overload(function(from:String, to:String):String {})
	function resolve(to:String):String;
	function isAbsolute(path:String):Bool;
	function relative(from:String, to:String):String;
	function dirname(p:String):String;
	function basename(p:String, ?ext:String):String;
	function extname(p:String):String;
	var sep(default,null):String;
	var delimiter(default,null):String;
	function parse(pathString:String):PathObject;
	function format(pathObject:PathObject):String;
}


/**
	This module contains utilities for handling and transforming file paths.
	Almost all these methods perform only string transformations.
	The file system is not consulted to check whether paths are valid.
**/
@:jsRequire("path")
extern class Path {
	/**
		Normalize a string path, taking care of '..' and '.' parts.

		When multiple slashes are found, they're replaced by a single one;
		when the path contains a trailing slash, it is preserved.
		On Windows backslashes are used.
	**/
	static function normalize(p:String):String;

	/**
		Join all arguments together and normalize the resulting path.
	**/
	static function join(paths:haxe.extern.Rest<String>):String;

	/**
		Resolves to to an absolute path.

		If `to` isn't already absolute `from` arguments are prepended in right to left order,
		until an absolute path is found. If after using all from paths still no absolute
		path is found, the current working directory is used as well. The resulting path is
		normalized, and trailing slashes are removed unless the path gets resolved to the
		root directory.
	**/
	@:overload(function(args:haxe.extern.Rest<String>):String {})
	@:overload(function(from:String, to:String):String {})
	static function resolve(to:String):String;

	/**
		Determines whether `path` is an absolute path.

		An absolute path will always resolve to the same location, regardless of the working directory.
	**/
	static function isAbsolute(path:String):Bool;

	/**
		Solve the relative path from from to to.
	**/
	static function relative(from:String, to:String):String;

	/**
		Return the directory name of a path. Similar to the Unix dirname command.
	**/
	static function dirname(p:String):String;

	/**
		Return the last portion of a path. Similar to the Unix basename command.
	**/
	static function basename(p:String, ?ext:String):String;

	/**
		Return the extension of the path, from the last '.' to end of string in the last portion of the path.
		If there is no '.' in the last portion of the path or the first character of it is '.',
		then it returns an empty string.
	**/
	static function extname(p:String):String;

	/**
		The platform-specific file separator. '\\' or '/'.
	**/
	static var sep(default,null):String;

	/**
		The platform-specific path delimiter, ; or ':'.
	**/
	static var delimiter(default,null):String;

	/**
		Returns an object from a path string.
	**/
	static function parse(pathString:String):PathObject;

	/**
		Returns a path string from an object, the opposite of `Path.parse` above.
	**/
	static function format(pathObject:PathObject):String;

	/**
		Provide access to aforementioned path methods but always interact in a posix compatible way.
	**/
	static var posix:PathModule;

	/**
		Provide access to aforementioned path methods but always interact in a win32 compatible way.
	**/
	static var win32:PathModule;
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
