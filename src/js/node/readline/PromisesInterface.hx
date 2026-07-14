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

package js.node.readline;

import js.lib.Promise;
import js.node.readline.Interface;

/**
	Instances of `readlinePromises.Interface` are constructed using
	`ReadlinePromises.createInterface()`.

	Differs from `readline.Interface` mainly in that `question` returns a `Promise`.

	@see https://nodejs.org/docs/latest-v24.x/api/readline.html#class-readlinepromisesinterface
**/
@:jsRequire("readline/promises", "Interface")
extern class PromisesInterface extends Interface {
	/**
		Displays `query` by writing it to `output`, waits for user input on `input`,
		then fulfills with the provided input.

		When called, resumes the `input` stream if it has been paused.
		If called after `close()`, returns a rejected promise.
	**/
	@:overload(function(query:String):Promise<String> {})
	function question(query:String, options:InterfaceQuestionOptions):Promise<String>;
}
