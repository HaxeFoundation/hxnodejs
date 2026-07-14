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
	This property is an extension by Node.js. It is not available in Web browsers.

	Provides timing details for Node.js itself. The constructor of this class is
	not exposed to users.

	@see https://nodejs.org/api/perf_hooks.html#class-performancenodetiming
**/
extern class PerformanceNodeTiming extends PerformanceEntry {
	/**
		The high resolution millisecond timestamp at which the Node.js process completed bootstrapping.
		If bootstrapping has not yet finished, the property has the value of -1.
	**/
	var bootstrapComplete(default, null):Float;

	/**
		The high resolution millisecond timestamp at which the Node.js environment was initialized.
	**/
	var environment(default, null):Float;

	/**
		The high resolution millisecond timestamp of the amount of time the event loop has been idle
		within the event loop's event provider (e.g. `epoll_wait`). This does not take CPU usage into
		consideration. If the event loop has not yet started, the property has the value of 0.
	**/
	var idleTime(default, null):Float;

	/**
		The high resolution millisecond timestamp at which the Node.js event loop exited.
		If the event loop has not yet exited, the property has the value of -1.
	**/
	var loopExit(default, null):Float;

	/**
		The high resolution millisecond timestamp at which the Node.js event loop started.
		If the event loop has not yet started, the property has the value of -1.
	**/
	var loopStart(default, null):Float;

	/**
		The high resolution millisecond timestamp at which the Node.js process was initialized.
	**/
	var nodeStart(default, null):Float;

	/**
		A wrapper to the `uv_metrics_info` function. Returns the current set of event loop metrics.

		It is recommended to use this property inside a function whose execution was scheduled using
		`setImmediate` to avoid collecting metrics before finishing all operations scheduled during
		the current loop iteration.
	**/
	var uvMetricsInfo(default, null):UVMetrics;

	/**
		The high resolution millisecond timestamp at which the V8 platform was initialized.
	**/
	var v8Start(default, null):Float;
}

/**
	Event loop metrics from `PerformanceNodeTiming.uvMetricsInfo`.
**/
typedef UVMetrics = {
	/**
		Number of event loop iterations.
	**/
	var loopCount:Float;

	/**
		Number of events that have been processed by the event handler.
	**/
	var events:Float;

	/**
		Number of events that were waiting to be processed when the event provider was called.
	**/
	var eventsWaiting:Float;
}
