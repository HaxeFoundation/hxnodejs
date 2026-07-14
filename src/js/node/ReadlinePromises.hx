/*
 * Copyright (C)2014-2020 Haxe Foundation
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
import js.node.readline.PromisesInterface;
import js.node.stream.Readable.IReadable;
import js.node.stream.Writable.IWritable;
import js.node.web.AbortSignal;

/**
	Completer result: matching entries, then the substring used for matching.
**/
typedef ReadlinePromisesCompleterResult = Array<EitherType<Array<String>, String>>;

/**
	Tab autocompletion for `readline/promises`.
	Unlike the callback API, the completer may return a `Promise`.
**/
typedef ReadlinePromisesCompleterCallback = (line:String) -> EitherType<ReadlinePromisesCompleterResult, Promise<ReadlinePromisesCompleterResult>>;

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
		`true` if the `input` and `output` streams should be treated like a TTY.
	**/
	@:optional var terminal:Bool;

	/**
		Initial list of history lines.
	**/
	@:optional var history:Array<String>;

	/**
		Maximum number of history lines retained.
	**/
	@:optional var historySize:Int;

	/**
		The prompt string to use.
	**/
	@:optional var prompt:String;

	/**
		Delay threshold for treating `\r\n` as a single newline.
	**/
	@:optional var crlfDelay:Float;

	/**
		If `true`, remove older duplicate history entries.
	**/
	@:optional var removeHistoryDuplicates:Bool;

	/**
		Ambiguous key sequence timeout in milliseconds.
	**/
	@:optional var escapeCodeTimeout:Int;

	/**
		The number of spaces a tab is equal to (minimum 1).
	**/
	@:optional var tabSize:Int;

	/**
		Allows closing the interface using an `AbortSignal`.
	**/
	@:optional var signal:AbortSignal;
}

/**
	The `readline/promises` API provides an alternative set of interfaces that return promises.

	@see https://nodejs.org/docs/latest-v24.x/api/readline.html#promises-api
**/
@:jsRequire("readline/promises")
extern class ReadlinePromises {
	/**
		Creates a new `readlinePromises.Interface` instance.
	**/
	@:overload(function(input:IReadable, ?output:IWritable, ?completer:ReadlinePromisesCompleterCallback, ?terminal:Bool):PromisesInterface {})
	static function createInterface(options:ReadlinePromisesOptions):PromisesInterface;
}
