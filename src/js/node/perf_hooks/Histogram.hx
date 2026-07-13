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

package js.node.perf_hooks;

/**
	Histogram for recording values (e.g. event loop delay samples).

	The constructor of this class is not exposed to users.

	@see https://nodejs.org/api/perf_hooks.html#class-histogram
**/
extern class Histogram {
	/**
		The number of samples recorded by the histogram.
	**/
	var count(default, null):Float;

	/**
		The number of samples recorded by the histogram (as a BigInt).
	**/
	var countBigInt(default, null):Dynamic;

	/**
		The number of times the event loop delay exceeded the maximum 1 hour event loop delay threshold.
	**/
	var exceeds(default, null):Float;

	/**
		The number of times the event loop delay exceeded the maximum 1 hour event loop delay threshold (as a BigInt).
	**/
	var exceedsBigInt(default, null):Dynamic;

	/**
		The maximum recorded event loop delay.
	**/
	var max(default, null):Float;

	/**
		The maximum recorded event loop delay (as a BigInt).
	**/
	var maxBigInt(default, null):Dynamic;

	/**
		The mean of the recorded event loop delays.
	**/
	var mean(default, null):Float;

	/**
		The minimum recorded event loop delay.
	**/
	var min(default, null):Float;

	/**
		The minimum recorded event loop delay (as a BigInt).
	**/
	var minBigInt(default, null):Dynamic;

	/**
		Returns the value at the given percentile.

		@param percentile A percentile value in the range (0, 100].
	**/
	function percentile(percentile:Float):Float;

	/**
		Returns the value at the given percentile (as a BigInt).

		@param percentile A percentile value in the range (0, 100].
	**/
	function percentileBigInt(percentile:Float):Dynamic;

	/**
		Returns a `Map` object detailing the accumulated percentile distribution.
	**/
	var percentiles(default, null):Dynamic;

	/**
		Returns a `Map` object detailing the accumulated percentile distribution (BigInt keys/values).
	**/
	var percentilesBigInt(default, null):Dynamic;

	/**
		Resets the collected histogram data.
	**/
	function reset():Void;

	/**
		The standard deviation of the recorded event loop delays.
	**/
	var stddev(default, null):Float;
}
