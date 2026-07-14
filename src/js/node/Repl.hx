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

package js.node;

import haxe.DynamicAccess;
import js.lib.Error;
import js.lib.Symbol;
import js.node.Util.InspectOptions;
import js.node.repl.REPLServer;
import js.node.stream.Readable.IReadable;
import js.node.stream.Writable.IWritable;

/**
	The `node:repl` module provides a Read-Eval-Print-Loop (REPL) implementation that is available both as a standalone
	program or includible in other applications.

	Related types: `js.node.repl.REPLServer`, `js.node.repl.Recoverable`.

	@see https://nodejs.org/docs/latest-v24.x/api/repl.html
**/
@:jsRequire("repl")
extern class Repl {
	/**
		The `repl.start()` method creates and starts a `repl.REPLServer` instance.

		If `options` is a string, then it specifies the input prompt.

		@see https://nodejs.org/docs/latest-v24.x/api/repl.html#replstartoptions
	**/
	@:overload(function(prompt:String):REPLServer {})
	static function start(?options:ReplOptions):REPLServer;

	/**
		Default function used to format each command's output before writing to `output`.
		A wrapper for `util.inspect()`; may be overridden by a custom `writer` option.
		Inspect defaults are available via `writer.options`.

		@see https://nodejs.org/docs/latest-v24.x/api/repl.html#customizing-repl-output
	**/
	static final writer:ReplWriter;

	/**
		A list of the names of some Node.js modules, e.g. `'http'`.

		Deprecated since: v24.0.0. Use `js.node.Module.builtinModules` instead.

		@see https://nodejs.org/docs/latest-v24.x/api/repl.html#replbuiltinmodules
	**/
	@:deprecated("Use js.node.Module.builtinModules instead")
	static var builtinModules(default, null):Array<String>;

	/**
		Evaluates expressions in sloppy mode.
	**/
	static final REPL_MODE_SLOPPY:Symbol;

	/**
		Evaluates expressions in strict mode.
		This is equivalent to prefacing every repl statement with `'use strict'`.
	**/
	static final REPL_MODE_STRICT:Symbol;
}

/**
	Options object used by `Repl.start` / `new REPLServer`.

	@see https://nodejs.org/docs/latest-v24.x/api/repl.html#replstartoptions
**/
typedef ReplOptions = {
	/**
		The input prompt to display. Default: `'> '` (with a trailing space).
	**/
	@:optional var prompt:String;

	/**
		The `Readable` stream from which REPL input will be read. Default: `process.stdin`.
	**/
	@:optional var input:IReadable;

	/**
		The `Writable` stream to which REPL output will be written. Default: `process.stdout`.
	**/
	@:optional var output:IWritable;

	/**
		If `true`, specifies that the `output` should be treated as a TTY terminal.
		Default: checking the value of the `isTTY` property on the `output` stream upon instantiation.
	**/
	@:optional var terminal:Bool;

	/**
		The function to be used when evaluating each given line of input.
		Default: an async wrapper for the JavaScript `eval()` function.

		An `eval` function can error with `repl.Recoverable` to indicate the input was incomplete
		and prompt for additional lines.

		// TODO(section-5): replace DynamicAccess<Dynamic>/Dynamic result with a typed REPL context model
	**/
	@:optional var eval:(code:String, context:DynamicAccess<Dynamic>, file:String, cb:(error:Null<Error>, ?result:Dynamic) -> Void) -> Void;

	/**
		If `true`, specifies that the default `writer` function should include ANSI color styling to REPL output.
		If a custom `writer` is provided then this has no effect.
		Default: checking color support on the `output` stream if the REPL instance's `terminal` value is `true`.
	**/
	@:optional var useColors:Bool;

	/**
		If `true`, specifies that the default evaluation function will use the JavaScript `global` as the context
		as opposed to creating a new separate context for the REPL instance.
		The node CLI REPL sets this value to `true`. Default: `false`.
	**/
	@:optional var useGlobal:Bool;

	/**
		If `true`, specifies that the default writer will not output the return value of a command if it evaluates to
		`undefined`. Default: `false`.
	**/
	@:optional var ignoreUndefined:Bool;

	/**
		The function to invoke to format the output of each command before writing to `output`.
		Default: `util.inspect()` / `repl.writer`.
	**/
	@:optional var writer:(obj:Dynamic) -> String;

	/**
		An optional function used for custom Tab auto completion.
	**/
	@:optional var completer:Readline.ReadlineCompleterCallback;

	/**
		A flag that specifies whether the default evaluator executes all JavaScript commands in strict mode or default
		(sloppy) mode.
		Acceptable values are `repl.REPL_MODE_SLOPPY` or `repl.REPL_MODE_STRICT`.
	**/
	@:optional var replMode:Symbol;

	/**
		Stop evaluating the current piece of code when `SIGINT` is received, i.e. `Ctrl+C` is pressed.
		This cannot be used together with a custom `eval` function. Default: `false`.
	**/
	@:optional var breakEvalOnSigint:Bool;

	/**
		Defines if the REPL prints autocomplete and output previews.
		Default: `true` with the default eval function and `false` when a custom eval function is used.
		If `terminal` is falsy, there are no previews and this value has no effect.
	**/
	@:optional var preview:Bool;
}

/**
	Default REPL writer: callable formatter with `util.inspect`-compatible `options`.
**/
@:callable
abstract ReplWriter((obj:Dynamic) -> String) from((obj:Dynamic) -> String) to((obj:Dynamic) -> String) {
	/**
		Inspection options used by the default writer.
	**/
	public var options(get, set):InspectOptions;

	inline function get_options():InspectOptions
		return Reflect.field(this, "options");

	inline function set_options(value:InspectOptions):InspectOptions {
		Reflect.setField(this, "options", value);
		return value;
	}
}
