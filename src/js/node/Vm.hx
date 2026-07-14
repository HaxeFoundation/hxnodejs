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
import js.lib.Promise;
import js.node.vm.Script;

/**
	Options object used by `Vm.run*` methods.

	Includes fields used by `runInNewContext` (`contextName`, `contextOrigin`, …);
	those are ignored by methods that compile and run in an existing context.
**/
typedef VmRunOptions = {
	> ScriptOptions,
	> ScriptRunInNewContextOptions,
}

/**
	Options for `Vm.createContext`.
**/
typedef VmCreateContextOptions = {
	/**
		Human-readable name of the newly created context.
		Default: `'VM Context i'`, where `i` is an ascending numerical index of the created context.
	**/
	@:optional var name:String;

	/**
		Origin corresponding to the newly created context for display purposes.
		The origin should be formatted like a URL, but with only the scheme, host, and port (if necessary),
		like the value of the `url.origin` property of a `URL` object.
		Most notably, this string should omit the trailing slash, as that denotes a path.
		Default: `''`.
	**/
	@:optional var origin:String;

	/**
		Controls whether `eval` / function constructors and WebAssembly compilation are allowed
		inside the context. See `VmCodeGenerationOptions`.
	**/
	@:optional var codeGeneration:VmCodeGenerationOptions;

	/**
		If set to `afterEvaluate`, microtasks will be run immediately after evaluating code on the context
		(before returning from e.g. `runInContext`).
	**/
	@:optional var microtaskMode:VmMicrotaskMode;

	/**
		How modules should be loaded when `import()` is called in this context without a referrer script
		or module. Part of the experimental modules API.

		May also be `Vm.constants.USE_MAIN_CONTEXT_DEFAULT_LOADER`.
		// TODO(vm): type importModuleDynamically callback
	**/
	@:optional var importModuleDynamically:Dynamic;
}

typedef VmCodeGenerationOptions = {
	/**
		If set to `false`, any calls to `eval` or function constructors (`Function`, `GeneratorFunction`, etc)
		will throw an `EvalError`. Default: `true`.
	**/
	@:optional var strings:Bool;

	/**
		If set to `false`, any attempt to compile a WebAssembly module will throw a `WebAssembly.CompileError`.
		Default: `true`.
	**/
	@:optional var wasm:Bool;
}

/**
	Options for `Vm.compileFunction`.
**/
typedef VmCompileFunctionOptions = {
	> ScriptOptions,

	/**
		The contextified object in which the function should be compiled.
	**/
	@:optional var parsingContext:VmContext<Dynamic>;

	/**
		An array containing context extension objects. Modules and wrappers used in `code` will be
		available as if they were referenced from these objects. Default: `[]`.
	**/
	@:optional var contextExtensions:Array<DynamicAccess<Dynamic>>;
}

/**
	Options for experimental `Vm.measureMemory`.
**/
typedef VmMeasureMemoryOptions = {
	/**
		`'summary'` or `'detailed'`. Default: `'summary'`.
	**/
	@:optional var mode:VmMeasureMemoryMode;

	/**
		`'default'` or `'eager'`. Default: `'default'`.
	**/
	@:optional var execution:VmMeasureMemoryExecution;
}

/**
	Result shape for `Vm.measureMemory` (V8-specific; additional fields may appear).
**/
typedef VmMemoryMeasurement = {
	var total:VmMemoryInfo;
	@:optional var current:VmMemoryInfo;
	@:optional var other:Array<VmMemoryInfo>;
	@:optional var WebAssembly:Dynamic;
}

/**
	Per-context memory estimate returned by `Vm.measureMemory`.
**/
typedef VmMemoryInfo = {
	var jsMemoryEstimate:Float;
	var jsMemoryRange:Array<Float>;
}

enum abstract VmMeasureMemoryMode(String) from String to String {
	var Summary = "summary";
	var Detailed = "detailed";
}

enum abstract VmMeasureMemoryExecution(String) from String to String {
	var Default = "default";
	var Eager = "eager";
}

