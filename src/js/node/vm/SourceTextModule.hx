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
import js.node.Vm.VmContext;
import js.node.vm.Module.ModuleRequest;

/**
	Options for `new SourceTextModule(...)`.
**/
typedef SourceTextModuleOptions = {
	/**
		String used in stack traces. Default: `'vm:module(i)'` where `i` is a context-specific ascending index.
	**/
	@:optional var identifier:String;

	/**
		Optional V8 code cache data for the supplied source (`Buffer`, `TypedArray`, or `DataView`).
		The `code` must match the module from which this cached data was created.
	**/
	@:optional var cachedData:EitherType<Buffer, ArrayBufferView>;

	/**
		The contextified object to compile and evaluate this module in.
		If omitted, the module is evaluated in the current execution context.
	**/
	@:optional var context:VmContext<Dynamic>;

	/**
		Line number offset displayed in stack traces. Default: `0`.
	**/
	@:optional var lineOffset:Int;

	/**
		First-line column number offset displayed in stack traces. Default: `0`.
	**/
	@:optional var columnOffset:Int;

	/**
		Called during evaluation of this module to initialize `import.meta`.

		// TODO(vm): type initializeImportMeta `(meta, module) -> Void`
	**/
	@:optional var initializeImportMeta:Dynamic;

	/**
		Used to specify how modules should be loaded during evaluation when `import()` is called.
		Experimental modules API.
	**/
	@:optional var importModuleDynamically:Dynamic;
}

/**
	Provides the Source Text Module Record as defined in the ECMAScript specification.

	Stability: 1 - Experimental. Requires `--experimental-vm-modules`.

	@see https://nodejs.org/docs/latest-v24.x/api/vm.html#class-vmsourcetextmodule
**/
@:jsRequire("vm", "SourceTextModule")
extern class SourceTextModule extends Module {
	/**
		Creates a new `SourceTextModule` instance by parsing `code`.
	**/
	function new(code:String, ?options:SourceTextModuleOptions);

	/**
		Creates a code cache that can be used with the `SourceTextModule` constructor's `cachedData` option.
		May be called any number of times before the module has been evaluated.
	**/
	function createCachedData():Buffer;

	/**
		Specifiers of all dependencies of this module. The returned array is frozen.
		Deprecated in Node.js 24.4.0 in favour of `moduleRequests`.
	**/
	@:deprecated("Use moduleRequests instead")
	var dependencySpecifiers(default, null):Array<String>;

	/**
		Requested import dependencies of this module. The returned array is frozen.

		@see https://nodejs.org/docs/latest-v24.x/api/vm.html#sourcetextmodulemodulerequests
	**/
	var moduleRequests(default, null):Array<ModuleRequest>;

	/**
		Iterates over the dependency graph and returns `true` if any module in its dependencies
		or this module itself contains top-level `await` expressions.

		Requires the module to be instantiated first.
	**/
	function hasAsyncGraph():Bool;

	/**
		Returns whether the module itself contains any top-level `await` expressions.
	**/
	function hasTopLevelAwait():Bool;

	/**
		Instantiate the module with the linked requested modules.
		Resolves imported bindings; throws synchronously if bindings cannot be resolved.
	**/
	function instantiate():Void;

	/**
		Link module dependencies synchronously (or after async resolution by the host).
		Must be called before evaluation, and only once per module.

		The order of `modules` must match `moduleRequests`. After linking, call `instantiate()`.
	**/
	function linkRequests(modules:Array<Module>):Void;
}
