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
import haxe.extern.EitherType;
import js.node.module.SourceMap;
import js.node.url.URL;
import js.node.worker_threads.Transferable;

/**
	Provides general utility methods when interacting with instances of `Module`
	(the `module` variable in CommonJS modules), plus helpers such as
	`createRequire`, compile cache, and customization hooks.

	Accessed via `require("node:module")` / `import "node:module"`.
	In each CommonJS module, the `module` free variable refers to the current
	module object; `module.exports` is also available as the `exports` binding.

	@see https://nodejs.org/api/module.html
	@see https://nodejs.org/api/modules.html#the-module-object
**/
@:jsRequire("module")
extern class Module {
	/**
		The module objects required for the first time by this one.

		@see https://nodejs.org/api/modules.html#modulechildren
	**/
	var children(default, null):Array<Module>;

	/**
		The `module.exports` object is created by the Module system.
		Sometimes this is not acceptable; many want their module to return an
		object other than the export object. Assign the desired value to
		`module.exports` to replace the object.

		@see https://nodejs.org/api/modules.html#moduleexports
	**/
	var exports:Dynamic;

	/**
		The fully resolved filename of the module.

		@see https://nodejs.org/api/modules.html#modulefilename
	**/
	var filename(default, null):String;

	/**
		The identifier for the module.
		Typically this is the fully resolved filename.

		@see https://nodejs.org/api/modules.html#moduleid
	**/
	var id(default, null):String;

	/**
		Whether or not the module is done loading, or is in the process of loading.

		@see https://nodejs.org/api/modules.html#moduleloaded
	**/
	var loaded(default, null):Bool;

	/**
		The module that first required this one, or `null` / `undefined` if the
		current module is the entry point of the current process.

		@see https://nodejs.org/api/modules.html#moduleparent
	**/
	@:deprecated("Use require.main and module.children instead")
	var parent(default, null):Null<Module>;

	/**
		The search paths for the module.

		@see https://nodejs.org/api/modules.html#modulepaths
	**/
	var paths(default, null):Array<String>;

	/**
		`true` if the module is running during the Node.js bootstrap process.

		@see https://nodejs.org/api/modules.html#moduleispreloading
	**/
	var isPreloading(default, null):Bool;

	/**
		The directory name of the module.

		@see https://nodejs.org/api/modules.html#modulepath
	**/
	var path(default, null):String;

	/**
		Provides a way to load a module as if `require()` was called from the
		original module.

		@see https://nodejs.org/api/modules.html#modulerequireid
	**/
	function require(id:String):Dynamic;

	/**
		A list of the names of all modules provided by Node.js.
		Can be used to verify if a module is maintained by a third party or not.

		@see https://nodejs.org/api/module.html#modulebuiltinmodules
	**/
	static var builtinModules(default, null):Array<String>;

	/**
		Module compile-cache status constants and related values.

		@see https://nodejs.org/api/module.html#moduleconstantscompilecachestatus
	**/
	static var constants(default, null):ModuleConstants;

	/**
		Returns `true` if the module is a core/built-in module.

		@see https://nodejs.org/api/module.html#moduleisbuiltinmodulename
	**/
	static function isBuiltin(moduleName:String):Bool;

	/**
		Creates a `require` function that can be used to import modules as if
		they were referenced from the given filename.

		@see https://nodejs.org/api/module.html#modulecreaterequirefilename
	**/
	@:overload(function(filename:URL):String->Dynamic {})
	static function createRequire(filename:String):String->Dynamic;

	/**
		Updates all live bindings for builtin ES Modules to match the properties
		of the CommonJS exports. Does not add or remove exported names.

		@see https://nodejs.org/api/module.html#modulesyncbuiltinesmexports
	**/
	static function syncBuiltinESMExports():Void;

	/**
		Finds the corresponding `SourceMap` for a given file path, if present.

		@see https://nodejs.org/api/module.html#modulefindsourcemappath
	**/
	static function findSourceMap(path:String):Null<SourceMap>;

	/**
		Removes TypeScript type annotations from `code`.
		When `mode` is `"transform"`, also transforms TypeScript features to JavaScript.

		@see https://nodejs.org/api/module.html#modulestriptypescripttypescode-options
	**/
	static function stripTypeScriptTypes(code:String, ?options:ModuleStripTypeScriptTypesOptions):String;

	/**
		Register synchronous customization hooks that run on the thread where
		modules are loaded.

		Hook callback signatures stay loosely typed (`Function`); full
		`resolve`/`load` context models can be refined later.

		@see https://nodejs.org/api/module.html#moduleregisterhooksoptions
	**/
	static function registerHooks(options:ModuleRegisterHooksOptions):ModuleHooks;

	/**
		Finds the closest `package.json` for the given specifier.

		@see https://nodejs.org/api/module.html#modulefindpackagejsonspecifier-base
	**/
	@:overload(function(specifier:URL, ?base:EitherType<String, URL>):Null<String> {})
	static function findPackageJSON(specifier:String, ?base:EitherType<String, URL>):Null<String>;

	/**
		Register a module that exports asynchronous hooks that customize Node.js
		module resolution and loading.

		@see https://nodejs.org/api/module.html#moduleregisterspecifier-parenturl-options
	**/
	@:deprecated("Use Module.registerHooks instead")
	@:overload(function(specifier:String, parentURL:EitherType<String, URL>, ?options:ModuleRegisterOptions):Void {})
	@:overload(function(specifier:URL, parentURL:EitherType<String, URL>, ?options:ModuleRegisterOptions):Void {})
	@:overload(function(specifier:URL, ?options:ModuleRegisterOptions):Void {})
	static function register(specifier:String, ?options:ModuleRegisterOptions):Void;

	/**
		Enable the module compile cache in the current Node.js instance.
		If a string is passed, it is treated as `options.directory`.

		@see https://nodejs.org/api/module.html#moduleenablecompilecacheoptions
	**/
	@:overload(function(?options:ModuleEnableCompileCacheOptions):ModuleEnableCompileCacheResult {})
	static function enableCompileCache(?cacheDir:String):ModuleEnableCompileCacheResult;

	/**
		Flush the module compile cache accumulated from already-loaded modules to disk.

		@see https://nodejs.org/api/module.html#moduleflushcompilecache
	**/
	static function flushCompileCache():Void;

	/**
		Return the directory where the module compile cache is stored, if enabled.

		@see https://nodejs.org/api/module.html#modulegetcompilecachedir
	**/
	static function getCompileCacheDir():Null<String>;

	/**
		Enable or disable Source Map v3 support for stack traces.

		@see https://nodejs.org/api/module.html#modulesetsourcemapssupportenabled-options
	**/
	static function setSourceMapsSupport(enabled:Bool, ?options:ModuleSetSourceMapsSupportOptions):Void;

	/**
		Return whether Source Map support is enabled and related options.

		@see https://nodejs.org/api/module.html#modulegetsourcemapssupport
	**/
	static function getSourceMapsSupport():ModuleSourceMapsSupport;
}

