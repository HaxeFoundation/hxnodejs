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
		Uses util.inspect on obj and prints resulting string to stdout.

		This function bypasses any custom inspect() function on obj.
		An optional options object may be passed that alters certain aspects
		of the formatted string.
	**/
	function dir(obj:Dynamic, ?options:Util.InspectOptionsBase):Void;

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
		Prints to stdout with newline. This function can take multiple arguments in a printf()-like way.
		Example: console.log('count: %d', count);
		If formatting elements are not found in the first string then `Util.inspect` is used on each argument.
		See `Util.format` for more information.
	**/
	@:overload(function(args:haxe.extern.Rest<Dynamic>):Void {})
	function log(data:String, args:haxe.extern.Rest<Dynamic>):Void;





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
