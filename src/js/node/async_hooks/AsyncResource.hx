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

package js.node.async_hooks;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;

/**
	Designed to be extended by embedders' async resources so users can
	trigger the lifetime events of their own resources.

	Stability: 2 - Stable.

	@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#class-asyncresource
**/
@:jsRequire("async_hooks", "AsyncResource")
extern class AsyncResource {
	/**
		Create a new `AsyncResource` object.
		Instantiating also triggers the `init` hook.
		If `triggerAsyncId` is omitted, `executionAsyncId()` is used.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#new-asyncresourcetype-options
	**/
	function new(type:String, ?options:EitherType<Float, AsyncResourceOptions>);

	/**
		Call the provided function with the provided arguments in the execution
		context of the async resource.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asyncresourceruninasyncscopefn-thisarg-args
	**/
	function runInAsyncScope(fn:Function, ?thisArg:Dynamic, args:Rest<Dynamic>):Dynamic;

	/**
		Call all `destroy` hooks. Must be called manually exactly once;
		an error is thrown if called more than once.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asyncresourceemitdestroy
	**/
	function emitDestroy():AsyncResource;

	/**
		Returns the unique `asyncId` assigned to the resource.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asyncresourceasyncid
	**/
	function asyncId():Float;

	/**
		Returns the trigger `asyncId` of the resource.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asyncresourcetriggerasyncid
	**/
	function triggerAsyncId():Float;

	/**
		Binds the given function to execute within this async resource's scope.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asyncresourcebindfn-thisarg
	**/
	function bind(fn:Function, ?thisArg:Dynamic):Function;

	/**
		Binds the given function to the current execution context.
		`type` is an optional name associated with the underlying `AsyncResource`.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asyncresourcebindfn-type-thisarg
	**/
	@:native("bind")
	static function bindStatic(fn:Function, ?type:String, ?thisArg:Dynamic):Function;
}

/**
	Options for `AsyncResource` construction.
**/
typedef AsyncResourceOptions = {
	/**
		The ID of the execution context that created this async event.
		Default: `executionAsyncId()`.
	**/
	@:optional var triggerAsyncId:Float;

	/**
		Disables automatic `emitDestroy` when the object is garbage collected.
		This usually means the resource has to manually call `emitDestroy()`.
		Default: `false`.
	**/
	@:optional var requireManualDestroy:Bool;
}