/**
	Top-level `module.constants` object.
**/
typedef ModuleConstants = {
	/**
		Status codes returned by `Module.enableCompileCache`.

		@see https://nodejs.org/api/module.html#moduleconstantscompilecachestatus
	**/
	var compileCacheStatus:ModuleCompileCacheStatus;
}

/**
	Values of `module.constants.compileCacheStatus`.
**/
typedef ModuleCompileCacheStatus = {
	/**
		Compile cache enabled successfully.
	**/
	var ENABLED:Int;

	/**
		Compile cache was already enabled.
	**/
	var ALREADY_ENABLED:Int;

	/**
		Failed to enable the compile cache.
	**/
	var FAILED:Int;

	/**
		Compile cache disabled via `NODE_DISABLE_COMPILE_CACHE=1`.
	**/
	var DISABLED:Int;
}

/**
	Options for `Module.enableCompileCache` when passing an object.
**/
typedef ModuleEnableCompileCacheOptions = {
	/**
		Directory to store the compile cache.
		If omitted, uses `NODE_COMPILE_CACHE` or a default under `os.tmpdir()`.
	**/
	@:optional var directory:String;

	/**
		When `true`, enables portable compile cache so cached modules can be
		reused after the project directory is moved.
	**/
	@:optional var portable:Bool;
}

/**
	Result returned by `Module.enableCompileCache`.
**/
typedef ModuleEnableCompileCacheResult = {
	/**
		One of `Module.constants.compileCacheStatus`.
	**/
	var status:Int;

	/**
		Error message when `status` is `FAILED`.
	**/
	@:optional var message:String;

	/**
		Compile cache directory when `status` is `ENABLED` or `ALREADY_ENABLED`.
	**/
	@:optional var directory:String;
}

/**
	Mode for `Module.stripTypeScriptTypes`.
**/
enum abstract ModuleStripTypeScriptTypesMode(String) from String to String {
	/**
		Only strip type annotations without transforming TypeScript features.
	**/
	var Strip = "strip";

	/**
		Strip type annotations and transform TypeScript features to JavaScript.
	**/
	var Transform = "transform";
}

/**
	Options for `Module.stripTypeScriptTypes`.
**/
typedef ModuleStripTypeScriptTypesOptions = {
	/**
		Mode of stripping. Default: `Strip`.
	**/
	@:optional var mode:ModuleStripTypeScriptTypesMode;

	/**
		Whether to produce source maps. Only valid when `mode` is `Transform`.
		Default: `false`.
	**/
	@:optional var sourceMap:Bool;

	/**
		The filename used when generating source maps / sourceURL comments.
	**/
	@:optional var sourceUrl:String;
}

/**
	Options for `Module.register`.
**/
typedef ModuleRegisterOptions = {
	/**
		Base URL used to resolve relative `specifier` values when `parentURL` is
		not passed as a separate argument. Default: `"data:"`.
	**/
	@:optional var parentURL:EitherType<String, URL>;

	/**
		Arbitrary cloneable value passed into the initialize hook.
	**/
	@:optional var data:Dynamic;

	/**
		Transferable objects passed into the initialize hook.
	**/
	@:optional var transferList:Array<Transferable>;
}

/**
	Options for `Module.registerHooks`.
**/
typedef ModuleRegisterHooksOptions = {
	/**
		Synchronous load hook. See Node.js module customization hooks.
	**/
	@:optional var load:Function;

	/**
		Synchronous resolve hook. See Node.js module customization hooks.
	**/
	@:optional var resolve:Function;
}

/**
	Handle returned by `Module.registerHooks`.
**/
typedef ModuleHooks = {
	/**
		Deregister the hook instance.
	**/
	function deregister():Void;
}

/**
	Options for `Module.setSourceMapsSupport`.
**/
typedef ModuleSetSourceMapsSupportOptions = {
	/**
		Enable support for files in `node_modules`. Default: `false`.
	**/
	@:optional var nodeModules:Bool;

	/**
		Enable support for generated code from `eval` / `new Function`. Default: `false`.
	**/
	@:optional var generatedCode:Bool;
}

/**
	Result of `Module.getSourceMapsSupport`.
**/
typedef ModuleSourceMapsSupport = {
	/**
		Whether Source Map v3 support is enabled.
	**/
	var enabled:Bool;

	/**
		Whether support is enabled for files in `node_modules`.
	**/
	var nodeModules:Bool;

	/**
		Whether support is enabled for generated code from `eval` / `new Function`.
	**/
	var generatedCode:Bool;
}
