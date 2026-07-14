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

import haxe.Constraints.Function;
import haxe.DynamicAccess;
import haxe.extern.EitherType;
import haxe.extern.Rest;
import js.lib.Error;
import js.lib.Map;
import js.lib.Promise;
import js.node.stream.Readable;
import js.node.stream.Writable;
import js.node.web.AbortController;
import js.node.web.AbortSignal;

/**
	The `util` module is primarily designed to support the needs of Node.js' own internal APIs.

	@see https://nodejs.org/api/util.html
**/
@:jsRequire("util")
extern class Util {
	/**
		Takes an `async` function (or a function that returns a `Promise`) and returns a function following the
		error-first callback style, i.e. taking an `(err, value) => ...` callback as the last argument.

		@see https://nodejs.org/api/util.html#utilcallbackifyoriginal
	**/
	// TODO(section-4): tighten callbackify return/arg types beyond Function
	static function callbackify(original:Function):Function;

	/**
		Creates a function that conditionally writes debug messages to `stderr` based on the
		`NODE_DEBUG` environment variable.

		The optional `callback` is invoked the first time the logging function is called with a more
		optimized logger (no section-enable check on each call).

		@see https://nodejs.org/api/util.html#utildebuglogsection-callback
	**/
	static function debuglog(section:String, ?callback:DebugLogger->Void):DebugLogger;

	/**
		Alias for `util.debuglog`. Prefer this when only checking `.enabled` so the name does not imply logging.

		@see https://nodejs.org/api/util.html#utildebugsection
	**/
	static function debug(section:String, ?callback:DebugLogger->Void):DebugLogger;

	/**
		The `util.deprecate()` method wraps `fn` (which may be a function or class) in such a way that it is marked
		as deprecated.

		@see https://nodejs.org/api/util.html#utildeprecatefn-msg-code-options
	**/
	static function deprecate<T:Function>(fun:T, msg:String, ?code:String, ?options:DeprecateOptions):T;

	/**
		The `util.format()` method returns a formatted string using the first argument as a `printf`-like format string
		which can contain zero or more format specifiers.

		@see https://nodejs.org/api/util.html#utilformatformat-args
	**/
	@:overload(function(args:Rest<Any>):String {})
	static function format(format:String, args:Rest<Any>):String;

	/**
		This function is identical to `util.format()`, except in that it takes an `inspectOptions` argument which
		specifies options that are passed along to `util.inspect()`.

		@see https://nodejs.org/api/util.html#utilformatwithoptionsinspectoptions-format-args
	**/
	@:overload(function(inspectOptions:InspectOptions, args:Rest<Any>):String {})
	static function formatWithOptions(inspectOptions:InspectOptions, format:String, args:Rest<Any>):String;

	/**
		Returns the string name for a numeric error code that comes from a Node.js API.

		@see https://nodejs.org/api/util.html#utilgetsystemerrornameerr
	**/
	static function getSystemErrorName(err:Int):String;

	/**
		Returns the system error message associated with a numeric error code.

		@see https://nodejs.org/api/util.html#utilgetsystemerrormessageerr
	**/
	static function getSystemErrorMessage(err:Int):String;

	/**
		Returns a Map of all system error codes available from the Node.js API.
		Map values are `[name, message]` string pairs.

		@see https://nodejs.org/api/util.html#utilgetsystemerrormap
	**/
	static function getSystemErrorMap():Map<Int, Array<String>>;

	/**
		Inherit the prototype methods from one `constructor` into another.

		@see https://nodejs.org/api/util.html#utilinheritsconstructor-superconstructor
	**/
	@:deprecated("Use class extends instead")
	static function inherits(constructor:Class<Any>, superConstructor:Class<Any>):Void;

	/**
		The `util.inspect()` method returns a string representation of `object` that is intended for debugging.

		@see https://nodejs.org/api/util.html#utilinspectobject-options
	**/
	@:overload(function(object:Any, ?showHidden:Bool, ?depth:Int, ?colors:Bool):String {})
	static function inspect(object:Any, ?options:InspectOptions):String;

	/**
		Returns `true` if there is deep strict equality between `val1` and `val2`.

		When `options.skipPrototype` (or a bare `true` third argument) is set, prototype and constructor
		comparison is skipped.

		@see https://nodejs.org/api/util.html#utilisdeepstrictequalval1-val2-options
	**/
	@:overload(function(val1:Any, val2:Any, skipPrototype:Bool):Bool {})
	static function isDeepStrictEqual(val1:Any, val2:Any, ?options:IsDeepStrictEqualOptions):Bool;

	/**
		Takes a function following the common error-first callback style, i.e. taking an `(err, value) => ...` callback
		as the last argument, and returns a version that returns promises.

		@see https://nodejs.org/api/util.html#utilpromisifyoriginal
	**/
	// TODO(section-4): tighten promisify generic result typing
	static function promisify(original:Function):Rest<Any>->Promise<Any>;

	/**
		Parses command-line `args` into an options object according to `config`.

		// TODO(section-4): generic ParseArgsConfig / ParsedResults refinement

		@see https://nodejs.org/api/util.html#utilparseargsconfig
	**/
	static function parseArgs(?config:ParseArgsConfig):ParseArgsResult;

	/**
		Parses the raw contents of an `.env` file.

		@see https://nodejs.org/api/util.html#utilparseenvcontent
	**/
	static function parseEnv(content:String):DynamicAccess<String>;

	/**
		Removes any ANSI escape codes from the specified string.

		@see https://nodejs.org/api/util.html#utilstripvtcontrolcharactersstr
	**/
	static function stripVTControlCharacters(str:String):String;

	/**
		Returns a formatted text considering the `format` passed for printing in a terminal.

		@see https://nodejs.org/api/util.html#utilstyletextformat-text-options
	**/
	static function styleText(format:EitherType<String, Array<String>>, text:String, ?options:StyleTextOptions):String;

	/**
		Returns the `string` after replacing any unpaired surrogate code units with U+FFFD.

		@see https://nodejs.org/api/util.html#utiltousvstringstring
	**/
	static function toUSVString(string:String):String;

	/**
		Returns an `AbortController` that can be transferred to a Worker via `postMessage`.

		@see https://nodejs.org/api/util.html#utiltransferableabortcontroller
	**/
	static function transferableAbortController():AbortController;

	/**
		Marks an existing `AbortSignal` as transferable so it can be sent to a Worker.

		@see https://nodejs.org/api/util.html#utiltransferableabortsignalsignal
	**/
	static function transferableAbortSignal(signal:AbortSignal):AbortSignal;

	/**
		Listens to abort on `signal` and resource lifetime; resolves when aborted (or resource GC'd).

		@see https://nodejs.org/api/util.html#utilabortedsignal-resource
	**/
	static function aborted(signal:AbortSignal, resource:Any):Promise<Void>;

	/**
		Compares `actual` and `expected` and returns the differences as an array of diff entries.

		@see https://nodejs.org/api/util.html#utildiffactual-expected
	**/
	static function diff(actual:EitherType<String, Array<String>>, expected:EitherType<String, Array<String>>):Array<DiffEntry>;

	/**
		Returns an array of call site objects from the current stack.

		@see https://nodejs.org/api/util.html#utilgetcallsitesframecount-options
	**/
	@:overload(function(?options:GetCallSitesOptions):Array<CallSiteObject> {})
	static function getCallSites(?frameCount:Int, ?options:GetCallSitesOptions):Array<CallSiteObject>;

	/**
		Legacy alias of `getCallSites` (renamed in Node.js 22.12+ / 23.3+; removed as a separate export later).

		@see https://nodejs.org/api/util.html#utilgetcallsitesframecount-options
	**/
	@:deprecated("Use Util.getCallSites instead")
	@:overload(function(?options:GetCallSitesOptions):Array<CallSiteObject> {})
	static function getCallSite(?frameCount:Int, ?options:GetCallSitesOptions):Array<CallSiteObject>;

	/**
		Converts a POSIX signal name (e.g. `'SIGTERM'`) to the corresponding process exit code
		(`128 + signal number`).

		@see https://nodejs.org/api/util.html#utilconvertprocesssignaltoexitcodesignal
	**/
	static function convertProcessSignalToExitCode(signal:String):Int;

	/**
		Enables or disables printing a stack trace when Node.js receives `SIGINT`.
		Only available on the main thread.

		@see https://nodejs.org/api/util.html#utilsettracesigtintenable
	**/
	static function setTraceSigInt(enable:Bool):Void;

	/**
		Shallow-copies enumerable properties from `source` onto `target`.

		@see https://nodejs.org/api/util.html#util_extendtarget-source
	**/
	@:deprecated("Use Object.assign instead")
	static function _extend(target:DynamicAccess<Any>, source:DynamicAccess<Any>):DynamicAccess<Any>;

	/**
		Deprecated predecessor of `console.error` (removed; different from `Util.debug` / `debuglog`).
	**/
	@:deprecated("Use js.Node.console.error instead")
	static function error(args:Rest<Any>):Void;

	/**
		Returns true if the given "object" is an Array. false otherwise.
	**/
	@:deprecated("Use Std.isOfType(value, Array) instead")
	static function isArray(object:Any):Bool;

	/**
		Returns true if the given "object" is a Bool. false otherwise.
	**/
	@:deprecated("Use (value is Bool) instead")
	static function isBoolean(object:Any):Bool;

	/**
		Returns true if the given "object" is a Buffer. false otherwise.
	**/
	@:deprecated("Use Buffer.isBuffer instead")
	static function isBuffer(object:Any):Bool;

	/**
		Returns true if the given "object" is a Date. false otherwise.
	**/
	@:deprecated("Use js.node.util.Types.isDate instead")
	static function isDate(object:Any):Bool;

	/**
		Returns true if the given "object" is an Error. false otherwise.
	**/
	@:deprecated("Use js.node.util.Types.isNativeError instead")
	static function isError(object:Any):Bool;

	/**
		Returns true if the given "object" is a Function. false otherwise.
	**/
	@:deprecated("Use Reflect.isFunction instead")
	static function isFunction(object:Any):Bool;

	/**
		Returns true if the given "object" is strictly null. false otherwise.
	**/
	@:deprecated("Use (value == null) instead")
	static function isNull(object:Any):Bool;

	/**
		Returns true if the given "object" is null or undefined. false otherwise.
	**/
	@:deprecated("Use (value == null) instead")
	static function isNullOrUndefined(object:Any):Bool;

	/**
		Returns true if the given "object" is a Float. false otherwise.
	**/
	@:deprecated("Use (value is Float) instead")
	static function isNumber(object:Any):Bool;

	/**
		Returns true if the given "object" is strictly an Object and not a Function. false otherwise.
	**/
	@:deprecated("Use value != null && js.Syntax.typeof(value) == \"object\" instead")
	static function isObject(object:Any):Bool;

	/**
		Returns true if the given "object" is a primitive type. false otherwise.
	**/
	@:deprecated("Use (js.Syntax.typeof(value) != \"object\" && js.Syntax.typeof(value) != \"function\") || value == null instead")
	static function isPrimitive(object:Any):Bool;

	/**
		Returns true if the given "object" is a RegExp. false otherwise.
	**/
	@:deprecated("Use js.node.util.Types.isRegExp instead")
	static function isRegExp(object:Any):Bool;

	/**
		Returns true if the given "object" is a String. false otherwise.
	**/
	@:deprecated("Use (value is String) instead")
	static function isString(object:Any):Bool;

	/**
		Returns true if the given "object" is a Symbol. false otherwise.
	**/
	@:deprecated("Use js.Syntax.typeof(value) == \"symbol\" instead")
	static function isSymbol(object:Any):Bool;

	/**
		Returns true if the given "object" is undefined. false otherwise.
	**/
	@:deprecated("Use js.Syntax.typeof(value) == \"undefined\" instead")
	static function isUndefined(object:Any):Bool;

	/**
		Output with timestamp on stdout.
	**/
	@:deprecated("Use js.Node.console.log instead")
	static function log(args:Rest<Any>):Void;

	/**
		Deprecated predecessor of console.log.
	**/
	@:deprecated("Use js.Node.console.log instead")
	static function print(args:Rest<Any>):Void;

	/**
		Deprecated predecessor of console.log.
	**/
	@:deprecated("Use js.Node.console.log instead")
	static function puts(args:Rest<Any>):Void;

	/**
		Deprecated predecessor of stream.pipe().
	**/
	@:deprecated("Use `readableStream.pipe(writableStream)` instead")
	static function pump(readableStream:IReadable, writableStream:IWritable, ?callback:Error->Void):Void;
}

