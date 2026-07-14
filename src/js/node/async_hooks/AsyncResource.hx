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

package js.node.async_hooks;

import haxe.Constraints.Function;
import haxe.extern.EitherType;

/**
	The class `AsyncResource` is designed to be extended by the embedder's async resources.
	Using this, users can easily trigger the lifetime events of their own resources.

	@see https://nodejs.org/docs/latest-v24.x/api/async_hooks.html#class-asyncresource
**/
@:jsRequire("async_hooks", "AsyncResource")
extern class AsyncResource {
	/**
		Create a new `AsyncResource` object.
	**/
	function new(type:String, ?options:EitherType<Float, AsyncResourceOptions>);

	/**
		Call the provided function with the provided arguments in the execution context of the async resource.
		// TODO(section-5): type Rest args more precisely when binding helpers are standardized
	**/
	function runInAsyncScope(fn:Function, ?thisArg:Dynamic, ?args:Array<Dynamic>):Dynamic;

	/**
		Call `AsyncHooks.emitDestroy()` after binding / pending work is finished.
	**/
	function emitDestroy():AsyncResource;

	/**
		Returns the unique `asyncId` assigned to the resource.
	**/
	function asyncId():Float;

	/**
		Returns the trigger `asyncId` of the resource.
	**/
	function triggerAsyncId():Float;

	/**
		Binds the given function to execute within this async resource's stack.
	**/
	function bind(fn:Function, ?thisArg:Dynamic):Function;

	/**
		Binds the given function to execute within a given execution context of an async resource.
	**/
	@:native("bind")
	static function bindStatic(fn:Function, type:EitherType<String, AsyncResource>, ?thisArg:Dynamic):Function;
}

typedef AsyncResourceOptions = {
	/**
		The ID of the execution context that created this async event. Default: `executionAsyncId()`.
	**/
	@:optional var triggerAsyncId:Float;

	/**
		Disables automatic `emitDestroy` when the object is garbage collected.
		This usually means the resource has to manually call `emitDestroy()`. Default: `false`.
	**/
	@:optional var requireManualDestroy:Bool;
}
