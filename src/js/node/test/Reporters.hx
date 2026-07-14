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

/**
	Built-in reporters from `node:test/reporters`.

	Values are compatible with `stream.compose` / `TestsStream.compose`, e.g.
	`Test.run().compose(Reporters.tap)`.

	`dot` / `tap` / `junit` are also callable as
	`(source:AsyncIterable) -> AsyncIterator<String>`.
	`spec` / `lcov` are Transform constructor wrappers (callable / `new`).

	Exact reporter text output is not a stable programmatic API; prefer
	`TestsStream` events when aggregating results in code.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#test-reporters
**/
@:jsRequire("node:test/reporters")
extern class Reporters {
	/**
		Compact format: `.` for pass, `X` for fail.
	**/
	static var dot(default, never):Any;

	/**
		Human-readable default reporter.
	**/
	static var spec(default, never):Any;

	/**
		TAP format reporter.
	**/
	static var tap(default, never):Any;

	/**
		jUnit XML reporter.
	**/
	static var junit(default, never):Any;

	/**
		LCOV coverage reporter (used with coverage collection).
	**/
	static var lcov(default, never):Any;
}