/**
	Options object used by `Console.dir`.
**/
typedef InspectOptionsBase = {
	/**
		If `true`, `object`'s non-enumerable symbols and properties are included in the formatted result.
		`WeakMap` and `WeakSet` entries are also included.

		Default: `false`.
	**/
	@:optional var showHidden:Bool;

	/**
		Specifies the number of times to recurse while formatting `object`.
		This is useful for inspecting large objects. To recurse up to the maximum call stack size pass `Infinity` or
		`null`.

		Default: `2`.
	**/
	@:optional var depth:Null<Int>;

	/**
		If `true`, the output is styled with ANSI color codes.
		Colors are customizable.
		See Customizing `util.inspect` colors.

		Default: `false`.
	**/
	@:optional var colors:Bool;
}

/**
	Options object used by `Util.inspect`.
**/
typedef InspectOptions = {
	> InspectOptionsBase,

	/**
		If `false`, `[util.inspect.custom](depth, opts)` functions are not invoked.

		Default: `true`.
	**/
	@:optional var customInspect:Bool;

	/**
		If `true`, `Proxy` inspection includes the `target` and `handler` objects.

		Default: `false`.
	**/
	@:optional var showProxy:Bool;

	/**
		Specifies the maximum number of `Array`, `TypedArray`, `WeakMap` and `WeakSet` elements to include when
		formatting.
		Set to `null` or `Infinity` to show all elements.
		Set to `0` or negative to show no elements.

		Default: `100`.
	**/
	@:optional var maxArrayLength:Null<Int>;

	/**
		Specifies the maximum number of characters to include when formatting strings.
		Set to `null` or `Infinity` to show all characters.
		Set to `0` or negative to show no characters.

		Default: `10000`.
	**/
	@:optional var maxStringLength:Null<Int>;

	/**
		The length at which input values are split across multiple lines.
		Set to `Infinity` to format the input as a single line (in combination with `compact` set to `true` or any
		number >= `1`).

		Default: `80`.
	**/
	@:optional var breakLength:Float;

	/**
		Setting this to `false` causes each object key to be displayed on a new line.
		It will also add new lines to text that is longer than `breakLength`.
		If set to a number, the most `n` inner elements are united on a single line as long as all properties fit into
		`breakLength`.
		Short array elements are also grouped together.
		No text will be reduced below 16 characters, no matter the `breakLength` size.
		For more information, see the example below.

		Default: `3`.
	**/
	@:optional var compact:EitherType<Bool, Int>;

	/**
		If set to `true` or a function, all properties of an object, and `Set` and `Map` entries are sorted in the
		resulting string.
		If set to `true` the default sort is used.
		If set to a function, it is used as a compare function.
	**/
	@:optional var sorted:EitherType<Bool, String->String->Int>;

	/**
		If set to `true`, getters are inspected.
		If set to `'get'`, only getters without a corresponding setter are inspected.
		If set to `'set'`, only getters with a corresponding setter are inspected.
		This might cause side effects depending on the getter function.

		Default: `false`.
	**/
	@:optional var getters:EitherType<Bool, String>;

	/**
		If set to `true`, an underscore separates every three digits in all bigints and numbers.

		Default: `false`.
	**/
	@:optional var numericSeparator:Bool;
}

