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

import haxe.extern.EitherType;
import js.lib.Promise;
import js.node.Readline.ReadlineCompleterResult;
import js.node.readline.PromisesInterface;
import js.node.stream.Readable.IReadable;
import js.node.stream.Writable.IWritable;
import js.node.web.AbortSignal;

/**
	Completer result: matching entries, then the substring used for matching.
**/
typedef ReadlinePromisesCompleterResult = ReadlineCompleterResult;

/**
	Tab autocompletion for `readline/promises`.
	Unlike the callback API, the completer may return a `Promise`.
**/
typedef ReadlinePromisesCompleterCallback = (line:String) -> EitherType<ReadlinePromisesCompleterResult,
	Promise<ReadlinePromisesCompleterResult>>;

/**
	Options for `ReadlinePromises.createInterface`.

	Same surface as `ReadlineOptions`, but `completer` may return a `Promise`.

	@see https://nodejs.org/docs/latest-v24.x/api/readline.html#readlinepromisescreateinterfaceoptions
**/
typedef ReadlinePromisesOptions = {
	/**
		The `Readable` stream to listen to.
	**/
	var input:IReadable;

	/**
		The `Writable` stream to write readline data to.
	**/
	@:optional var output:IWritable;

	/**
		An optional function used for Tab autocompletion.
		May return a `Promise` resolving to the completer result.
	**/
	@:optional var completer:ReadlinePromisesCompleterCallback;

	/**
		`true` if the `input` and `output` streams should be treated like a TTY, and have ANSI/VT100 escape codes
		written to it.
		Default: checking `isTTY` on the `output` stream upon instantiation.
	**/
	@:optional var terminal:Bool;

	/**
		Initial list of history lines.
		This option makes sense only if `terminal` is set to `true` by the user or by an internal `output` check.
		Default: `[]`.
	**/
	@:optional var history:Array<String>;

	/**
		Maximum number of history lines retained.
		To disable the history set this value to `0`.
		Default: `30`.
	**/
	@:optional var historySize:Int;

	/**
		The prompt string to use. Default: `'> '`.
	**/
	@:optional var prompt:String;

	/**
		If the delay between `\r` and `\n` exceeds `crlfDelay` milliseconds, both `\r` and `\n` will be treated as
		separate end-of-line input.
		Default: `100`.
	**/
	@:optional var crlfDelay:Float;

	/**
		If `true`, remove older duplicate history entries.
		Default: `false`.
	**/
	@:optional var removeHistoryDuplicates:Bool;

	/**
		Ambiguous key sequence timeout in milliseconds.
		Default: `500`.
	**/
	@:optional var escapeCodeTimeout:Int;

	/**
		The number of spaces a tab is equal to (minimum 1). Default: `8`.
	**/
	@:optional var tabSize:Int;

	/**
		Allows closing the interface using an `AbortSignal`.
		Aborting the signal will internally call `close` on the interface.
	**/
	@:optional var signal:AbortSignal;
}

/**
	The `readline/promises` API provides an alternative set of interfaces that return promises.

	Accessible via `require('readline/promises')` or `require('readline').promises`.
	Stability: 2 - Stable (since Node.js v24.0.0).

	@see https://nodejs.org/docs/latest-v24.x/api/readline.html#promises-api
**/
@:jsRequire("readline/promises")
extern class ReadlinePromises {
	/**
		Creates a new `readlinePromises.Interface` instance.
	**/
	@:overload(function(input:IReadable, ?output:IWritable, ?completer:ReadlinePromisesCompleterCallback,
		?terminal:Bool):PromisesInterface {})
	static function createInterface(options:ReadlinePromisesOptions):PromisesInterface;
}
