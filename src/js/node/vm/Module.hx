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

import js.lib.Promise;
import js.node.Vm.VmContext;

/**
	Options for `Module.evaluate`.
**/
typedef ModuleEvaluateOptions = {
	/**
		Specifies the number of milliseconds to evaluate before terminating execution.
	**/
	@:optional var timeout:Int;

	/**
		If `true`, receiving `SIGINT` (`Ctrl+C`) will terminate execution and throw an Error.
		Default: `false`.
	**/
	@:optional var breakOnSigint:Bool;
}

/**
	A request to import a module with given import attributes and phase.

	@see https://nodejs.org/docs/latest-v24.x/api/vm.html#type-modulerequest
**/
typedef ModuleRequest = {
	/**
		The specifier of the requested module.
	**/
	var specifier:String;

	/**
		The `"with"` value passed to the WithClause in an ImportDeclaration,
		or an empty object if no value was provided.
	**/
	var attributes:Dynamic;

	/**
		The phase of the requested module (`"source"` or `"evaluation"`).
	**/
	var phase:ModulePhase;
}

enum abstract ModuleStatus(String) from String to String {
	var Unlinked = "unlinked";
	var Linking = "linking";
	var Linked = "linked";
	var Evaluating = "evaluating";
	var Evaluated = "evaluated";
	var Errored = "errored";
}

enum abstract ModulePhase(String) from String to String {
	var Source = "source";
	var Evaluation = "evaluation";
}

/**
	Low-level interface for using ECMAScript modules in VM contexts.

	Stability: 1 - Experimental. Requires `--experimental-vm-modules`.

	@see https://nodejs.org/docs/latest-v24.x/api/vm.html#class-vmmodule
**/
@:jsRequire("vm", "Module")
extern class Module {
	/**
		If `status` is `'errored'`, this property contains the exception thrown during evaluation.
		Accessing it otherwise throws.
	**/
	var error(default, null):Dynamic;

	/**
		The identifier of the current module, as set in the constructor.
	**/
	var identifier(default, null):String;

	/**
		The contextified object this module belongs to.
	**/
	var context(default, null):VmContext<Dynamic>;

	/**
		The namespace object of the module. Available after linking has completed.
	**/
	var namespace(default, null):Dynamic;

	/**
		Current status of the module.
	**/
	var status(default, null):ModuleStatus;

	/**
		Evaluate the module and its dependencies.
	**/
	function evaluate(?options:ModuleEvaluateOptions):Promise<Void>;

	/**
		Link module dependencies. Must be called before evaluation, and only once per module.

		Prefer `SourceTextModule.linkRequests` + `SourceTextModule.instantiate` for the Node 24+ sync path.

		// TODO(vm): linker callback typing (`specifier`, referencing module, attributes, phase)
	**/
	function link(linker:Dynamic):Promise<Void>;
}
