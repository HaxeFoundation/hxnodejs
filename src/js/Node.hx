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
package js;

import haxe.Constraints.Function;

import js.node.*;
import js.node.console.Console;
#if haxe4
import js.lib.Int8Array;
import js.lib.Int16Array;
import js.lib.Int32Array;
import js.lib.Uint8Array;
import js.lib.Uint8ClampedArray;
import js.lib.Uint16Array;
import js.lib.Uint32Array;
import js.lib.Float32Array;
import js.lib.Float64Array;
#else
import js.html.Int8Array;
import js.html.Int16Array;
import js.html.Int32Array;
import js.html.Uint8Array;
import js.html.Uint8ClampedArray;
import js.html.Uint16Array;
import js.html.Uint32Array;
import js.html.Float32Array;
import js.html.Float64Array;
#end

/**
	Node.js globals
**/
@:native("global")
extern class Node {
	/**
		The global namespace object.
	**/
	static inline var global:Dynamic<Dynamic> = cast Node;

	/**
		The process object.
	 */
	static var process(get,never):Process;
	private static inline function get_process():Process return untyped __js__("process");

	/**
		The global console is a special `Console` whose output is sent to process.stdout and process.stderr.
	**/
	static var console(get,never):Console;
	private static inline function get_console():Console return untyped __js__("console");


	/**
		Fetches a library and returns the reference to it.
	**/
	static inline function require(module:String):Dynamic return js.node.Require.require(module);

	/**
		The name of the directory that the currently executing script resides in.
	**/
	static var __dirname(get,never):String;
	private static inline function get___dirname():String return untyped __js__("__dirname");

	/**
		The filename of the code being executed. This is the resolved absolute path of this code file.
		For a main program this is not necessarily the same filename used in the command line.
		The value inside a module is the path to that module file.
	**/
	static var __filename(get,never):String;
	private static inline function get___filename():String return untyped __js__("__filename");

	/**
		A reference to the current module.
		In particular `module.exports` is used for defining what a module exports and makes available through `require`.
		`module` isn't actually a global but rather local to each module.
	**/
	static var module(get,never):Module;
	private static inline function get_module():Module return untyped __js__("module");

	/**
		A reference to the module.exports that is shorter to type.
		See module system documentation for details on when to use exports and when to use `module.exports`.
		`exports` isn't actually a global but rather local to each module.
	**/
	static var exports(get,never):Dynamic<Dynamic>;
	private static inline function get_exports():Dynamic<Dynamic> return module.exports;


	/**
		To schedule execution of a one-time `callback` after `delay` milliseconds.
		Returns a `TimeoutObject` for possible use with `clearTimeout`.
		Optionally you can also pass arguments to the `callback`.
	**/
	static function setTimeout(callback:Function, delay:Int, args:haxe.extern.Rest<Dynamic>):TimeoutObject;

	/**
		Prevents a timeout from triggering.
	**/
	static function clearTimeout(timeoutObject:TimeoutObject):Void;

	/**
		To schedule the repeated execution of `callback` every `delay` milliseconds.
		Returns a `IntervalObject` for possible use with `clearInterval`.
		Optionally you can also pass arguments to the `callback`.
	**/
	static function setInterval(callback:Function, delay:Int, args:haxe.extern.Rest<Dynamic>):IntervalObject;

	/**
		Stops a interval from triggering.
	**/
	static function clearInterval(intervalObject:IntervalObject):Void;

	/**
		To schedule the "immediate" execution of `callback` after I/O events callbacks and before `setTimeout` and `setInterval`.
		Returns an `ImmediateObject` for possible use with `clearImmediate`.
		Optionally you can also pass arguments to the `callback`.

		Immediates are queued in the order created, and are popped off the queue once per loop iteration.
		This is different from `Process.nextTick` which will execute `Process.maxTickDepth` queued callbacks per iteration.
		`setImmediate` will yield to the event loop after firing a queued callback to make sure I/O is not being starved.
		While order is preserved for execution, other I/O events may fire between any two scheduled immediate callbacks.
	**/
	static function setImmediate(callback:Function, args:haxe.extern.Rest<Dynamic>):ImmediateObject;

	/**
		Stops an immediate from triggering.
	**/
	static function clearImmediate(immediateObject:ImmediateObject):Void;
}

/**
	Base class for the opaque value returned by `setTimeout` and `setInterval`.
	See `TimeoutObject` and `IntervalObject` concrete classes.
**/
extern class TimerObject {
	/**
		Makes the event loop won't keep the program running if a timer is active but is the only item left in the loop.
		If the timer is already `unref`d calling `unref` again will have no effect.

		In the case of `setTimeout` when you `unref` you create a separate timer that will wakeup the event loop,
		creating too many of these may adversely effect event loop performance -- use wisely.
	**/
	function unref():Void;

	/**
		If you had previously `unref`d a timer you can call `ref` to explicitly request the timer hold the program open.
		If the timer is already `ref`d calling `ref` again will have no effect.
	**/
	function ref():Void;
}

/**
	Object returned by `setTimeout`.
**/
extern class TimeoutObject extends TimerObject {}

/**
	Object returned by `setInterval`.
**/
extern class IntervalObject extends TimerObject {}

/**
	Object returned by `setImmediate`.
**/
extern class ImmediateObject {}

abstract TypedArray(Dynamic) 
	from Uint8Array to Uint8Array
	from Uint8ClampedArray to Uint8ClampedArray
	from Uint16Array to Uint16Array
	from Uint32Array to Uint32Array
	from Int8Array to Int8Array
	from Int16Array to Int16Array
	from Int32Array to Int32Array
	from Float32Array to Float32Array
	from Float64Array to Float64Array
{ }
