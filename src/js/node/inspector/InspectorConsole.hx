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

package js.node.inspector;

import haxe.extern.Rest;

/**
	Object used to send messages to the remote inspector console.

	Exposed by the V8 inspector console API; method signatures deliberately differ
	from (and are more permissive than) the Node.js `console` API.

	@see https://nodejs.org/docs/latest-v24.x/api/inspector.html#inspectorconsole
**/
extern class InspectorConsole {
	function debug(data:Rest<Dynamic>):Void;
	function error(data:Rest<Dynamic>):Void;
	function info(data:Rest<Dynamic>):Void;
	function log(data:Rest<Dynamic>):Void;
	function warn(data:Rest<Dynamic>):Void;
	function dir(data:Rest<Dynamic>):Void;
	function dirxml(data:Rest<Dynamic>):Void;
	function table(data:Rest<Dynamic>):Void;
	function trace(data:Rest<Dynamic>):Void;
	function group(data:Rest<Dynamic>):Void;
	function groupCollapsed(data:Rest<Dynamic>):Void;
	function groupEnd(data:Rest<Dynamic>):Void;
	function clear(data:Rest<Dynamic>):Void;
	function count(?label:Dynamic):Void;
	function countReset(?label:Dynamic):Void;
	function assert(?value:Dynamic, data:Rest<Dynamic>):Void;
	function profile(?label:Dynamic):Void;
	function profileEnd(?label:Dynamic):Void;
	function time(?label:Dynamic):Void;
	function timeEnd(?label:Dynamic):Void;
	function timeLog(?label:Dynamic):Void;
	function timeStamp(?label:Dynamic):Void;

	/**
		Creates a new inspector console context with the given name.
	**/
	function context(name:Dynamic):Void;
}
