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

package js.node.test;

import js.node.web.AbortSignal;

/**
	Passed to each suite function to interact with the test runner.

	The `SuiteContext` constructor is not part of the public API.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-suitecontext
**/
extern class SuiteContext {
	/**
		Absolute path of the test file that created the current suite.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextfilepath-1
	**/
	var filePath(default, null):Null<String>;

	/**
		Name of the suite and each of its ancestors, separated by `>`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextfullname-1
	**/
	var fullName(default, null):String;

	/**
		Name of the suite.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextname-1
	**/
	var name(default, null):String;

	/**
		Abort signal for cancelling suite subtasks when the suite is aborted.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextsignal-1
	**/
	var signal(default, null):AbortSignal;

	/**
		Whether the suite and all of its subtests have passed.

		Added in: v24.16.0

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextpassed-1
	**/
	var passed(default, null):Bool;

	/**
		Zero-based attempt number when using `--test-rerun-failures`.

		Added in: v24.16.0

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextattempt-1
	**/
	var attempt(default, null):Int;

	/**
		Output a diagnostic message for the suite.

		Added in: v24.16.0

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#contextdiagnosticmessage-1
	**/
	function diagnostic(message:String):Void;
}
