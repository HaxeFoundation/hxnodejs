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

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import js.node.module.SourceMap;
import js.node.url.URL;

/**
	In each module, the `module` free variable is a reference to the object representing the current module.
	For convenience, `module.exports` is also accessible via the `exports` module-global.
	`module` is not actually a global but rather local to each module.

	@see https://nodejs.org/api/modules.html#modules_the_module_object
**/
@:jsRequire("module")
extern class Module {
	/**
		The module objects required for the first time by this one.

		@see https://nodejs.org/api/modules.html#modules_module_children
	**/
	var children(default, null):Array<Module>;

	/**
		The `module.exports` object is created by the Module system.
	**/
	var exports:Dynamic;

	/**
		The fully resolved filename of the module.
	**/
	var filename(default, null):String;

	/**
		The identifier for the module.
		Typically this is the fully resolved filename.
	**/
	var id(default, null):String;

	/**
		Whether or not the module is done loading, or is in the process of loading.
	**/
	var loaded(default, null):Bool;

	/**
		The module that first required this one.
	**/
	var parent(default, null):Module;

	/**
		The search paths for the module.
	**/
	var paths(default, null):Array<String>;

	/**
		True if the module is running during the Node.js bootstrap process.
	**/
	var isPreloading(default, null):Bool;

	/**
		The directory name of the module.
	**/
	var path(default, null):String;

	/**
		The `module.require()` method provides a way to load a module as if `require()` was called from the original
		module.
	**/
	function require(id:String):Dynamic;

	/**
		A list of the names of all modules provided by Node.js.
	**/
	static var builtinModules(default, null):Array<String>;

	/**
		Returns `true` if the module is a core/built-in module.
	**/
	static function isBuiltin(moduleName:String):Bool;

	/**
		@see https://nodejs.org/api/modules.html#modules_module_createrequire_filename
	**/
	@:overload(function(filename:URL):String->Dynamic {})
	static function createRequire(filename:String):String->Dynamic;

	/**
		The `module.syncBuiltinESMExports()` method updates all the live bindings for builtin ES Modules to match the
		properties of the CommonJS exports.
	**/
	static function syncBuiltinESMExports():Void;

	/**
		`findSourceMap` finds the corresponding source map for a given file path.

		@see https://nodejs.org/api/module.html#modulefindsourcemappath
	**/
	static function findSourceMap(path:String):Null<SourceMap>;

	/**
		Removes TypeScript type annotations from `code`.
	**/
	static function stripTypeScriptTypes(code:String, ?options:ModuleStripTypeScriptTypesOptions):String;

	/**
		Register synchronous customization hooks.

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
		Register a module that exports hooks that customize Node.js module resolution and loading.

		@see https://nodejs.org/api/module.html#moduleregisterspecifier-parenturl-options
	**/
	@:overload(function(specifier:String, parentURL:EitherType<String, URL>, ?options:ModuleRegisterOptions):Void {})
	@:overload(function(specifier:URL, parentURL:EitherType<String, URL>, ?options:ModuleRegisterOptions):Void {})
	@:overload(function(specifier:URL, ?options:ModuleRegisterOptions):Void {})
	static function register(specifier:String, ?options:ModuleRegisterOptions):Void;

	/**
		Enable the module compile cache.

		@see https://nodejs.org/api/module.html#moduleenablecompilecachecachedir
	**/
	static function enableCompileCache(?cacheDir:String):Dynamic;

	/**
		Flush the module compile cache to disk.
	**/
	static function flushCompileCache():Void;

	/**
		Return the directory where the module compile cache is stored, if enabled.
	**/
	static function getCompileCacheDir():Null<String>;

	/**
		Enable or disable Source Map v3 support for stack traces.
	**/
	static function setSourceMapsSupport(enabled:Bool, ?options:ModuleSetSourceMapsSupportOptions):Void;

	/**
		Return whether Source Map support is enabled and related options.
	**/
	static function getSourceMapsSupport():ModuleSourceMapsSupport;
}

/**
	Options for `Module.stripTypeScriptTypes`.
**/
typedef ModuleStripTypeScriptTypesOptions = {
	/**
		Mode of stripping. Default: `'strip'`.
	**/
	@:optional var mode:String;

	/**
		Whether to produce source maps. Default: `false`.
	**/
	@:optional var sourceMap:Bool;

	/**
		The filename used when generating source maps.
	**/
	@:optional var sourceUrl:String;
}

/**
	Options for `Module.register`.
**/
typedef ModuleRegisterOptions = {
	/**
		Base URL used to resolve relative `specifier` values when `parentURL` is not
		passed as a separate argument. Default: `'data:'`.
	**/
	@:optional var parentURL:EitherType<String, URL>;

	/**
		Arbitrary cloneable value passed into the initialize hook.
	**/
	@:optional var data:Dynamic;

	/**
		Transferable objects passed into the initialize hook.
		// TODO(section-5): tighten once worker_threads transferable typing is settled.
	**/
	@:optional var transferList:Array<Dynamic>;
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
