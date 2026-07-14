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

/**
	The `async_hooks` module provides an API to track asynchronous resources.

	Prefer `js.node.async_hooks.AsyncLocalStorage` for most application-level async context tracking.
	`createHook` remains available but is a lower-level / less recommended API.

	@see https://nodejs.org/docs/latest-v24.x/api/async_hooks.html
**/
@:jsRequire("async_hooks")
extern class AsyncHooks {
	/**
		Registers functions to be called for different lifetime events of each async operation.
	**/
	static function createHook(options:AsyncHookOptions):js.node.async_hooks.AsyncHook;

	/**
		Returns the `asyncId` of the current execution context.
	**/
	static function executionAsyncId():Float;

	/**
		Returns the resource object associated with the topmost async frame.
		Using undocumented handle APIs on the returned object may crash the process.
	**/
	// TODO(section-5): type executionAsyncResource beyond Dynamic when handle shapes are modeled
	static function executionAsyncResource():Dynamic;

	/**
		Returns the `asyncId` of the resource that caused (or "triggered") the current execution.
	**/
	static function triggerAsyncId():Float;
}

/**
	Callbacks for `AsyncHooks.createHook`.
**/
typedef AsyncHookOptions = {
	/**
		Called during object construction when the resource is initialized.
		// TODO(section-5): type resource beyond Dynamic
	**/
	@:optional var init:Float->String->Float->Dynamic->Void;

	/**
		Called just before the resource's callback is called.
	**/
	@:optional var before:Float->Void;

	/**
		Called immediately after the resource's callback has completed.
	**/
	@:optional var after:Float->Void;

	/**
		Called after the resource is destroyed.
	**/
	@:optional var destroy:Float->Void;

	/**
		Called when the Promise-related callback is resolved.
	**/
	@:optional var promiseResolve:Float->Void;
}
