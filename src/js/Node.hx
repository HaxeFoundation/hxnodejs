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
import haxe.extern.Rest;
import js.node.console.Console;
import js.node.Module;
import js.node.Process;
import js.node.Timers.Immediate;
import js.node.Timers.Timeout;

/**
	Node.js globals
**/
@:native("global")
extern class Node {
	/**
		The directory name of the current module. This is the same as the `Path.dirname()` of the `__filename`.
	**/
	static var __dirname(get, never):String;

	private static inline function get___dirname():String
		return untyped __js__("__dirname");

	/**
		The file name of the current module. This is the current module file's absolute path with symlinks resolved.

		For a main program this is not necessarily the same as the file name used in the command line.

		See `__dirname` for the directory name of the current module
	**/
	static var __filename(get, never):String;

	private static inline function get___filename():String
		return untyped __js__("__filename");

	/**
		`clearImmediate` is described in the `Timers` section.
	 */
	static function clearImmediate(immediate:Immediate):Void;

	/**
		`clearInterval` is described in the `Timers` section.
	 */
	static function clearInterval(timeout:Timeout):Void;

	/**
		`clearTimeout` is described in the `Timers` section.
	 */
	static function clearTimeout(timeout:Timeout):Void;

	/**
		Used to print to stdout and stderr. See the `Console` section.
	**/
	static var console(get, never):Console;

	private static inline function get_console():Console
		return untyped __js__("console");

	/**
		This variable may appear to be global but is not. See [exports](https://nodejs.org/api/modules.html#modules_exports).
	**/
	static var exports(get, never):Dynamic<Dynamic>;

	private static inline function get_exports():Dynamic<Dynamic> {
		return untyped __js__("exports");
	}

	/**
		In browsers, the top-level scope is the global scope.
		This means that within the browser `var something` will define a new global variable.
		In Node.js this is different. The top-level scope is not the global scope; `var something` inside a Node.js module
		will be local to that module.
	**/
	static inline var global:Dynamic<Dynamic> = cast Node;

	/**
		This variable may appear to be global but is not. See [module](https://nodejs.org/api/modules.html#modules_module).
	**/
	static var module(get, never):Module;

	private static inline function get_module():Module {
		return untyped __js__("module");
	}

	/**
		The process object. See the [process object](https://nodejs.org/api/process.html#process_process) section.
	 */
	static var process(get, never):Process;

	private static inline function get_process():Process {
		return untyped __js__("process");
	}

	/**
		The `queueMicrotask()` method queues a microtask to invoke `callback`.
		If `callback` throws an exception, the process object 'uncaughtException' event will be emitted.

		The microtask queue is managed by V8 and may be used in a similar manner to the `Process.nextTick()` queue,
		which is managed by Node.js.
		The `Process.nextTick()` queue is always processed before the microtask queue within each turn of the Node.js event loop.
	 */
	static function queueMicrotask(callback:Void->Void):Void;

	/**
		This variable may appear to be global but is not. See `require()`.
	**/
	static inline function require(module:String):Dynamic {
		return untyped __js__("require({0})", module);
	}

	/**
		`setImmediate` is described in the `Timers` section.
	 */
	static function setImmediate(callback:Function, args:Rest<Dynamic>):Immediate;

	/**
		`setInterval` is described in the `Timers` section.
	 */
	static function setInterval(callback:Function, delay:Int, args:Rest<Dynamic>):Timeout;

	/**
		`setTimeout` is described in the `Timers` section.
	 */
	static function setTimeout(callback:Function, delay:Int, args:Rest<Dynamic>):Timeout;
}
