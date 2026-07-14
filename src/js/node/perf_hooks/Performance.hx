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

import haxe.Constraints.Function;
import js.node.PerfHooks.EventLoopUtilization;
import js.node.PerfHooks.TimerifyOptions;
import js.node.web.Event;
import js.node.web.EventTarget;

// Bring secondary types (option typedefs) from sibling modules into scope.
import js.node.perf_hooks.PerformanceMark;
import js.node.perf_hooks.PerformanceMeasure;

/**
	Events emitted by `Performance` (via `EventTarget`).
**/
enum abstract PerformanceEvent(String) from String to String {
	/**
		The `'resourcetimingbufferfull'` event is fired when the global performance resource
		timing buffer is full. Adjust resource timing buffer size with
		`performance.setResourceTimingBufferSize()` or clear the buffer with
		`performance.clearResourceTimings()` in the event listener to allow more entries
		to be added to the performance timeline buffer.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#event-resourcetimingbufferfull
	**/
	var ResourceTimingBufferFull = "resourcetimingbufferfull";
}

/**
	An object that can be used to collect performance metrics from the current Node.js instance.
	It is similar to `window.performance` in browsers.

	Extends `EventTarget` (not `EventEmitter`).

	@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#perf_hooksperformance
**/
@:jsRequire("perf_hooks", "Performance")
extern class Performance extends EventTarget {
	/**
		If `name` is not provided, removes all `PerformanceMark` objects from the Performance Timeline.
		If `name` is provided, removes only the named mark.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceclearmarksname
	**/
	function clearMarks(?name:String):Void;

	/**
		If `name` is not provided, removes all `PerformanceMeasure` objects from the Performance Timeline.
		If `name` is provided, removes only the named measure.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceclearmeasuresname
	**/
	function clearMeasures(?name:String):Void;

	/**
		If `name` is not provided, removes all `PerformanceResourceTiming` objects from the Resource Timeline.
		If `name` is provided, removes only the named resource.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceclearresourcetimingsname
	**/
	function clearResourceTimings(?name:String):Void;

	/**
		Returns an object that contains the cumulative duration of time the event loop has been
		both idle and active as a high resolution milliseconds timer.

		This property is an extension by Node.js. It is not available in Web browsers.

		Prefer this over the module-level `PerfHooks.eventLoopUtilization` when targeting
		Node.js 22 LTS as well as Node.js 24; the module-level alias was only added in v24.12.0.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceeventlooputilizationutilization1-utilization2
	**/
	function eventLoopUtilization(?utilization1:EventLoopUtilization, ?utilization2:EventLoopUtilization):EventLoopUtilization;

	/**
		Returns a list of `PerformanceEntry` objects in chronological order with respect to
		`performanceEntry.startTime`.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancegetentries
	**/
	function getEntries():Array<PerformanceEntry>;

	/**
		Returns a list of `PerformanceEntry` objects in chronological order with respect to
		`performanceEntry.startTime` whose `performanceEntry.name` is equal to `name`, and optionally,
		whose `performanceEntry.entryType` is equal to `type`.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancegetentriesbynamename-type
	**/
	function getEntriesByName(name:String, ?type:PerformanceEntryType):Array<PerformanceEntry>;

	/**
		Returns a list of `PerformanceEntry` objects in chronological order with respect to
		`performanceEntry.startTime` whose `performanceEntry.entryType` is equal to `type`.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancegetentriesbytypetype
	**/
	function getEntriesByType(type:PerformanceEntryType):Array<PerformanceEntry>;

	/**
		Creates a new `PerformanceMark` entry in the Performance Timeline.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancemarkname-options
	**/
	function mark(name:String, ?options:PerformanceMarkOptions):PerformanceMark;

	/**
		Creates a new `PerformanceResourceTiming` entry in the Resource Timeline.

		This property is an extension by Node.js. It is not available in Web browsers.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancemarkresourcetimingtiminginfo-requestedurl-initiatortype-global-cachemode-bodyinfo-responsestatus-deliverytype
	**/
	function markResourceTiming(timingInfo:Dynamic, requestedUrl:String, initiatorType:String, global:Dynamic, cacheMode:String, bodyInfo:Dynamic,
		responseStatus:Int, ?deliveryType:String):PerformanceResourceTiming;

	/**
		Creates a new `PerformanceMeasure` entry in the Performance Timeline.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancemeasurename-startmarkoroptions-endmark
	**/
	@:overload(function(name:String, options:PerformanceMeasureOptions):PerformanceMeasure {})
	function measure(name:String, ?startMark:String, ?endMark:String):PerformanceMeasure;

	/**
		An instance of the `PerformanceNodeTiming` class that provides performance metrics for
		specific Node.js operational milestones.

		This property is an extension by Node.js. It is not available in Web browsers.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancenodetiming
	**/
	final nodeTiming:PerformanceNodeTiming;

	/**
		Returns the current high resolution millisecond timestamp, where 0 represents the start
		of the current `node` process.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancenow
	**/
	function now():Float;

	/**
		Sets the global performance resource timing buffer size to the specified number of
		"resource" type performance entry objects.

		By default the max buffer size is set to 250.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancesetresourcetimingbuffersizemaxsize
	**/
	function setResourceTimingBufferSize(maxSize:Int):Void;

	/**
		The timeOrigin specifies the high resolution millisecond timestamp at which the current
		`node` process began, measured in Unix time.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancetimeorigin
	**/
	final timeOrigin:Float;

	/**
		Wraps a function within a new function that measures the running time of the wrapped function.
		A `PerformanceObserver` must be subscribed to the `'function'` event type in order for the
		timing details to be accessed.

		This property is an extension by Node.js. It is not available in Web browsers.

		Prefer this over the module-level `PerfHooks.timerify` when targeting Node.js 22 LTS as well
		as Node.js 24; the module-level alias was only added in v24.12.0.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancetimerifyfn-options
	**/
	function timerify<T:Function>(fn:T, ?options:TimerifyOptions):T;

	/**
		An object which is JSON representation of the `performance` object.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performancetojson
	**/
	function toJSON():Dynamic;

	/**
		Event handler for the `'resourcetimingbufferfull'` event.
	**/
	var onresourcetimingbufferfull:Null<(event:Event) -> Void>;
}
