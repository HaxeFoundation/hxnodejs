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
import haxe.extern.Rest;

/**
	Creates stores that stay coherent through asynchronous operations.

	Stability: 2 - Stable. Preferred API for async context tracking over `createHook`.

	@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#class-asynclocalstorage
**/
@:jsRequire("async_hooks", "AsyncLocalStorage")
extern class AsyncLocalStorage<T> {
	/**
		Creates a new instance of `AsyncLocalStorage`.
		Store is only provided within a `run()` call or after an `enterWith()` call.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#new-asynclocalstorageoptions
	**/
	function new(?options:AsyncLocalStorageOptions<T>);

	/**
		The name of the `AsyncLocalStorage` instance if provided via options.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asynclocalstoragename
	**/
	final name:String;

	/**
		Runs a function synchronously within a context and returns its return value.
		Optional `args` are passed to the callback.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asynclocalstoragerunstore-callback-args
	**/
	function run<R>(store:T, callback:Function, args:Rest<Dynamic>):R;

	/**
		Transitions into the context for the remainder of the current synchronous
		execution and then persists the store through following asynchronous calls.

		Stability: 1 - Experimental. Prefer `run()` when possible.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asynclocalstorageenterwithstore
	**/
	function enterWith(store:T):Void;

	/**
		Runs a function synchronously outside of a context and returns its return value.

		Stability: 1 - Experimental.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asynclocalstorageexitcallback-args
	**/
	function exit<R>(callback:Function, args:Rest<Dynamic>):R;

	/**
		Returns the current store, or `null`/`undefined` outside of an initialized context.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asynclocalstoragegetstore
	**/
	function getStore():Null<T>;

	/**
		Disables this `AsyncLocalStorage` instance. Required before the instance
		can be garbage collected when no longer in use.

		Stability: 1 - Experimental.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asynclocalstoragedisable
	**/
	function disable():Void;

	/**
		Binds the given function to the current execution context.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asynclocalstoragebindfn
	**/
	static function bind<F:Function>(fn:F):F;

	/**
		Captures the current execution context and returns a function that runs
		a callback within that captured context.

		@see https://nodejs.org/docs/latest-v24.x/api/async_context.html#asynclocalstoragesnapshot
	**/
	static function snapshot():Function;
}

/**
	Options for `AsyncLocalStorage` construction.

	`defaultValue` and `name` were added in Node.js 24.0.0.
**/
typedef AsyncLocalStorageOptions<T> = {
	/**
		The default value used when no store is provided.
	**/
	@:optional var defaultValue:T;

	/**
		A name for the `AsyncLocalStorage` value.
	**/
	@:optional var name:String;
}
