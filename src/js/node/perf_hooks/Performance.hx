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

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import js.node.PerfHooks.EventLoopUtilization;
import js.node.PerfHooks.TimerifyOptions;
import js.node.web.Event;
import js.node.web.EventTarget;

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

		@see https://nodejs.org/api/perf_hooks.html#event-resourcetimingbufferfull
	**/
	var ResourceTimingBufferFull = "resourcetimingbufferfull";
}

/**
	An object that can be used to collect performance metrics from the current Node.js instance.
	It is similar to `window.performance` in browsers.

	Extends `EventTarget` (not `EventEmitter`).

	@see https://nodejs.org/api/perf_hooks.html#class-performance
	@see https://nodejs.org/api/globals.html#performance
**/
@:jsRequire("perf_hooks", "Performance")
extern class Performance extends EventTarget {
	/**
		If `name` is not provided, removes all `PerformanceMark` objects from the Performance Timeline.
		If `name` is provided, removes only the named mark.
	**/
	function clearMarks(?name:String):Void;

	/**
		If `name` is not provided, removes all `PerformanceMeasure` objects from the Performance Timeline.
		If `name` is provided, removes only the named measure.
	**/
	function clearMeasures(?name:String):Void;

	/**
		If `name` is not provided, removes all `PerformanceResourceTiming` objects from the Resource Timeline.
		If `name` is provided, removes only the named resource.
	**/
	function clearResourceTimings(?name:String):Void;

	/**
		This is an alias of `PerfHooks.eventLoopUtilization()`.

		This property is an extension by Node.js. It is not available in Web browsers.
	**/
	function eventLoopUtilization(?utilization1:EventLoopUtilization, ?utilization2:EventLoopUtilization):EventLoopUtilization;

	/**
		Returns a list of `PerformanceEntry` objects in chronological order with respect to
		`performanceEntry.startTime`.
	**/
	function getEntries():Array<PerformanceEntry>;

	/**
		Returns a list of `PerformanceEntry` objects in chronological order with respect to
		`performanceEntry.startTime` whose `performanceEntry.name` is equal to `name`, and optionally,
		whose `performanceEntry.entryType` is equal to `type`.
	**/
	function getEntriesByName(name:String, ?type:PerformanceEntryType):Array<PerformanceEntry>;

	/**
		Returns a list of `PerformanceEntry` objects in chronological order with respect to
		`performanceEntry.startTime` whose `performanceEntry.entryType` is equal to `type`.
	**/
	function getEntriesByType(type:PerformanceEntryType):Array<PerformanceEntry>;

	/**
		Creates a new `PerformanceMark` entry in the Performance Timeline.
	**/
	function mark(name:String, ?options:PerformanceMarkOptions):PerformanceMark;

	/**
		Creates a new `PerformanceResourceTiming` entry in the Resource Timeline.

		This property is an extension by Node.js. It is not available in Web browsers.
	**/
	function markResourceTiming(timingInfo:Dynamic, requestedUrl:String, initiatorType:String, global:Dynamic, cacheMode:String, bodyInfo:Dynamic,
		responseStatus:Int, ?deliveryType:String):PerformanceResourceTiming;

	/**
		Creates a new `PerformanceMeasure` entry in the Performance Timeline.
	**/
	@:overload(function(name:String, ?startMark:String, ?endMark:String):PerformanceMeasure {})
	function measure(name:String, options:PerformanceMeasureOptions):PerformanceMeasure;

	/**
		An instance of the `PerformanceNodeTiming` class that provides performance metrics for
		specific Node.js operational milestones.

		This property is an extension by Node.js. It is not available in Web browsers.
	**/
	var nodeTiming(default, null):PerformanceNodeTiming;

	/**
		Returns the current high resolution millisecond timestamp, where 0 represents the start
		of the current `node` process.
	**/
	function now():Float;

	/**
		Sets the global performance resource timing buffer size to the specified number of
		"resource" type performance entry objects.

		By default the max buffer size is set to 250.
	**/
	function setResourceTimingBufferSize(maxSize:Int):Void;

	/**
		The timeOrigin specifies the high resolution millisecond timestamp at which the current
		`node` process began, measured in Unix time.
	**/
	var timeOrigin(default, null):Float;

	/**
		This is an alias of `PerfHooks.timerify()`.

		This property is an extension by Node.js. It is not available in Web browsers.
	**/
	function timerify<T:Function>(fn:T, ?options:TimerifyOptions):T;

	/**
		An object which is JSON representation of the `performance` object.
	**/
	function toJSON():Dynamic;

	/**
		Event handler for the `'resourcetimingbufferfull'` event.
	**/
	var onresourcetimingbufferfull:EitherType<Event->Void, Function>;
}