/**
	Options object used by `Util.styleText`.
**/
typedef StyleTextOptions = {
	/**
		A stream that will be validated if it can be colored.

		Default: `process.stdout`.
	**/
	@:optional var stream:IWritable;

	/**
		Value indicating whether `stream` is checked to see if it can handle colors.

		Default: `true`.
	**/
	@:optional var validateStream:Bool;
}

/**
	Options for `Util.deprecate`.
**/
typedef DeprecateOptions = {
	/**
		When `false`, do not change the prototype of the deprecated object while emitting the warning.

		Default: `true`.
	**/
	@:optional var modifyPrototype:Bool;
}

/**
	Options for `Util.isDeepStrictEqual`.
**/
typedef IsDeepStrictEqualOptions = {
	/**
		If `true`, prototype and constructor comparison is skipped during deep strict equality check.

		Default: `false`.
	**/
	@:optional var skipPrototype:Bool;
}

/**
	Logger returned by `Util.debuglog` / `Util.debug`.
**/
@:callable
abstract DebugLogger(Dynamic) from Dynamic to Dynamic {
	/**
		`true` when `NODE_DEBUG` enables this logger's section.
	**/
	public var enabled(get, never):Bool;

	inline function get_enabled():Bool
		return this.enabled;
}

/**
	Configuration for `Util.parseArgs`.
**/
typedef ParseArgsConfig = {
	@:optional var args:Array<String>;
	@:optional var options:DynamicAccess<ParseArgsOptionDescriptor>;
	@:optional var strict:Bool;
	@:optional var allowPositionals:Bool;
	@:optional var allowNegative:Bool;
	@:optional var tokens:Bool;
}