enum abstract VmMicrotaskMode(String) from String to String {
	var AfterEvaluate = "afterEvaluate";
}

/**
	The `vm` module enables compiling and running code within V8 Virtual Machine contexts.

	@see https://nodejs.org/docs/latest-v24.x/api/vm.html

	Experimental module APIs live under `js.node.vm` (`Module`, `SourceTextModule`, `SyntheticModule`)
	and require `--experimental-vm-modules`.
**/
@:jsRequire("vm")
extern class Vm {
	/**
		Compiles `code`, runs it in the current `global`, and returns the result.
		Running code does not have access to local scope.

		// TODO(vm): Dynamic is intentional for arbitrary JS eval results; refine per-call sites when possible
	**/
	static function runInThisContext(code:String, ?options:EitherType<String, VmRunOptions>):Dynamic;

	/**
		Compiles `code`, contextifies `contextObject` if passed (or creates a new contextified object if omitted),
		runs the code with that object as the global, and returns the result.

		`contextObject` may also be `Vm.constants.DONT_CONTEXTIFY`.
	**/
	@:overload(function(code:String, ?contextObject:Dynamic):Dynamic {})
	static function runInNewContext(code:String, contextObject:Dynamic, ?options:VmRunOptions):Dynamic;

	/**
		Compiles `code`, then runs it in `contextifiedObject` and returns the result.
		`contextifiedObject` must previously have been contextified via `createContext`.
	**/
	static function runInContext(code:String, contextifiedObject:VmContext<Dynamic>,
		?options:EitherType<String, VmRunOptions>):Dynamic;

	/**
		Prepares `contextObject` so it can be used in `runInContext` / `Script.runInContext`, and returns it.

		If `contextObject` is omitted, an empty contextified object is created.
		Pass `Vm.constants.DONT_CONTEXTIFY` to create a context without contextifying quirks.
	**/
	@:overload(function():VmContext<Dynamic> {})
	@:overload(function(contextObject:Dynamic, ?options:VmCreateContextOptions):VmContext<Dynamic> {})
	static function createContext<T:{}>(contextObject:T, ?options:VmCreateContextOptions):VmContext<T>;

	/**
		Returns `true` if `object` has been contextified via `createContext`, or if it is the global
		object of a context created with `Vm.constants.DONT_CONTEXTIFY`.
	**/
	static function isContext(object:{}):Bool;

	/**
		Compiles `code` into a function that may use `params` as formal parameters
		and may use objects in `options.contextExtensions` as its local scope.
	**/
	static function compileFunction(code:String, ?params:Array<String>, ?options:VmCompileFunctionOptions):Function;

	/**
		Measure V8 heap memory attributed to the main context or all known contexts (experimental).
	**/
	static function measureMemory(?options:VmMeasureMemoryOptions):Promise<VmMemoryMeasurement>;

	/**
		Compiles and executes `code` inside the V8 debug context.
		Removed from modern Node.js versions.
	**/
	@:deprecated("Removed from Node.js; use the inspector module instead")
	static function runInDebugContext(code:String):Dynamic;

	@:deprecated("Use new js.node.vm.Script(...) instead")
	static function createScript(code:String, ?options:EitherType<String, ScriptOptions>):Script;

	/**
		Commonly used constants for VM operations.
	**/
	static var constants(default, null):VmConstants;
}

/**
	Constants exported by `vm.constants`.
**/
typedef VmConstants = {
	/**
		Pass as `importModuleDynamically` to `Script` / `compileFunction` so Node.js uses the default
		ESM loader from the main context to load the requested module.
	**/
	var USE_MAIN_CONTEXT_DEFAULT_LOADER:Dynamic;

	/**
		Pass as `contextObject` to `createContext` / `runInNewContext` to create a context whose global
		is an ordinary object (without contextifying quirks such as inability to freeze).
	**/
	var DONT_CONTEXTIFY:Dynamic;
}

/**
	Type of context objects returned by `Vm.createContext`.
**/
@:forward
abstract VmContext<T:{}>(T) from T to T {}
