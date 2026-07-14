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

package js.node.console;

import haxe.extern.EitherType;
import haxe.extern.Rest;
import js.lib.Map;
import js.node.stream.Writable;

/**
	The `Console` class can be used to create a simple logger with configurable output streams
	and can be accessed using either `require('node:console').Console` or `console.Console`
	(or their destructured counterparts).

	@see https://nodejs.org/api/console.html#class-console
**/
@:jsRequire("console", "Console")
extern class Console {
	/**
		Creates a new `Console` with one or two writable stream instances. `stdout` is a writable stream to print log or info output.
		`stderr` is used for warning or error output. If `stderr` is not provided, `stdout` is used for `stderr`.

		@see https://nodejs.org/api/console.html#new-consolestdout-stderr-ignoreerrors
	**/
	@:overload(function(options:ConsoleOptions):Void {})
	function new(stdout:IWritable, ?stderr:IWritable, ?ignoreErrors:Bool):Void;

	/**
		Writes a message if `value` is falsy or omitted. It only writes a message and does not otherwise affect execution.
		The output always starts with `"Assertion failed"`. If provided, `message` is formatted using `util.format()`.

		@see https://nodejs.org/api/console.html#consoleassertvalue-message
	**/
	function assert(?value:Any, message:Rest<Any>):Void;

	/**
		When `stdout` is a TTY, calling `console.clear()` will attempt to clear the TTY.
		When `stdout` is not a TTY, this method does nothing.

		@see https://nodejs.org/api/console.html#consoleclear
	**/
	function clear():Void;

	/**
		Maintains an internal counter specific to `label` and outputs to `stdout` the number of times
		`console.count()` has been called with the given `label`.

		@see https://nodejs.org/api/console.html#consolecountlabel
	**/
	function count(?label:String):Void;

	/**
		Resets the internal counter specific to `label`.

		@see https://nodejs.org/api/console.html#consolecountresetlabel
	**/
	function countReset(?label:String):Void;

	/**
		The `console.debug()` function is an alias for `console.log()`.

		@see https://nodejs.org/api/console.html#consoledebugdata-args
	**/
	function debug(data:Rest<Any>):Void;

	/**
		Uses `util.inspect()` on `obj` and prints the resulting string to `stdout`.
		This function bypasses any custom `inspect()` function defined on `obj`.

		@see https://nodejs.org/api/console.html#consoledirobj-options
	**/
	function dir(?obj:Any, ?options:Util.InspectOptionsBase):Void;

	/**
		This method calls `console.log()` passing it the arguments received.
		This method does not produce any XML formatting.

		@see https://nodejs.org/api/console.html#consoledirxmldata
	**/
	function dirxml(data:Rest<Any>):Void;

	/**
		Prints to `stderr` with newline. Multiple arguments can be passed,
		with the first used as the primary message and all additional used as substitution values similar to printf(3)
		(the arguments are all passed to `util.format()`).

		@see https://nodejs.org/api/console.html#consoleerrordata-args
	**/
	function error(data:Rest<Any>):Void;

	/**
		Increases indentation of subsequent lines by spaces for `groupIndentation` length.
		If one or more `label`s are provided, those are printed first without the additional indentation.

		@see https://nodejs.org/api/console.html#consolegrouplabel
	**/
	function group(label:Rest<Any>):Void;

	/**
		An alias for `console.group()`.

		@see https://nodejs.org/api/console.html#consolegroupcollapsed
	**/
	function groupCollapsed(label:Rest<Any>):Void;

	/**
		Decreases indentation of subsequent lines by spaces for `groupIndentation` length.

		@see https://nodejs.org/api/console.html#consolegroupend
	**/
	function groupEnd():Void;

	/**
		The `console.info()` function is an alias for `console.log()`.

		@see https://nodejs.org/api/console.html#consoleinfodata-args
	**/
	function info(data:Rest<Any>):Void;

	/**
		Prints to `stdout` with newline. Multiple arguments can be passed,
		with the first used as the primary message and all additional used as substitution values similar to printf(3)
		(the arguments are all passed to `util.format()`).

		@see https://nodejs.org/api/console.html#consolelogdata-args
	**/
	function log(data:Rest<Any>):Void;

	/**
		Try to construct a table with the columns of the properties of `tabularData` (or use `properties`)
		and rows of `tabularData` and log it. Falls back to just logging the argument if it can't be parsed as tabular.

		@see https://nodejs.org/api/console.html#consoletabletabulardata-properties
	**/
	function table(?tabularData:Any, ?properties:Array<String>):Void;

	/**
		Starts a timer that can be used to compute the duration of an operation. Timers are identified by a unique `label`.
		Use the same `label` when calling `console.timeEnd()` to stop the timer and output the elapsed time in suitable
		time units to `stdout`.

		@see https://nodejs.org/api/console.html#consoletimelabel
	**/
	function time(?label:String):Void;

	/**
		Stops a timer that was previously started by calling `console.time()` and prints the result to `stdout`.

		@see https://nodejs.org/api/console.html#consoletimeendlabel
	**/
	function timeEnd(?label:String):Void;

	/**
		For a timer that was previously started by calling `console.time()`, prints the elapsed time and other `data`
		arguments to `stdout`.

		@see https://nodejs.org/api/console.html#consoletimeloglabel-data
	**/
	function timeLog(?label:String, data:Rest<Any>):Void;

	/**
		Prints to `stderr` the string `'Trace: '`, followed by the `util.format()` formatted message and stack trace
		to the current position in the code.

		@see https://nodejs.org/api/console.html#consoletracemessage-args
	**/
	function trace(message:Rest<Any>):Void;

	/**
		The `console.warn()` function is an alias for `console.error()`.

		@see https://nodejs.org/api/console.html#consolewarndata-args
	**/
	function warn(data:Rest<Any>):Void;

	/**
		Removed from Node.js; previously the deprecated form of `console.timeStamp()`.

		@see https://nodejs.org/api/console.html#consoletimestamplabel
	**/
	@:deprecated("Use timeStamp instead")
	function markTimeline(?label:String):Void;

	/**
		This method does not display anything unless used in the inspector.
		The `console.profile()` method starts a JavaScript CPU profile with an optional label until `console.profileEnd()` is called.
		The profile is then added to the Profile panel of the inspector.

		@see https://nodejs.org/api/console.html#consoleprofilelabel
	**/
	function profile(?label:String):Void;

	/**
		This method does not display anything unless used in the inspector.
		Stops the current JavaScript CPU profiling session if one has been started and prints the report to the Profiles panel of the inspector.
		See `console.profile()` for an example.

		If this method is called without a label, the most recently started profile is stopped.

		@see https://nodejs.org/api/console.html#consoleprofileendlabel
	**/
	function profileEnd(?label:String):Void;

	/**
		This method does not display anything unless used in the inspector.
		The `console.timeStamp()` method adds an event with the label `'label'` to the Timeline panel of the inspector.

		@see https://nodejs.org/api/console.html#consoletimestamplabel
	**/
	function timeStamp(?label:String):Void;

	/**
		Removed from Node.js; previously the deprecated form of `console.time()`.

		@see https://nodejs.org/api/console.html#consoletimelabel
	**/
	@:deprecated("Use time instead")
	function timeline(?label:String):Void;

	/**
		Removed from Node.js; previously the deprecated form of `console.timeEnd()`.

		@see https://nodejs.org/api/console.html#consoletimeendlabel
	**/
	@:deprecated("Use timeEnd instead")
	function timelineEnd(?label:String):Void;
}

