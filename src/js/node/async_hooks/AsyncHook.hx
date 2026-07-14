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

/**
	Instance returned by `AsyncHooks.createHook`, used to enable or disable hook callbacks.

	Stability: 1 - Experimental. Prefer `AsyncLocalStorage` for async context tracking.

	@see https://nodejs.org/docs/latest-v24.x/api/async_hooks.html#class-asynchook
**/
extern class AsyncHook {
	/**
		Enable the callbacks for a given `AsyncHook` instance.
		Hooks are disabled by default after creation.

		@see https://nodejs.org/docs/latest-v24.x/api/async_hooks.html#asynchookenable
	**/
	function enable():AsyncHook;

	/**
		Disable the callbacks for a given `AsyncHook` instance.

		@see https://nodejs.org/docs/latest-v24.x/api/async_hooks.html#asynchookdisable
	**/
	function disable():AsyncHook;
}
