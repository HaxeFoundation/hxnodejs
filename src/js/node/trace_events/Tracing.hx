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

package js.node.trace_events;

/**
	The `Tracing` object is used to enable or disable tracing for sets of categories.
	Instances are created via `TraceEvents.createTracing()`.

	When created, the object is disabled. Calling `enable()` adds its categories to
	the enabled set; `disable()` removes them (except where still covered by another
	enabled `Tracing` object or `--trace-event-categories`).

	@see https://nodejs.org/docs/latest-v24.x/api/tracing.html#tracing-object
**/
extern class Tracing {
	/**
		A comma-separated list of the trace event categories covered by this object.
	**/
	final categories:String;

	/**
		`true` only if this `Tracing` object has been enabled.
	**/
	final enabled:Bool;

	/**
		Enables this `Tracing` object for the set of categories it covers.
	**/
	function enable():Void;

	/**
		Disables this `Tracing` object.

		Only categories not covered by other enabled `Tracing` objects and not
		specified by `--trace-event-categories` are disabled.
	**/
	function disable():Void;
}
