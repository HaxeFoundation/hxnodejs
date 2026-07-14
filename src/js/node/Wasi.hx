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

import haxe.DynamicAccess;

/**
	WebAssembly System Interface (WASI) support.

	Stability: 1 - Experimental

	The Node.js module exports the `WASI` class. Following HOWTO naming (acronyms not uppercased),
	the Haxe extern is `js.node.Wasi`.

	@see https://nodejs.org/docs/latest-v24.x/api/wasi.html
**/
@:jsRequire("wasi", "WASI")
extern class Wasi {
	function new(options:WasiOptions);

	/**
		Attempt to begin execution of `instance` as a WASI command by invoking its `_start()` export.
		// TODO(section-5): WebAssembly.Instance typing
	**/
	function start(instance:Dynamic):Float;

	/**
		Attempt to initialize `instance` as a WASI reactor by invoking its `_initialize()` export.
	**/
	function initialize(instance:Dynamic):Void;

	/**
		Set up WASI host bindings to `instance` without calling `initialize()` or `start()`.
		Added in: v24.4.0
	**/
	function finalizeBindings(instance:Dynamic, ?options:{?memory:Dynamic}):Void;

	/**
		Return an import object that can be passed to `WebAssembly.instantiate()`.
		// TODO(section-5): WebAssembly.Imports typing
	**/
	function getImportObject():Dynamic;

	/**
		An object that implements the WASI system call API.
		// TODO(section-5): WASI import object field typing
	**/
	final wasiImport:DynamicAccess<Dynamic>;
}

enum abstract WasiVersion(String) from String to String {
	var Preview1 = "preview1";
	var Unstable = "unstable";
}

typedef WasiOptions = {
	/**
		The version of WASI requested. Currently the only supported versions are `'unstable'` and `'preview1'`.
		This option is mandatory.
	**/
	var version:WasiVersion;

	@:optional var args:Array<String>;
	@:optional var env:DynamicAccess<String>;
	@:optional var preopens:DynamicAccess<String>;
	@:optional var returnOnExit:Bool;
	@:optional var stdin:Int;
	@:optional var stdout:Int;
	@:optional var stderr:Int;
}
