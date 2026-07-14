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

package js.node.vm;

import haxe.extern.EitherType;
import js.node.Buffer;
import js.node.Vm.VmContext;

typedef ScriptOptions = {
	/**
		Specifies the filename used in stack traces produced by this script.
	**/
	@:optional var filename:String;

	/**
		Specifies the line number offset that is displayed in stack traces produced by this script.
	**/
	@:optional var lineOffset:Int;

	/**
		Specifies the column number offset that is displayed in stack traces produced by this script.
	**/
	@:optional var columnOffset:Int;

	/**
		Whether or not to print any errors to stderr, with the line of code that caused them highlighted,
		before throwing an exception.
		Deprecated alias kept for older Node docs; prefer omitting and relying on engine defaults.
	**/
	@:optional var displayErrors:Bool;

	/**
		Provides an optional data with V8's code cache data for the supplied source.
	**/
	@:optional var cachedData:Buffer;

	/**
		V8-specific option; when `true`, produces cached data used for faster compilation next time.
		Deprecated in favor of `createCachedData()`.
	**/
	@:deprecated("Use createCachedData() instead")
	@:optional var produceCachedData:Bool;

	/**
		Used to specify how the modules should be loaded during evaluation.
		Passed to the experimental `importModuleDynamically` hook.

		// TODO(section-5): type importModuleDynamically callback
	**/
	@:optional var importModuleDynamically:Dynamic;
}

typedef ScriptRunOptions = {
	/**
		Whether or not to print any errors to stderr, with the line of code that caused them highlighted,
		before throwing an exception.
	**/
	@:optional var displayErrors:Bool;

	/**
		Number of milliseconds to execute code before terminating execution.
		If execution is terminated, an Error will be thrown.
	**/
	@:optional var timeout:Int;

	/**
		If `true`, the execution will be terminated when `SIGINT` (`Ctrl+C`) is received.
		Existing handlers for the event that have been attached via `process.on('SIGINT')` will be disabled during
		script execution, but will continue to work after that. Default: `false`.
	**/
	@:optional var breakOnSigint:Bool;
}

/**
	A class for holding precompiled scripts, and running them in specific sandboxes.

	@see https://nodejs.org/docs/latest-v24.x/api/vm.html#class-vmscript
**/
@:jsRequire("vm", "Script")
extern class Script {
	/**
		Creating a new `Script` compiles `code` but does not run it. Instead, the created `Script` object
		represents this compiled code.
	**/
	function new(code:String, ?options:EitherType<String, ScriptOptions>);

	/**
		When producing cached data with `--produce_cached_data`, this value becomes `true` if the produced
		cached data was rejected by V8.
	**/
	var cachedDataRejected(default, null):Null<Bool>;

	/**
		When the script is compiled using `cachedData` this value will be `true` if the data was accepted by V8.
	**/
	var cachedDataProduced(default, null):Null<Bool>;

	/**
		When `cachedData` is supplied, the rejected or produced status is reflected here.
	**/
	var cachedData(default, null):Null<Buffer>;

	/**
		Creates a code cache that can be used with `Script` constructor's `cachedData` option
		to avoid recompilation next time.
	**/
	function createCachedData():Buffer;

	/**
		Similar to `Vm.runInThisContext` but a method of a precompiled `Script` object.

		// TODO(section-5): Dynamic is intentional for arbitrary JS eval results
	**/
	function runInThisContext(?options:ScriptRunOptions):Dynamic;

	/**
		Similar to `Vm.runInContext` but a method of a precompiled `Script` object.
	**/
	function runInContext(contextifiedSandbox:VmContext<Dynamic>, ?options:ScriptRunOptions):Dynamic;

	/**
		Similar to `Vm.runInNewContext` but a method of a precompiled `Script` object.
	**/
	@:overload(function(sandbox:{}, ?options:ScriptRunOptions):Dynamic {})
	function runInNewContext(?sandbox:{}):Dynamic;
}
