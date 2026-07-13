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

package js.node;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import js.node.perf_hooks.IntervalHistogram;
import js.node.perf_hooks.Performance;
import js.node.perf_hooks.RecordableHistogram;

/**
	This module provides an implementation of a subset of the W3C Web Performance APIs
	as well as additional APIs for Node.js-specific performance measurements.

	@see https://nodejs.org/api/perf_hooks.html
**/
@:jsRequire("perf_hooks")
extern class PerfHooks {
	/**
		An object that can be used to collect performance metrics from the current Node.js instance.
		It is similar to `window.performance` in browsers.

		@see https://nodejs.org/api/perf_hooks.html#perf_hooksperformance
	**/
	static var performance(default, never):Performance;

	/**
		Constants for garbage collection kinds and flags.

		@see https://nodejs.org/api/perf_hooks.html#perf_hooksconstants
	**/
	static var constants(default, never):PerfHooksConstants;

	/**
		Returns a `RecordableHistogram`.

		@see https://nodejs.org/api/perf_hooks.html#perf_hookscreatehistogramoptions
	**/
	static function createHistogram(?options:CreateHistogramOptions):RecordableHistogram;

	/**
		Creates an `IntervalHistogram` object that samples and reports the event loop delay over time.
		The delays will be reported in nanoseconds.

		This property is an extension by Node.js. It is not available in Web browsers.

		@see https://nodejs.org/api/perf_hooks.html#perf_hooksmonitoreventloopdelayoptions
	**/
	static function monitorEventLoopDelay(?options:EventLoopMonitorOptions):IntervalHistogram;

	/**
		Returns an object that contains the cumulative duration of time the event loop has been
		both idle and active as a high resolution milliseconds timer.

		@see https://nodejs.org/api/perf_hooks.html#perf_hookseventlooputilizationutilization1-utilization2
	**/
	static function eventLoopUtilization(?utilization1:EventLoopUtilization, ?utilization2:EventLoopUtilization):EventLoopUtilization;

	/**
		Wraps a function within a new function that measures the running time of the wrapped function.
		A `PerformanceObserver` must be subscribed to the `'function'` event type in order for the
		timing details to be accessed.

		This property is an extension by Node.js. It is not available in Web browsers.

		@see https://nodejs.org/api/perf_hooks.html#perf_hookstimerifyfn-options
	**/
	static function timerify<T:Function>(fn:T, ?options:TimerifyOptions):T;
}

/**
	Constants exported by `perf_hooks.constants`.
**/
typedef PerfHooksConstants = {
	var NODE_PERFORMANCE_GC_MAJOR(default, never):Int;
	var NODE_PERFORMANCE_GC_MINOR(default, never):Int;
	var NODE_PERFORMANCE_GC_INCREMENTAL(default, never):Int;
	var NODE_PERFORMANCE_GC_WEAKCB(default, never):Int;
	var NODE_PERFORMANCE_GC_FLAGS_NO(default, never):Int;
	var NODE_PERFORMANCE_GC_FLAGS_CONSTRUCT_RETAINED(default, never):Int;
	var NODE_PERFORMANCE_GC_FLAGS_FORCED(default, never):Int;
	var NODE_PERFORMANCE_GC_FLAGS_SYNCHRONOUS_PHANTOM_PROCESSING(default, never):Int;
	var NODE_PERFORMANCE_GC_FLAGS_ALL_AVAILABLE_GARBAGE(default, never):Int;
	var NODE_PERFORMANCE_GC_FLAGS_ALL_EXTERNAL_MEMORY(default, never):Int;
	var NODE_PERFORMANCE_GC_FLAGS_SCHEDULE_IDLE(default, never):Int;
}

/**
	Options for `PerfHooks.createHistogram`.
**/
typedef CreateHistogramOptions = {
	/**
		The lowest discernible value. Must be an integer value greater than 0.
		Default: `1`.
	**/
	@:optional var lowest:EitherType<Float, Dynamic>;

	/**
		The highest recordable value. Must be an integer value that is equal to or greater than
		two times `lowest`. Default: `Number.MAX_SAFE_INTEGER`.
	**/
	@:optional var highest:EitherType<Float, Dynamic>;

	/**
		The number of accuracy digits. Must be a number between `1` and `5`.
		Default: `3`.
	**/
	@:optional var figures:Int;
}

/**
	Options for `PerfHooks.monitorEventLoopDelay`.
**/
typedef EventLoopMonitorOptions = {
	/**
		The sampling rate in milliseconds. Must be greater than zero.
		Default: `10`.
	**/
	@:optional var resolution:Float;
}

/**
	Result of `PerfHooks.eventLoopUtilization` / `Performance.eventLoopUtilization`.
**/
typedef EventLoopUtilization = {
	var idle:Float;
	var active:Float;
	var utilization:Float;
}

/**
	Options for `PerfHooks.timerify` / `Performance.timerify`.
**/
typedef TimerifyOptions = {
	/**
		A histogram object created using `PerfHooks.createHistogram()` that will record
		runtime durations in nanoseconds.
	**/
	@:optional var histogram:RecordableHistogram;
}
