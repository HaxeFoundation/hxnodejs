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
	A `Histogram` that can record values.

	@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#class-recordablehistogram-extends-histogram
**/
extern class RecordableHistogram extends Histogram {
	/**
		Adds the values from `other` to this histogram.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#histogramaddother
	**/
	function add(other:RecordableHistogram):Void;

	/**
		Records `val` in the histogram.

		// TODO: allow BigInt when hxnodejs gains a BigInt type (Node accepts number | bigint).
		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#histogramrecordval
	**/
	function record(val:EitherType<Float, Dynamic>):Void;

	/**
		Calculates the amount of time (in nanoseconds) that has passed since the previous call
		to `recordDelta()` and records that amount in the histogram.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#histogramrecorddelta
	**/
	function recordDelta():Void;
}
