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
	`PerformanceObserver` objects provide notifications when new `PerformanceEntry`
	instances have been added to the Performance Timeline.

	@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#class-performanceobserver
**/
@:jsRequire("perf_hooks", "PerformanceObserver")
extern class PerformanceObserver {
	/**
		Get supported entry types.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceobserversupportedentrytypes
	**/
	static final supportedEntryTypes:Array<PerformanceEntryType>;

	/**
		Creates a new `PerformanceObserver`.

		The `callback` is invoked when a `PerformanceObserver` is notified about new
		`PerformanceEntry` instances.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#new-performanceobservercallback
	**/
	function new(callback:PerformanceObserverCallback);

	/**
		Disconnects the `PerformanceObserver` instance from all notifications.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceobserverdisconnect
	**/
	function disconnect():Void;

	/**
		Subscribes the instance to notifications of new instances identified either by
		`options.entryTypes` or `options.type`.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceobserverobserveoptions
	**/
	function observe(options:PerformanceObserverObserveOptions):Void;

	/**
		Returns the current list of entries stored in the performance observer, emptying it out.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceobservertakerecords
	**/
	function takeRecords():Array<PerformanceEntry>;
}

/**
	Callback invoked when a `PerformanceObserver` is notified about new entries.
**/
typedef PerformanceObserverCallback = (list:PerformanceObserverEntryList, observer:PerformanceObserver) -> Void;

/**
	Options for `PerformanceObserver.observe`.
**/
typedef PerformanceObserverObserveOptions = {
	/**
		A single entry type. Must not be given if `entryTypes` is already specified.
	**/
	@:optional var type:PerformanceEntryType;

	/**
		An array of strings identifying the types of instances the observer is interested in.
		If not provided an error will be thrown.
	**/
	@:optional var entryTypes:Array<PerformanceEntryType>;

	/**
		If `true`, the observer callback is called with a list of global `PerformanceEntry`
		buffered entries. If `false`, only `PerformanceEntry`s created after the time point
		are sent to the observer callback. Default: `false`.
	**/
	@:optional var buffered:Bool;
}
