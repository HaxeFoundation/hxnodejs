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

import haxe.extern.EitherType;

/**
	Exposes measures created via the `Performance.measure()` method.

	The constructor of this class is not exposed to users directly.

	@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#class-performancemeasure
**/
@:jsRequire("perf_hooks", "PerformanceMeasure")
extern class PerformanceMeasure extends PerformanceEntry {
	/**
		Additional detail specified when creating with `Performance.measure()` method.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancemeasuredetail
	**/
	final detail:Dynamic;
}

/**
	Options for `Performance.measure` when using the options-object form.
**/
typedef PerformanceMeasureOptions = {
	/**
		Additional optional detail to include with the measure.
	**/
	@:optional var detail:Dynamic;

	/**
		Duration between start and end times.
	**/
	@:optional var duration:Float;

	/**
		Timestamp to be used as the end time, or a string identifying a previously recorded mark.
	**/
	@:optional var end:EitherType<String, Float>;

	/**
		Timestamp to be used as the start time, or a string identifying a previously recorded mark.
	**/
	@:optional var start:EitherType<String, Float>;
}
