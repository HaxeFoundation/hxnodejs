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

import haxe.Constraints.Function;
import haxe.extern.Rest;
import haxe.extern.EitherType;
import js.node.stream.Readable;
import js.node.stream.Writable;
#if haxe4
import js.lib.Error;
import js.lib.Promise;
#else
import js.Error;
import js.Promise;
#end

/**
	The util module is primarily designed to support the needs of Node.js' own internal APIs.

	@see https://nodejs.org/api/util.html#util_util
**/
@:jsRequire("util")
extern class Util {
	/**
		Takes an async function (or a function that returns a `Promise`) and returns a function following the
		error-first callback style.

		@see https://nodejs.org/api/util.html#util_util_callbackify_original
	**/
	static function callbackify(original:Function, args:Rest<Dynamic>):Null<Error>->Null<Dynamic>->Void;

	/**
		The `util.debuglog()` method is used to create a function that conditionally writes debug messages to `stderr`
		based on the existence of the `NODE_DEBUG` environment variable.

		@see https://nodejs.org/api/util.html#util_util_debuglog_section
	**/
	static function debuglog(section:String):Rest<Dynamic>->Void;

	/**
		The `util.deprecate()` method wraps fn (which may be a function or class) in such a way that it is marked as
		deprecated.

		@see https://nodejs.org/api/util.html#util_util_deprecate_fn_msg_code
	**/
	static function deprecate<T:haxe.Constraints.Function>(fun:T, msg:String, ?code:String):T;

	/**
		The `util.format()` method returns a formatted string using the first argument as a `printf`-like format string
		which can contain zero or more format specifiers.

		@see https://nodejs.org/api/util.html#util_util_format_format_args
	**/
	@:overload(function(args:Rest<Dynamic>):String {})
	static function format(format:String, args:Rest<Dynamic>):String;

	/**
		This function is identical to `util.format()`, except in that it takes an `inspectOptions` argument which
		specifies options that are passed along to `util.inspect()`.

		@see https://nodejs.org/api/util.html#util_util_formatwithoptions_inspectoptions_format_args
	**/
	@:overload(function(inspectOptions:InspectOptions, args:Rest<Dynamic>):String {})
	static function formatWithOptions(inspectOptions:InspectOptions, format:String, args:Rest<Dynamic>):String;

	/**
		Returns the string name for a numeric error code that comes from a Node.js API.

		@see https://nodejs.org/api/util.html#util_util_getsystemerrorname_err
	**/
	static function getSystemErrorName(err:Int):String;

	/**
		Inherit the prototype methods from one constructor into another.

		@see https://nodejs.org/api/util.html#util_util_inherits_constructor_superconstructor
	**/
	@:deprecated
	static function inherits(constructor:Class<Dynamic>, superConstructor:Class<Dynamic>):Void;

	/**
		The `util.inspect()` method returns a string representation of `object` that is intended for debugging.

		@see https://nodejs.org/api/util.html#util_util_inspect_object_options
	**/
	@:overload(function(object:Dynamic, ?showHidden:Bool, ?depth:Int, ?colors:Bool):String {})
	static function inspect(object:Dynamic, ?options:InspectOptions):String;

	/**
		Returns `true` if there is deep strict equality between `val1` and `val2`.

		@see https://nodejs.org/api/util.html#util_util_isdeepstrictequal_val1_val2
	**/
	static function isDeepStrictEqual(val1:Dynamic, val2:Dynamic):Bool;

	/**
		Takes a function following the common error-first callback style, i.e. taking an `(err, value) => ...` callback
		as the last argument, and returns a version that returns promises.

		@see https://nodejs.org/api/util.html#util_util_promisify_original
	**/
	static function promisify(original:Function):Rest<Dynamic>->Promise<Dynamic>;

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
		Returns true if the given "object" is an Array. false otherwise.
	**/
	@:deprecated
	static function isArray(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a Bool. false otherwise.
	**/
	@:deprecated
	static function isBoolean(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a Buffer. false otherwise.
	**/
	@:deprecated
	static function isBuffer(object:Dynamic):Bool;

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
		Returns true if the given "object" is a Function. false otherwise.
	**/
	@:deprecated
	static function isFunction(object:Dynamic):Bool;

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
		Returns true if the given "object" is strictly an Object and not a Function. false otherwise.
	**/
	@:deprecated
	static function isObject(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a primitive type. false otherwise.
	**/
	@:deprecated
	static function isPrimitive(object:Dynamic):Bool;

	/**
		Returns true if the given "object" is a RegExp. false otherwise.
	**/
	@:deprecated
	static function isRegExp(object:Dynamic):Bool;

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
		Output with timestamp on stdout.
	**/
	@:deprecated
	static function log(args:Rest<Dynamic>):Void;

	/**
		Deprecated predecessor of console.log.
	**/
	@:deprecated("Use js.Node.console.log instead")
	static function print(args:Rest<Dynamic>):Void;

	/**
		Deprecated predecessor of console.log.
	**/
	@:deprecated("Use js.Node.console.log instead")
	static function puts(args:Rest<Dynamic>):Void;

	/**
		Deprecated predecessor of stream.pipe().
	**/
	@:deprecated("Use `readableStream.pipe(writableStream)` instead")
	static function pump(readableStream:IReadable, writableStream:IWritable, ?callback:Error->Void):Void;
}

/**
	Options object used by `Util.inspect`.
**/
typedef InspectOptionsBase = {
	/**
		If `true`, the `object`'s non-enumerable symbols and properties will be included in the formatted result
		as well as WeakMap and WeakSet entries.

		Default: false.
	**/
	@:optional var showHidden:Bool;

	/**
		Specifies the number of times to recurse while formatting the `object`.
		This is useful for inspecting large complicated objects.
		To make it recurse up to the maximum call stack size pass `Math.POSITIVE_INFINITY` or `null`.

		Default: 2.
	**/
	@:optional var depth:Null<Int>;

	/**
		If `true`, then the output will be styled with ANSI color codes.

		Default: false.
	**/
	@:optional var colors:Bool;
}

typedef InspectOptions = {
	> InspectOptionsBase,

	/**
		If `false`, then custom `inspect(depth, opts)` functions will not be called.

		Default: true.
	**/
	@:optional var customInspect:Bool;

	/**
		If `true`, then objects and functions that are Proxy objects will be introspected to show their `target` and `handler` objects.

		Default: false.
	**/
	@:optional var showProxy:Bool;

	/**
		Specifies the maximum number of Array, TypedArray, WeakMap and WeakSet elements to include when formatting.

		Set to `null` or `Math.POSITIVE_INFINITY` to show all elements.

		Set to `0` or negative to show no elements.

		Default: 100.
	**/
	@:optional var maxArrayLength:Int;

	/**
		The length at which an object's keys are split across multiple lines.

		Set to `Math.POSITIVE_INFINITY` to format an object as a single line.

		Default: 60 for legacy compatibility.
	**/
	@:optional var breakLength:Float;

	/**
		Setting this to false changes the default indentation to use a line break for each object key instead of lining up
		multiple properties in one line. It will also break text that is above the breakLength size into smaller and better
		readable chunks and indents objects the same as arrays.

		Note that no text will be reduced below 16 characters, no matter the breakLength size.

		Default: true.
	**/
	@:optional var compact:Int;
