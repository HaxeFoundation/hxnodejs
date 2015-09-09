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

import haxe.DynamicAccess;
import haxe.extern.Rest;
import js.node.stream.Readable;
import js.node.stream.Writable;

/**
	The util module is primarily designed to support the needs of node.js's internal APIs.
	Many of these utilities are useful for your own programs. If you find that these functions
	are lacking for your purposes, however, you are encouraged to write your own utilities.
	We are not interested in any future additions to the util module that are unnecessary
	for node.js's internal functionality.
**/
@:jsRequire("util")
extern class Util {

	/**
		This is used to create a function which conditionally writes to stderr based on the existence of a NODE_DEBUG
		environment variable.

		If the `section` name appears in that environment variable, then the returned function will be similar
		to `Console.error`. If not, then the returned function is a no-op.

		You may separate multiple NODE_DEBUG environment variables with a comma. For example, NODE_DEBUG=fs,net,tls.
	**/
	static function debuglog(section:String):Rest<Dynamic>->Void;

	/**
		Returns a formatted string using the first argument as a printf-like format.

		The first argument is a string that contains zero or more placeholders.
		Each placeholder is replaced with the converted value from its corresponding argument.
		Supported placeholders are:
			%s - String.
			%d - Number (both integer and float).
			%j - JSON.
			% - single percent sign ('%'). This does not consume an argument.
		If the placeholder does not have a corresponding argument, the placeholder is not replaced.

		If there are more arguments than placeholders, the extra arguments are converted to strings with `inspect`
		and these strings are concatenated, delimited by a space.

		If the first argument is not a format string then `format` returns a string that is the concatenation of
		all its arguments separated by spaces. Each argument is converted to a string with `inspect`.
	**/
	@:overload(function(args:Rest<Dynamic>):String {})
	static function format(format:String, args:Rest<Dynamic>):String;

	/**
		Output with timestamp on stdout.
	**/
	static function log(args:Rest<Dynamic>):Void;

	/**
		Return a string representation of `object`, which is useful for debugging.
		An optional `options` object may be passed that alters certain aspects of the formatted string.

		Objects also may define their own `inspect(depth:Int)` function which `inspect` will invoke and
		use the result of when inspecting the object.
	**/
	static function inspect(object:Dynamic, ?options:InspectOptions):String;

	/**
		Returns true if the given "object" is an Array. false otherwise.
	**/
	@:deprecated
	static function isArray(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a RegExp. false otherwise.
	**/
	@:deprecated
	static function isRegExp(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a Date. false otherwise.
	**/
	@:deprecated
	static function isDate(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is an Error. false otherwise.
	**/
	@:deprecated
	static function isError(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a Bool. false otherwise.
	**/
	@:deprecated
	static function isBoolean(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is strictly null. false otherwise.
	**/
	@:deprecated
	static function isNull(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is null or undefined. false otherwise.
	**/
	@:deprecated
	static function isNullOrUndefined(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a Float. false otherwise.
	**/
	@:deprecated
	static function isNumber(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a String. false otherwise.
	**/
	@:deprecated
	static function isString(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a Symbol. false otherwise.
	**/
	@:deprecated
	static function isSymbol(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is undefined. false otherwise.
	**/
	@:deprecated
	static function isUndefined(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is strictly an Object and not a Function. false otherwise.
	**/
	@:deprecated
	static function isObject(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a Function. false otherwise.
	**/
	@:deprecated
	static function isFunction(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a primitive type. false otherwise.
	**/
	@:deprecated
	static function isPrimitive(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a Buffer. false otherwise.
	**/
	@:deprecated
	static function isBuffer(object:Dynamic):Bool;

	/**
		Inherit the prototype methods from one constructor into another.
		The prototype of constructor will be set to a new object created from superConstructor.

		As an additional convenience, superConstructor will be accessible through the constructor.`super_` property.
	**/
	static function inherits(constructor:Class<Dynamic>, superConstructor:Class<Dynamic>):Bool;

	/**
		Marks that a method should not be used any more.
		
		It returns a modified function which warns once by default.
	**/
	static function deprecate<T:haxe.Constraints.Function>(fun:T, string:String):T;

	/**
		Deprecated predecessor of `Console.error`.
	**/
	@:deprecated("Use js.Node.console.error instead")
	static function debug(string:String):Void;

	/**
		Deprecated predecessor of console.error.
	**/
	@:deprecated("Use js.Node.console.error instead")
	static function error(args:Rest<Dynamic>):Void;

	/**
		Deprecated predecessor of console.log.
	**/
	@:deprecated("Use js.Node.console.log instead")
	static function puts(args:Rest<Dynamic>):Void;

	/**
		Deprecated predecessor of console.log.
	**/
	@:deprecated("Use js.Node.console.log instead")
	static function print(args:Rest<Dynamic>):Void;

	/**
		Deprecated predecessor of stream.pipe().
	**/
	@:deprecated("Use `readableStream.pipe(writableStream)` instead")
	static function pump(readableStream:IReadable, writableStream:IWritable, ?callback:js.Error->Void):Void;

}

/**
	Options object used by `Util.inspect`.
**/
typedef InspectOptionsBase = {
	/**
		if true then the object's non-enumerable properties will be shown too.
		Defaults to false.
	**/
	@:optional var showHidden:Bool;

	/**
		Tells `Util.inspect` how many times to recurse while formatting the object.
		This is useful for inspecting large complicated objects.
		Defaults to 2. To make it recurse indefinitely pass `null`.
	**/
	@:optional var depth:Null<Int>;

	/**
		if true, then the output will be styled with ANSI color codes.
		Defaults to false.
		Colors are customizable globally via `js.node.util.Inspect.styles` and `js.node.util.Inspect.colors` objects.
	**/
	@:optional var colors:Bool;
}

typedef InspectOptions = {
	>InspectOptionsBase,

	/**
		if false, then custom `inspect` functions defined on the objects being inspected won't be called.
		Defaults to true.
	**/
	@:optional var customInspect:Bool;
}
