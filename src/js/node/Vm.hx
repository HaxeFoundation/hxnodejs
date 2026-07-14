/*
 * Copyright (C)2014-2020 Haxe Foundation
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
import haxe.extern.EitherType;
import js.node.vm.Script;

/**
	Options object used by `Vm.run*` methods.
**/
typedef VmRunOptions = {
	> ScriptOptions,
	> ScriptRunOptions,
}

/**
	Options for `Vm.createContext`.
**/
typedef VmCreateContextOptions = {
	/**
		Human-readable name of the newly created context. Default: `'VM Context i'`, where `i` is an ascending
		numerical index of the created context.
	**/
	@:optional var name:String;

	/**
		Origin corresponding to the newly created context for display purposes. The origin should be formatted like a
		URL, but with only scheme, host, and port (if necessary). Default: `''`.
	**/
	@:optional var origin:String;

	/**
		If set to `true` any wrappers corresponding to `contextObject` properties may be invoked. Default: `false`.
	**/
	@:optional var codeGeneration:VmCodeGenerationOptions;

	/**
		If set to `afterEvaluate`, microtasks will be run immediately after evaluating code on the context
		(before returning from e.g. `runInContext`). Default: `undefined`.
	**/
	@:optional var microtaskMode:String;
}

typedef VmCodeGenerationOptions = {
	/**
		If set to `false` any calls to `eval` or function constructors (`Function`, `GeneratorFunction`, etc) will throw
		an `EvalError`. Default: `true`.
	**/
	@:optional var strings:Bool;

	/**
		If set to `false` any attempt to compile a WebAssembly module will throw a `WebAssembly.CompileError`.
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
		Provides an optional data with V8's code cache data for the supplied source.
	**/
	@:optional var parsingContext:VmContext<Dynamic>;

	/**
		An array containing context extension objects. Modules and wrappers used in `code` will be available as if
		they were referenced from these objects.
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
	@:optional var mode:String;

	/**
		`'self'` or `'all'`. Default: `'self'`.
	**/
	@:optional var execution:String;
}

/**
	The `vm` module enables compiling and running code within V8 Virtual Machine contexts.

	@see https://nodejs.org/docs/latest-v24.x/api/vm.html

	// TODO(section-5): add vm.Module / SourceTextModule / SyntheticModule externs (large experimental surface)
**/
@:jsRequire("vm")
extern class Vm {
	/**
		Compiles `code`, runs it and returns the result.
		Running code does not have access to local scope.

		// TODO(section-5): Dynamic is intentional for arbitrary JS eval results; refine per-call sites when possible
	**/
	static function runInThisContext(code:String, ?options:EitherType<String, VmRunOptions>):Dynamic;

	/**
		Compiles `code`, contextifies `sandbox` if passed or creates a new contextified sandbox if it's omitted,
		and then runs the code with the sandbox as the global object and returns the result.
	**/
	@:overload(function(code:String, ?sandbox:{}):Dynamic {})
	static function runInNewContext(code:String, sandbox:{}, ?options:VmRunOptions):Dynamic;

	/**
		Compiles `code`, then runs it in `contextifiedSandbox` and returns the result.
	**/
	static function runInContext(code:String, contextifiedSandbox:VmContext<Dynamic>, ?options:EitherType<String, VmRunOptions>):Dynamic;

	/**
		If given a sandbox object, will "contextify" that sandbox so that it can be used in calls to `runInContext`
		or `Script.runInContext`.
	**/
	@:overload(function():VmContext<Dynamic> {})
	static function createContext<T:{}>(sandbox:T, ?options:VmCreateContextOptions):VmContext<T>;

	/**
		Returns whether or not a sandbox object has been contextified by calling `createContext` on it.
	**/
	static function isContext(sandbox:{}):Bool;

	/**
		Compiles the given `code` into a function object that may use the provided `params` as formal parameters
		and may use the objects in `options.contextExtensions` as its local scope.
	**/
	static function compileFunction(code:String, ?params:Array<String>, ?options:VmCompileFunctionOptions):haxe.Constraints.Function;

	/**
		Measure the known V8 heap memory attributed to this context / all contexts (experimental).

		// TODO(section-5): type Promise result of measureMemory
	**/
	static function measureMemory(?options:VmMeasureMemoryOptions):js.lib.Promise<Dynamic>;

	/**
		Compiles and executes `code` inside the V8 debug context.
		Removed from modern Node.js versions.
	**/
	@:deprecated("Removed from Node.js; do not use")
	static function runInDebugContext(code:String):Dynamic;

	@:deprecated("use new js.node.vm.Script(...) instead")
	static function createScript(code:String, ?options:EitherType<String, ScriptOptions>):Script;

	/**
		Returns an object containing commonly used constants for VM operations.
	**/
	static var constants(default, null):VmConstants;
}

/**
	Constants exported by `vm.constants`.
**/
typedef VmConstants = {
	/**
		A constant that can be used as the `importModuleDynamically` option to `vm.Script`
		or `vm.compileFunction` so that Node.js uses the default ESM loader from the main context
		to load the requested module.
	**/
	var USE_MAIN_CONTEXT_DEFAULT_LOADER:Dynamic;

	/**
		When passed as `contextObject` to `vm.createContext()`, this constant creates an empty context
		with an object wrapper that allows code running in that context to see the outer context's Object
		prototype methods, but also has its own independent Object/Array prototypes and builtins.
	**/
	var DONT_CONTEXTIFY:Dynamic;
}

/**
	Type of context objects returned by `Vm.createContext`.
**/
@:forward
abstract VmContext<T:{}>(T) from T to T {}
