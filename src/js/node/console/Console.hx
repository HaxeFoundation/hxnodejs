/*
 * Copyright (C)2014-2019 Haxe Foundation
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

import js.node.stream.Writable;

/**
	For printing to stdout and stderr.

	Similar to the console object functions provided by most web browsers, here the output is sent to stdout or stderr.

	The console functions are synchronous when the destination is a terminal or a file (to avoid lost messages in case of premature exit
	and asynchronous  when it's a pipe (to avoid blocking for long periods of time).
**/
@:jsRequire("console", "Console")
extern class Console {

	typedef ConsoleOptions={
		var stdout:Writable;
		@optional var stderr:Writable;
		@optional var ignoreErrors:Bool;
		@optional var colorMode:haxe.extern.EitherType<Bool,String>;
		@optional var inspectOptions:Util.InspectOptions;
	};

	/**
		Create a new `Console` by passing one or two writable stream instances.
		`stdout` is a writable stream to print log or info output.
		`stderr` is used for warning or error output. If `stderr` isn't passed,
		the warning and error output will be sent to the `stdout`.

		* `options` <Object>
			* `stdout` <stream.Writable>
			* `stderr` <stream.Writable>
			* `ignoreErrors` <boolean> Ignore errors when writing to the underlying streams. Default: `true`.
			* `colorMode` <boolean> | <string> Set color support for this `Console` instance.
					Setting to `true` enables coloring while inspecting values,
					setting to `'auto'` will make color support depend on the value of the `isTTY` property and the value returned by `getColorDepth()` on the respective stream. 
					This option can not be used, if `inspectOptions.colors` is set as well. Default: `'auto'`.
			* `inspectOptions` <Object> Specifies options that are passed along to `util.inspect()`.

		Creates a new `Console` with one or two writable stream instances. 
		`stdout` is a writable stream to print log or info output. 
		`stderr` is used for warning or error output. If `stderr` is not provided, `stdout` is used for `stderr`.

		The global `console` is a special `Console` whose output is sent to `process.stdout` and `process.stderr`. It is equivalent to calling:
	**/
	@:overload(function(options:ConsoleOptions):Void { })
	function new(stdout:IWritable, ?stderr:IWritable,?ignoreerrors:Bool):Void;


	/**
		* `value` <any> The value tested for being truthy.
		* `...message` <any> All arguments besides `value` are used as error message.

		A simple assertion test that verifies whether `value` is truthy. If it is not, `Assertion failed` is logged. 
		If provided, the error `message` is formatted using util.format() by passing along all message arguments. The output is used as the error message.

		Calling `console.assert()` with a falsy assertion will only cause the `message` to be printed to the console without interrupting execution of subsequent code.
	**/

	function assert(value:Dynamic,message:haxe.extern.Rest<Dynamic>):Void;
	/**
		When `stdout` is a TTY, calling `console.clear()` will attempt to clear the TTY. When `stdout` is not a TTY, this method does nothing.

		The specific operation of `console.clear()` can vary across operating systems and terminal types. For most Linux operating systems, `console.clear()` operates similarly to the clear shell command.
  		On Windows, `console.clear()` will clear only the output in the current terminal viewport for the Node.js binary.
	**/
	function clear():Void;

	/**
		* `label` <string> The display label for the counter. `Default`: 'default'.

	Maintains an internal counter specific to `label` and outputs to `stdout` the number of times `console.count()` has been called with the given `label`.**/
	function count(?label:String):Void;
	/**
		* `label` <string> The display label for the counter. `Default`: 'default'.

		Resets the internal counter specific to `label`.
	**/
	function countReset(?label:String):Void;
	/**
		* `data` <any>
		* `...args` <any>
		The `console.debug()` function is an alias for console.log().**/
	function debug(data:Dynamic, args:haxe.extern.Rest<Dynamic>):Void;

	/**
		* `obj` <any>
		* `options` <Object>
			* `showHidden` <boolean> If `true` then the object's non-enumerable and symbol properties will be shown too. Default: `false`.
			* `depth` <number> Tells `util.inspect()` how many times to recurse while formatting the object. This is useful for inspecting large complicated objects. 
				To make it recurse indefinitely, pass `null`. Default: `2`.
			* `colors` <boolean> If `true`, then the output will be styled with ANSI color codes. 
				Colors are customizable; see customizing `util.inspect()` colors. Default: `false`.

		Uses `util.inspect()` on `obj` and prints the resulting string to stdout. 
		This function bypasses any custom `inspect()` function defined on `obj`.
	**/
	function dir(obj:Dynamic, ?options:Util.InspectOptionsBase):Void;
	/**
		* `...data` <any>
		
		This method calls console.log() passing it the arguments received. This method does not produce any XML formatting.
	**/
	function dirxml(data:haxe.extern.Rest<Dynamic>):Void;

	/**
		* `data` <any>
		* `...args` <any>

		Prints to `stderr` with newline. 
		Multiple arguments can be passed, with the first used as the primary message and all additional used as substitution values similar to `printf(3)` (the arguments are all passed to `util.format()`).
	**/
	function error(data:Dynamic, args:haxe.extern.Rest<Dynamic>):Void;

	/**
		* `data` <any>
		* `...args` <any>

		The `console.info()` function is an alias for `console.log()`.
	**/
	function info(data:Dynamic, args:haxe.extern.Rest<Dynamic>):Void;


	/**
		* `...label` <any>

		Increases indentation of subsequent lines by two spaces.

		If one or more `label`s are provided, those are printed first without the additional indentation.
	**/
	function group(label:haxe.extern.Rest<Dynamic>):Void;
	/**
		An alias for `console.group()`.
	**/
	function groupCollapsed():Void;
	/**
		Decreases indentation of subsequent lines by two spaces.
	**/
	function groupEnd():Void;

	/**
		* `data` <any>
		* `...args` <any>

		Prints to `stdout` with newline. Multiple arguments can be passed, 
		with the first used as the primary message and all additional used as substitution values similar to `printf(3)` (the arguments are all passed to `util.format()`).
		See `util.format()` for more information.
	**/
	function log(data:Dynamic, args:haxe.extern.Rest<Dynamic>):Void;

	/**
		* `tabularData` <any>
		* `properties` <string[]> Alternate properties for constructing the table.
		Try to construct a table with the columns of the properties of `tabularData` (or use `properties`) and rows of `tabularData` and log it. 
		Falls back to just logging the argument if it can’t be parsed as tabular.
	**/
	function table(tabularData:Dynamic,?properties:Array<String>):Void;



	/**
		* `label` <string> Default: `'default'`

		Starts a timer that can be used to compute the duration of an operation. 
		Timers are identified by a unique `label`. 
		Use the same `label` when calling `console.timeEnd()` to stop the timer and output the elapsed time in milliseconds to stdout. 
		Timer durations are accurate to the sub-millisecond.
	**/
	function time(?label:String):Void;

	/**
		* `label` <string> Default: `'default'`

		Stops a timer that was previously started by calling `console.time()` and prints the result to `stdout`:
	**/
	function timeEnd(?label:String):Void;

	/**
		* `label` <string> Default: `'default'`
		* `...data` <any>
		For a timer that was previously started by calling `console.time()`, prints the elapsed time and other `data` arguments to `stdout`:
	**/
	function timeLog(?label:String,data:haxe.extern.Rest<Dynamic>):Void;

	/**
		* `message` <any>
		* `...args` <any>

		Prints to `stderr` the string `'Trace: '`, 
		followed by the `util.format()` formatted message and stack trace to the current position in the code.
	**/
	function trace(message:Dynamic, args:haxe.extern.Rest<Dynamic>):Void;
	/**
		* `data` <any>
		* `...args` <any>

		The `console.warn()` function is an alias for `console.error()`.
	**/
	function warn(data:Dynamic, args:haxe.extern.Rest<Dynamic>):Void;

	//
	//Inspector only methods
	//

	/**
		* `label` <string> Default: `'default'`

		This method does not display anything unless used in the inspector. The `console.markTimeline()` method is the deprecated form of console.timeStamp().
	**/
	function markTimeline(?label:String):Void;
	/**
		`label` <string>

		This method does not display anything unless used in the inspector.
		The `console.profile()` method starts a JavaScript CPU profile with an optional label until `console.profileEnd()` is called. 
		The profile is then added to the Profile panel of the inspector.
	**/
	function profile(?label:String):Void;
	/**
		* `label` <string>

		This method does not display anything unless used in the inspector. 
		Stops the current JavaScript CPU profiling session if one has been started and prints the report to the Profiles panel of the inspector. 
		See `console.profile()` for an example.

		If this method is called without a label, the most recently started profile is stopped.
	**/
	function profileEnd(?label:String):Void;
	/**
		* `label` <string>

		This method does not display anything unless used in the inspector. 
		The `console.timeStamp()` method adds an event with the label `'label'` to the Timeline panel of the inspector.
	**/
	function timeStamp(?label:String):Void;
	/**
		* `label` <string> Default: `'default'`

		This method does not display anything unless used in the inspector. The `console.timeline()` method is the deprecated form of `console.time()`.
	**/
	function timeline(?label:String):Void;
	/**
		* `label` <string> Default: `'default'`

		This method does not display anything unless used in the inspector. The `console.timelineEnd()` method is the deprecated form of `console.timeEnd()`.
	**/
	function timelineEnd(?label:String):Void;


}
