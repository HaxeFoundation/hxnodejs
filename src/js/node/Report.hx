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

import js.lib.Error;

/**
	Diagnostic report API available via `process.report`.

	@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreport
**/
extern class Report {
	/**
		If `true`, report JSON is produced in a compact format.

		@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreportcompact
	**/
	var compact:Bool;

	/**
		Directory where the report is written. Default is the empty string (current working directory).

		@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreportdirectory
	**/
	var directory:String;

	/**
		Filename where the report is written.
		If set to `'stdout'` or `'stderr'`, the report is written to that stream instead of a file.

		@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreportfilename
	**/
	var filename:String;

	/**
		Returns a JavaScript object representation of a diagnostic report.
		If `err` is provided, the report includes error information from that object.

		@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreportgetreporterr
	**/
	function getReport(?err:Error):Dynamic;

	/**
		If `true`, a diagnostic report is generated on fatal errors (such as out of memory) as defined by Node.

		@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreportreportonfatalerror
	**/
	var reportOnFatalError:Bool;

	/**
		If `true`, a diagnostic report is generated when the process receives the signal specified by `signal`.

		@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreportreportonsignal
	**/
	var reportOnSignal:Bool;

	/**
		If `true`, a diagnostic report is generated on uncaught exception.

		@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreportreportonuncaughtexception
	**/
	var reportOnUncaughtException:Bool;

	/**
		If `true`, environment variables are excluded from the report.
		Default: `false`.

		@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreportexcludeenv
	**/
	var excludeEnv:Bool;

	/**
		If `true`, excludes `header.networkInterfaces` from the diagnostic report.
		Default: `false`.

		@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreportexcludenetwork
	**/
	var excludeNetwork:Bool;

	/**
		The signal used to trigger report generation. Default: `'SIGUSR2'`.

		@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreportsignal
	**/
	var signal:String;

	/**
		Writes a diagnostic report to a file. If `filename` is not provided, Node.js generates a name.
		Returns the filename of the generated report.

		@see https://nodejs.org/docs/latest-v24.x/api/process.html#processreportwritereportfilename-err
	**/
	@:overload(function():String {})
	@:overload(function(err:Error):String {})
	@:overload(function(filename:String):String {})
	function writeReport(filename:String, err:Error):String;
}