/**
	Color mode for `ConsoleOptions.colorMode`.
**/
enum abstract ConsoleColorMode(String) from String to String {
	var Auto = "auto";
}

/**
	Options for the `Console` constructor options-object form.
**/
typedef ConsoleOptions = {
	/**
		Writable stream for log / info output.
	**/
	var stdout:IWritable;

	/**
		Writable stream for warning / error output. If not provided, `stdout` is used for `stderr`.
	**/
	@:optional var stderr:IWritable;

	/**
		Ignore errors when writing to the underlying streams. Default: `true`.
	**/
	@:optional var ignoreErrors:Bool;

	/**
		Set color support for this `Console` instance. Setting to `true` enables coloring while inspecting values.
		Setting to `false` disables coloring while inspecting values.
		Setting to `'auto'` makes color support depend on the value of the `isTTY` property and the value returned by
		`getColorDepth()` on the respective stream.
		This option can not be used if `inspectOptions.colors` is set as well. Default: `'auto'`.
	**/
	@:optional var colorMode:EitherType<Bool, ConsoleColorMode>;

	/**
		Options passed along to `util.inspect()`.
		Can be an options object or, if different options for stdout and stderr are desired, a `Map` from stream objects to options.
	**/
	@:optional var inspectOptions:EitherType<Util.InspectOptions, Map<IWritable, Util.InspectOptions>>;

	/**
		Set group indentation. Default: `2`.
	**/
	@:optional var groupIndentation:Int;
}
