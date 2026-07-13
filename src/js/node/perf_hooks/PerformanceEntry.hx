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
	The constructor of this class is not exposed to users directly.

	@see https://nodejs.org/api/perf_hooks.html#class-performanceentry
**/
@:jsRequire("perf_hooks", "PerformanceEntry")
extern class PerformanceEntry {
	/**
		The total number of milliseconds elapsed for this entry.
		This value will not be meaningful for all Performance Entry types.
	**/
	var duration(default, null):Float;

	/**
		The type of the performance entry.
	**/
	var entryType(default, null):PerformanceEntryType;

	/**
		The name of the performance entry.
	**/
	var name(default, null):String;

	/**
		The high resolution millisecond timestamp marking the starting time of the Performance Entry.
	**/
	var startTime(default, null):Float;

	/**
		Returns a JSON representation of the `PerformanceEntry` object.
	**/
	function toJSON():Dynamic;
}
