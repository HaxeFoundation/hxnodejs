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
	/**
		Create a new `Console` by passing one or two writable stream instances.
		`stdout` is a writable stream to print log or info output.
		`stderr` is used for warning or error output. If `stderr` isn't passed,
		the warning and error output will be sent to the `stdout`.
	**/
	//TODO:overload new Console(stdout[, stderr][, ignoreErrors])
	//TODO:overload new Console(options)
	function new(stdout:IWritable, ?stderr:IWritable);
	/**
		Similar to `Assert.ok`, but the error message is formatted as `Util.format(message...)`.
	**/
	@:overload(function(value:Bool, args:haxe.extern.Rest<Dynamic>):Void {})
	@:overload(function(value:Bool, message:String, args:haxe.extern.Rest<Dynamic>):Void {})
	function assert(value:Bool):Void;
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
		Uses util.inspect on obj and prints resulting string to stdout.

		This function bypasses any custom inspect() function on obj.
		An optional options object may be passed that alters certain aspects
		of the formatted string.
	**/
	function dir(obj:Dynamic, ?options:Util.InspectOptionsBase):Void;
	/**
		* `...data` <any>
		
		This method calls console.log() passing it the arguments received. This method does not produce any XML formatting.
	**/
	function dirxml(data:haxe.extern.Rest<Dynamic>):Void;

	/**
		Same as `log` but prints to stderr.
	**/
	@:overload(function(args:haxe.extern.Rest<Dynamic>):Void {})
	function error(data:String, args:haxe.extern.Rest<Dynamic>):Void;

	/**
		Same as `log`.
	**/
	@:overload(function(args:haxe.extern.Rest<Dynamic>):Void {})
	function info(data:String, args:haxe.extern.Rest<Dynamic>):Void;


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
		Prints to stdout with newline. This function can take multiple arguments in a printf()-like way.
		Example: console.log('count: %d', count);
		If formatting elements are not found in the first string then `Util.inspect` is used on each argument.
		See `Util.format` for more information.
	**/
	@:overload(function(args:haxe.extern.Rest<Dynamic>):Void {})
	function log(data:String, args:haxe.extern.Rest<Dynamic>):Void;

	/**
		* `tabularData` <any>
		* `properties` <string[]> Alternate properties for constructing the table.
		Try to construct a table with the columns of the properties of `tabularData` (or use `properties`) and rows of `tabularData` and log it. 
		Falls back to just logging the argument if it can’t be parsed as tabular.
	**/
	function table(tabularData:Dynamic,?properties:Array<String>):Void;



	/**
		Mark a time with `label`.
		Finish with `timeEnd`
	**/
	function time(label:String):Void;

	/**
		Finish timer marked with `label`, record output.
	**/
	function timeEnd(label:String):Void;

	/**
		* `label` <string> Default: `'default'`
		* `...data` <any>
		For a timer that was previously started by calling `console.time()`, prints the elapsed time and other `data` arguments to `stdout`:
	**/
	function timeLog(?label:String,data:haxe.extern.Rest<Dynamic>):Void;

	/**
		Print to stderr 'Trace :', followed by the formatted message and stack trace to the current position.
	**/
	@:overload(function(args:haxe.extern.Rest<Dynamic>):Void {})
	function trace(message:String, args:haxe.extern.Rest<Dynamic>):Void;
	/**
		Same as `error`.
	**/
	@:overload(function(args:haxe.extern.Rest<Dynamic>):Void {})
	function warn(data:String, args:haxe.extern.Rest<Dynamic>):Void;

}
