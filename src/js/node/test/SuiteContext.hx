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

package js.node.test;

/**
	An instance of `SuiteContext` is passed to each suite function in order to
	interact with the test runner. The constructor is not exposed as part of the API.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-suitecontext
**/
extern class SuiteContext {
	/**
		Absolute path of the test file that created the current suite.
	**/
	var filePath(default, never):Null<String>;

	/**
		Name of the suite and each of its ancestors, separated by `>`.
	**/
	var fullName(default, never):String;

	/**
		Name of the suite.
	**/
	var name(default, never):String;

	/**
		AbortSignal that can be used to abort test subtasks when the suite is aborted.
	**/
	var signal(default, never):Dynamic;

	/**
		Whether the suite and all of its subtests have passed.
	**/
	var passed(default, never):Bool;

	/**
		Zero-based attempt number of the suite (useful with `--test-rerun-failures`).
	**/
	var attempt(default, never):Int;

	/**
		Output a diagnostic message about the current suite or its tests.
	**/
	function diagnostic(message:String):Void;
}
