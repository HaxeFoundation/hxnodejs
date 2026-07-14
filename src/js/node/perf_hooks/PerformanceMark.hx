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
	Exposes marks created via the `Performance.mark()` method.

	@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#class-performancemark
**/
@:jsRequire("perf_hooks", "PerformanceMark")
extern class PerformanceMark extends PerformanceEntry {
	function new(markName:String, ?markOptions:PerformanceMarkOptions);

	/**
		Additional detail specified when creating with `Performance.mark()` method.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancemarkdetail
	**/
	final detail:Dynamic;
}

/**
	Options for `Performance.mark`.
**/
typedef PerformanceMarkOptions = {
	/**
		Additional optional detail to include with the mark.
	**/
	@:optional var detail:Dynamic;

	/**
		An optional timestamp to be used as the mark time.
		Default: `performance.now()`.
	**/
	@:optional var startTime:Float;
}
