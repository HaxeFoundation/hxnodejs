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

package js.node.vm;

import haxe.extern.EitherType;
import js.lib.ArrayBufferView;
import js.node.Buffer;
import js.node.Vm.VmCodeGenerationOptions;
import js.node.Vm.VmContext;
import js.node.Vm.VmMicrotaskMode;

/**
	Options for compiling a `Script` (constructor / `compileFunction` / `runIn*` compile path).
**/
typedef ScriptOptions = {
	/**
		Specifies the filename used in stack traces produced by this script.
		Default: `'evalmachine.<incremental_id>'` for `Script`, `''` for some other APIs.
	**/
	@:optional var filename:String;

	/**
		Specifies the line number offset that is displayed in stack traces produced by this script.
		Default: `0`.
	**/
	@:optional var lineOffset:Int;

	/**
		Specifies the column number offset that is displayed in stack traces produced by this script.
		Default: `0`.
	**/
	@:optional var columnOffset:Int;

	/**
		Optional V8 code cache data for the supplied source (`Buffer`, `TypedArray`, or `DataView`).
		When supplied, `cachedDataRejected` on the resulting `Script` is set to `true` or `false`.
	**/
	@:optional var cachedData:EitherType<Buffer, ArrayBufferView>;

	/**
		When `true` and no `cachedData` is present, V8 attempts to produce code cache data for `code`.
		Deprecated in favor of `createCachedData()`. Default: `false`.
	**/
	@:deprecated("Use createCachedData() instead")
	@:optional var produceCachedData:Bool;

	/**
		How modules should be loaded during evaluation when `import()` is called.
		Part of the experimental modules API; may also be `Vm.constants.USE_MAIN_CONTEXT_DEFAULT_LOADER`.

		// TODO(vm): type importModuleDynamically callback
	**/
	@:optional var importModuleDynamically:Dynamic;
}

/**
	Options for running a compiled script (`runInThisContext` / `runInContext`).
**/
typedef ScriptRunOptions = {
	/**
		When `true`, if an `Error` occurs while compiling or running the code, the line of code
		causing the error is attached to the stack trace. Default: `true`.
	**/
	@:optional var displayErrors:Bool;

	/**
		Number of milliseconds to execute code before terminating execution.
		If execution is terminated, an `Error` is thrown. Must be a strictly positive integer.
	**/
	@:optional var timeout:Int;

	/**
		If `true`, receiving `SIGINT` (`Ctrl+C`) terminates execution and throws an `Error`.
		Existing handlers attached via `process.on('SIGINT')` are disabled during script execution
		but continue to work afterward. Default: `false`.
	**/
	@:optional var breakOnSigint:Bool;
}

/**
	Options for `runInNewContext` (script or `Vm.runInNewContext`).
**/
typedef ScriptRunInNewContextOptions = {
	> ScriptRunOptions,

	/**
		Human-readable name of the newly created context.
		Default: `'VM Context i'`, where `i` is an ascending numerical index of the created context.
	**/
	@:optional var contextName:String;

	/**
		Origin corresponding to the newly created context for display purposes.
		Default: `''`.
	**/
	@:optional var contextOrigin:String;

	/**
		Controls `eval` / function constructors and WebAssembly compilation in the new context.
	**/
	@:optional var contextCodeGeneration:VmCodeGenerationOptions;

	/**
		If set to `afterEvaluate`, microtasks run immediately after the script has run.
		They are included in the `timeout` and `breakOnSigint` scopes in that case.
	**/
	@:optional var microtaskMode:VmMicrotaskMode;
}

/**
	A class for holding precompiled scripts and running them in specific contexts.

	@see https://nodejs.org/docs/latest-v24.x/api/vm.html#class-vmscript
**/
@:jsRequire("vm", "Script")
extern class Script {
	/**
		Creates a new `Script` by compiling `code` without running it.
		If `options` is a string, it specifies the filename.
	**/
	function new(code:String, ?options:EitherType<String, ScriptOptions>);

	/**
		When `cachedData` was supplied to the constructor, `true` if V8 rejected the data,
		`false` if it was accepted; otherwise `null`/`undefined`.
	**/
	var cachedDataRejected(default, null):Null<Bool>;

	/**
		When `produceCachedData` was used, `true`/`false` depending on whether cache data was produced.
		Prefer `createCachedData()` instead of `produceCachedData`.
	**/
	var cachedDataProduced(default, null):Null<Bool>;

	/**
		V8 code cache buffer associated with this script when produced or supplied.
	**/
	var cachedData(default, null):Null<Buffer>;

	/**
		When the script source contains a source map magic comment, the URL of that source map;
		otherwise `null`/`undefined`.
	**/
	var sourceMapURL(default, null):Null<String>;

	/**
		Creates a code cache that can be passed as `cachedData` to a later `Script` constructor
		to avoid recompilation.
	**/
	function createCachedData():Buffer;

	/**
		Runs this script in the current `global` context.

		// TODO(vm): Dynamic is intentional for arbitrary JS eval results
	**/
	function runInThisContext(?options:ScriptRunOptions):Dynamic;

	/**
		Runs this script in `contextifiedObject` (from `Vm.createContext`).
	**/
	function runInContext(contextifiedObject:VmContext<Dynamic>, ?options:ScriptRunOptions):Dynamic;

	/**
		Creates a new context (optionally from `contextObject`), runs this script in it, and returns the result.

		`contextObject` may be an object to contextify, omitted/`undefined` for a fresh contextified object,
		or `Vm.constants.DONT_CONTEXTIFY`.
	**/
	@:overload(function(?contextObject:Dynamic):Dynamic {})
	function runInNewContext(contextObject:Dynamic, ?options:ScriptRunInNewContextOptions):Dynamic;
}
