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

import js.node.Vm.VmContext;

/**
	Options for `new SyntheticModule(...)`.
**/
typedef SyntheticModuleOptions = {
	/**
		String used in stack traces. Default: `'vm:module(i)'` where `i` is a context-specific ascending index.
	**/
	@:optional var identifier:String;

	/**
		The contextified object to compile and evaluate this module in.
	**/
	@:optional var context:VmContext<Dynamic>;
}

/**
	Provides the Synthetic Module Record as defined in the WebIDL specification.
	Used to expose non-JavaScript sources to ECMAScript module graphs.

	Stability: 1 - Experimental. Requires `--experimental-vm-modules`.

	@see https://nodejs.org/docs/latest-v24.x/api/vm.html#class-vmsyntheticmodule
**/
@:jsRequire("vm", "SyntheticModule")
extern class SyntheticModule extends Module {
	/**
		Creates a new `SyntheticModule` instance.

		`evaluateCallback` is called when the module is evaluated; use `setExport` inside it
		to define export bindings. `this` inside the callback is the module instance.
	**/
	function new(exportNames:Array<String>, evaluateCallback:haxe.Constraints.Function,
		?options:SyntheticModuleOptions);

	/**
		Sets the module export binding slot for `name` to `value`.
	**/
	function setExport(name:String, value:Dynamic):Void;
}
