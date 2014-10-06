package js.node;

/**
 * This module contains utilities for handling and transforming file paths.
 * Almost all these methods perform only string transformations.
 * The file system is not consulted to check whether paths are valid.
 */
@:jsRequire("path")
extern class Path
{
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
	static function join(paths:haxe.Rest<String>):String;


	/**
		Resolves to to an absolute path.

		If `to` isn't already absolute `from` arguments are prepended in right to left order,
		until an absolute path is found. If after using all from paths still no absolute
		path is found, the current working directory is used as well. The resulting path is
		normalized, and trailing slashes are removed unless the path gets resolved to the
		root directory.
	**/
	@:overload(function(args:haxe.Rest<String>):String {}) // TODO: (it's actually "from:haxe.Rest<String>, to:String")
	@:overload(function(from:String, to:String):String {})
	static function resolve(to:String):String;

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
}
