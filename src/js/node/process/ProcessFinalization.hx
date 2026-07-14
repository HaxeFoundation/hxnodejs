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

package js.node.process;

/**
	Process finalization registry API (`process.finalization`).

	@see https://nodejs.org/api/process.html#processfinalization
**/
extern class ProcessFinalization {
	/**
		Registers a callback invoked before the event loop exits when `ref` becomes unreachable.
		The `event` argument is typically `'exit'`.

		@see https://nodejs.org/api/process.html#processfinalizationregisterref-callback
	**/
	function register<T>(ref:T, callback:(ref:T, event:String) -> Void):Void;

	/**
		Registers a callback invoked on the `'beforeExit'` event when `ref` remains alive.
		The `event` argument is typically `'beforeExit'`.

		@see https://nodejs.org/api/process.html#processfinalizationregisterbeforeexitref-callback
	**/
	function registerBeforeExit<T>(ref:T, callback:(ref:T, event:String) -> Void):Void;

	/**
		Unregisters a resource previously registered with `register` / `registerBeforeExit`.

		@see https://nodejs.org/api/process.html#processfinalizationunregisterref
	**/
	function unregister(ref:Any):Void;
}
