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

package js;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;
import js.Syntax.code;
import js.lib.Promise;
import js.node.Module;
import js.node.Process;
import js.node.Timers.Immediate;
import js.node.Timers.Timeout;
import js.node.console.Console;
import js.node.perf_hooks.Performance;
import js.node.url.URL;
import js.node.web.Navigator as WebNavigator;
import js.node.web.Request;
import js.node.web.Request.RequestInit;
import js.node.web.Response;
import js.node.web.Storage as WebStorage;

/**
	Node.js globals for the current process.

	@see https://nodejs.org/docs/latest-v24.x/api/globals.html
**/
@:native("global")
extern class Node {
	/**
		This variable may appear to be global but is not. See [__dirname](https://nodejs.org/api/modules.html#modules_dirname).
	**/
	static var __dirname(get, never):String;

	private static inline function get___dirname():String {
		return code("__dirname");
	}

	/**
		This variable may appear to be global but is not. See [__filename](https://nodejs.org/api/modules.html#modules_filename).
	**/
	static var __filename(get, never):String;

	private static inline function get___filename():String {
		return code("__filename");
	}

	/**
		`clearImmediate` is described in the [timers](https://nodejs.org/api/timers.html) section.
	**/
	static function clearImmediate(immediate:Immediate):Void;

	/**
		`clearInterval` is described in the [timers](https://nodejs.org/api/timers.html) section.

		Accepts a `Timeout` or its primitive coercion value.
	**/
	static function clearInterval(timeout:EitherType<Timeout, EitherType<Float, String>>):Void;

	/**
		`clearTimeout` is described in the [timers](https://nodejs.org/api/timers.html) section.

		Accepts a `Timeout` or its primitive coercion value.
	**/
	static function clearTimeout(timeout:EitherType<Timeout, EitherType<Float, String>>):Void;

	/**
		Used to print to stdout and stderr. See the [console](https://nodejs.org/api/console.html) section.
	**/
	static var console(get, never):Console;

	private static inline function get_console():Console {
		return code("console");
	}

	/**
		This variable may appear to be global but is not. See [exports](https://nodejs.org/api/modules.html#modules_exports).
	**/
	static var exports(get, never):Dynamic<Dynamic>;

	private static inline function get_exports():Dynamic<Dynamic> {
		return code("exports");
	}

	/**
		Browser-compatible `fetch()` (undici).

		@see https://nodejs.org/api/globals.html#fetch
	**/
	@:overload(function(input:Request, ?init:RequestInit):Promise<Response> {})
	@:overload(function(input:URL, ?init:RequestInit):Promise<Response> {})
	static function fetch(input:String, ?init:RequestInit):Promise<Response>;

	/**
		In browsers, the top-level scope is the global scope.
		This means that within the browser `var something` will define a new global variable.
		In Node.js this is different. The top-level scope is not the global scope; `var something` inside a Node.js module
		will be local to that module.

		Stability: 3 - Legacy. Use `globalThis` instead.
	**/
	@:deprecated("Use globalThis instead")
	static inline var global:Dynamic<Dynamic> = cast Node;

	/**
		`globalThis` is the universal way to access the global object.

		@see https://nodejs.org/api/globals.html#globalthis
	**/
	static var globalThis(get, never):Dynamic<Dynamic>;

	private static inline function get_globalThis():Dynamic<Dynamic> {
		return code("globalThis");
	}

	/**
		Web Storage API `localStorage`.

		Stability: 1.2 - Release candidate. Enable with `--experimental-webstorage`.
		Persists to the file given by `--localstorage-file`.

		@see https://nodejs.org/api/globals.html#localstorage
	**/
	static var localStorage(get, never):WebStorage;

	private static inline function get_localStorage():WebStorage {
		return code("localStorage");
	}

	/**
		This variable may appear to be global but is not. See [module](https://nodejs.org/api/modules.html#modules_module).
	**/
	static var module(get, never):Module;

	private static inline function get_module():Module {
		return code("module");
	}

	/**
		A partial browser-compatible `Navigator` implementation.

		@see https://nodejs.org/api/globals.html#navigator
	**/
	static var navigator(get, never):WebNavigator;

	private static inline function get_navigator():WebNavigator {
		return code("navigator");
	}

	/**
		An object that can be used to collect performance metrics from the current Node.js instance.
		It is similar to `window.performance` in browsers.

		@see https://nodejs.org/api/globals.html#performance
		@see https://nodejs.org/api/perf_hooks.html#perf_hooksperformance
	**/
	static var performance(get, never):Performance;

	private static inline function get_performance():Performance {
		return code("performance");
	}

	/**
		The process object. See the [process object](https://nodejs.org/api/process.html#process_process) section.
	**/
	static var process(get, never):Process;

	private static inline function get_process():Process {
		return code("process");
	}

	/**
		The `queueMicrotask()` method queues a microtask to invoke `callback`.
		If `callback` throws an exception, the [process object](https://nodejs.org/api/process.html#process_process) 'uncaughtException' event will be emitted.

		The microtask queue is managed by V8 and may be used in a similar manner to the `Process.nextTick()` queue,
		which is managed by Node.js.
		The `Process.nextTick()` queue is always processed before the microtask queue within each turn of the Node.js event loop.
	**/
	static function queueMicrotask(callback:() -> Void):Void;

	/**
		This variable may appear to be global but is not. See [require()](https://nodejs.org/api/modules.html#modules_require_id).
	**/
	static inline function require(module:String):Dynamic {
		return code("require({0})", module);
	}

	/**
		Web Storage API `sessionStorage`.

		Stability: 1.2 - Release candidate. Enable with `--experimental-webstorage`.

		@see https://nodejs.org/api/globals.html#sessionstorage
	**/
	static var sessionStorage(get, never):WebStorage;

	private static inline function get_sessionStorage():WebStorage {
		return code("sessionStorage");
	}

	/**
		`setImmediate` is described in the [timers](https://nodejs.org/api/timers.html) section.
	**/
	static function setImmediate(callback:Function, args:Rest<Dynamic>):Immediate;

	/**
		`setInterval` is described in the [timers](https://nodejs.org/api/timers.html) section.
	**/
	static function setInterval(callback:Function, delay:Int, args:Rest<Dynamic>):Timeout;

	/**
		`setTimeout` is described in the [timers](https://nodejs.org/api/timers.html) section.
	**/
	static function setTimeout(callback:Function, delay:Int, args:Rest<Dynamic>):Timeout;

	/**
		The WHATWG [`structuredClone`](https://developer.mozilla.org/en-US/docs/Web/API/structuredClone) method.

		@see https://nodejs.org/api/globals.html#structuredclonevalue-options
	**/
	static function structuredClone(value:Dynamic, ?options:StructuredCloneOptions):Dynamic;
}

/**
	Options for `Node.structuredClone`.
**/
typedef StructuredCloneOptions = {
	/**
		A list of transferable objects that will be moved rather than cloned.
	**/
	@:optional var transfer:Array<Dynamic>;
}

@:deprecated("Use Timeout instead") typedef TimeoutObject = js.node.Timers.Timeout;
@:deprecated("Use Timeout instead") typedef IntervalObject = js.node.Timers.Timeout;
@:deprecated("Use Immediate instead") typedef ImmediateObject = js.node.Timers.Immediate;