/**
	Descriptor for a single `parseArgs` option.
**/
typedef ParseArgsOptionDescriptor = {
	@:optional var type:String;
	@:optional var multiple:Bool;
	@:optional var short:String;
	@:optional @:native("default") var defaultValue:Any;
}

/**
	Result of `Util.parseArgs`.
**/
typedef ParseArgsResult = {
	var values:DynamicAccess<Any>;
	var positionals:Array<String>;
	@:optional var tokens:Array<ParseArgsToken>;
}

/**
	A token returned when `ParseArgsConfig.tokens` is `true`.
**/
typedef ParseArgsToken = {
	/**
		One of `'option'`, `'positional'`, or `'option-terminator'`.
	**/
	var kind:String;

	/**
		Index of the argument in `args` that produced this token.
	**/
	var index:Int;

	/**
		Long name of an option token.
	**/
	@:optional var name:String;

	/**
		How the option appeared in `args` (e.g. `-f` or `--foo`).
	**/
	@:optional var rawName:String;

	/**
		Option or positional value (`undefined` for boolean options).
	**/
	@:optional var value:Null<EitherType<String, Bool>>;

	/**
		Whether an option value was specified inline (e.g. `--foo=bar`).
	**/
	@:optional var inlineValue:Null<Bool>;
}

/**
	A single entry from `Util.diff`.
**/
typedef DiffEntry = Array<EitherType<Int, String>>;

/**
	Options for `Util.getCallSites`.
**/
typedef GetCallSitesOptions = {
	@:optional var sourceMap:Bool;
}

/**
	A call site object returned by `Util.getCallSites`.
**/
typedef CallSiteObject = {
	var functionName:String;
	var scriptName:String;
	/**
		Unique script id (Chrome DevTools protocol `Runtime.ScriptId`).
	**/
	var scriptId:String;
	var lineNumber:Int;
	var columnNumber:Int;
	/**
		Deprecated alias of `columnNumber` (still present on some Node versions).
	**/
	@:optional var column:Int;
}
