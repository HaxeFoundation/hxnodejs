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
	The util module is primarily designed to support the needs of node.js's internal APIs.
	Many of these utilities are useful for your own programs. If you find that these functions
	are lacking for your purposes, however, you are encouraged to write your own utilities.
	We are not interested in any future additions to the util module that are unnecessary
	for node.js's internal functionality.
**/
@:jsRequire("util")
extern class Util {

	/**
		Takes an async function (or a function that returns a `Promise`) and returns a function following
		the error-first callback style, i.e. taking an `(err, value) => ...` callback as the last argument.
		In the callback, the first argument will be the rejection reason (or `null` if the `Promise` resolved),
		and the second argument will be the resolved value.

		The callback is executed asynchronously, and will have a limited stack trace. If the callback throws,
		the process will emit an 'uncaughtException' event, and if not handled will exit.

		Since `null` has a special meaning as the first argument to a callback, if a wrapped function rejects
		a `Promise` with a falsy value as a reason, the value is wrapped in an `Error` with the original value
		stored in a field named `reason`.
	**/
	static function callbackify(original:Function,args:Rest<Dynamic>):Null<Error>->Null<Dynamic>->Void;

	/**
		The `debuglog()` method is used to create a function that conditionally writes debug messages to `stderr`
		based on the existence of the `NODE_DEBUG` environment variable.
		
		If the `section` name appears within the value of that environment variable, then the returned function operates
		similar to `Console.error()`.
		If not, then the returned function is a no-op.

		Multiple comma-separated `section` names may be specified in the `NODE_DEBUG` environment variable: `NODE_DEBUG=fs,net,tls`.
	**/
	static function debuglog(section:String):Rest<Dynamic>->Void;

	/**
		The `deprecate()` method wraps fn (which may be a function or class) in such a way that it is marked as deprecated.

		When called, `deprecate()` will return a function that will emit a DeprecationWarning using the 'warning' event.
		The warning will be emitted and printed to `stderr` the first time the returned function is called. After the warning
		is emitted, the wrapped function is called without emitting a warning.

		If the same optional `code` is supplied in multiple calls to `deprecate()`, the warning will be emitted only once
		for that code.
	**/
	static function deprecate<T:haxe.Constraints.Function>(fun:T, msg:String, ?code:String):T;

	/**
		The `format()` method returns a formatted string using the first argument as a printf-like format.

		The first argument is a string that contains zero or more placeholders.
		Each placeholder is replaced with the converted value from its corresponding argument.
		Supported placeholders are:
			%s - String.
			%d - Number (both integer and float) or BigInt.
			%i - Integer or BigInt.
			%f - Floating point value.
			%j - JSON. Replaced with the string '[Circular]' if the argument contains circular references.
			%o - Object. A string representation of an object with generic JavaScript object formatting. Similar to util.inspect()
			with options { showHidden: true, showProxy: true }. This will show the full object including non-enumerable properties
			and proxies.
			%O - Object. A string representation of an object with generic JavaScript object formatting. Similar to util.inspect()
			without options. This will show the full object not including non-enumerable properties and proxies.
			%% - single percent sign ('%'). This does not consume an argument.
		If the placeholder does not have a corresponding argument, the placeholder is not replaced.

		If there are more arguments passed to the `format()` method than the number of placeholders, the extra arguments are
		coerced into strings then concatenated to the returned string, each delimited by a space. Excessive arguments whose `typeof`
		is 'object' or 'symbol' (except null) will be transformed by `inspect()`.
		
		If the first argument is not a string then `format()` returns a string that is the concatenation of all arguments separated
		by spaces. Each argument is converted to a string using `inspect()`.

		If only one argument is passed to `format()`, it is returned as it is without any formatting.
	**/
	@:overload(function(args:Rest<Dynamic>):String {})
	static function format(format:String, args:Rest<Dynamic>):String;

	/**
		This function is identical to `format()`, except in that it takes an `inspectOptions` argument which specifies options
		that are passed along to `inspect()`.
	**/
	static function formatWithOptions(inspectOptions:InspectOptions, format:String, args:Rest<Dynamic>):String;

	/**
		Returns the string name for a numeric error code that comes from a Node.js API.
		The mapping between error codes and error names is platform-dependent.
	**/
	static function getSystemErrorName(err:Int):String;

	/**
		Usage of `inherits()` is discouraged.
		Please use the ES6 `class` and `extends` keywords to get language level inheritance support.
		Also note that the two styles are semantically incompatible.

		Inherit the prototype methods from one constructor into another.
		The prototype of `constructor` will be set to a new object created from `superConstructor`.

		As an additional convenience, `superConstructor` will be accessible through the `constructor.super_` property.
	**/
	static function inherits(constructor:Class<Dynamic>, superConstructor:Class<Dynamic>):Bool;

	/**
		The `inspect()` method returns a string representation of `object` that is intended for debugging.
		The output of `inspect` may change at any time and should not be depended upon programmatically.
		Additional `options` may be passed that alter certain aspects of the formatted string.
		`inspect()` will use the constructor's name and/or `@@toStringTag` to make an identifiable tag for an inspected value.

		Values may supply their own custom `inspect(depth, opts)` functions, when called these receive the current `depth`
		in the recursive inspection, as well as the options object passed to `inspect()`.

		Using the `showHidden` option allows to inspect WeakMap and WeakSet entries.
		If there are more entries than `maxArrayLength`, there is no guarantee which entries are displayed.
		That means retrieving the same WeakSet entries twice might actually result in a different output.
		Besides this any item might be collected at any point of time by the garbage collectorif there is no strong reference
		left to that object. Therefore there is no guarantee to get a reliable output.
	**/
	@:overload(function(object:Dynamic, ?showHidden:Bool, ?depth:Int, ?colors:Bool):String {})
	static function inspect(object:Dynamic, ?options:InspectOptions):String;

	/**
		Returns `true` if there is deep strict equality between `val1` and `val2`. Otherwise, returns `false`.
	**/
	static function isDeepStrictEqual(val1:Dynamic, val2:Dynamic):Bool;

	/**
		Takes a function following the common error-first callback style, i.e. taking an `(err, value) => ...`
		callback as the last argument, and returns a version that returns promises.

		If there is an `original[util.promisify.custom]` property present, promisify will return its value.

		`promisify()` assumes that `original` is a function taking a callback as its final argument in all cases.
		If `original` is not a function, `promisify()` will throw an error. If original is a function but its last
		argument is not an error-first callback, it will still be passed an error-first callback as its last argument.
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
	>InspectOptionsBase,

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

	/**
		If set to `true` or a function, all properties of an object and Set and Map entries will be sorted in the returned string.
		If set to `true` the default sort is going to be used. If set to a function, it is used as a compare function.
	**/
	@:optional var sorted:EitherType<Bool,Dynamic->Dynamic->Int>;
}
