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
	A `Histogram` that is periodically updated on a given interval.

	@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#class-intervalhistogram-extends-histogram
**/
extern class IntervalHistogram extends Histogram {
	/**
		Disables the update interval timer. Returns `true` if the timer was stopped,
		`false` if it was already stopped.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#histogramdisable
	**/
	function disable():Bool;

	/**
		Enables the update interval timer. Returns `true` if the timer was started,
		`false` if it was already started.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#histogramenable
	**/
	function enable():Bool;

	/**
		Disables the update interval timer when the histogram is disposed.

		Corresponds to JavaScript `histogram[Symbol.dispose]()`. Added in Node.js v24.2.0.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#histogramsymboldispose
	**/
	public inline function dispose():Void {
		js.Syntax.code("{0}[Symbol.dispose]()", this);
	}
}
