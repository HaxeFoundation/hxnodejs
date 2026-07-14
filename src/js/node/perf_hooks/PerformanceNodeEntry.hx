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

package js.node.perf_hooks;

/**
	This class is an extension by Node.js. It is not available in Web browsers.

	Provides detailed Node.js timing data.

	The constructor of this class is not exposed to users directly.

	@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#class-performancenodeentry
**/
extern class PerformanceNodeEntry extends PerformanceEntry {
	/**
		Additional detail specific to the `entryType`.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancenodeentrydetail
	**/
	final detail:Dynamic;

	/**
		Stability: 0 - Deprecated: Use `detail` instead.

		When `entryType` is equal to `'gc'`, contains additional information about
		garbage collection operation.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancenodeentryflags
	**/
	@:deprecated("Use detail instead")
	final flags:Int;

	/**
		Stability: 0 - Deprecated: Use `detail` instead.

		When `entryType` is equal to `'gc'`, identifies the type of garbage collection
		operation that occurred.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancenodeentrykind
	**/
	@:deprecated("Use detail instead")
	final kind:Int;
}
