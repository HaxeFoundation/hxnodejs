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

package js.node.module;

import haxe.extern.EitherType;

/**
	Raw Source Map v3 payload used to construct a `SourceMap`.

	@see https://nodejs.org/api/module.html#class-modulesourcemap
**/
typedef SourceMapPayload = {
	var file:String;
	var version:Int;
	var sources:Array<String>;
	var sourcesContent:Array<String>;
	var names:Array<String>;
	var mappings:String;
	var sourceRoot:String;
}

/**
	Options for constructing a `SourceMap`.
**/
typedef SourceMapConstructorOptions = {
	/**
		Optional line lengths used when the payload omits them.
	**/
	@:optional var lineLengths:Array<Int>;
}

/**
	Zero-indexed Source Map range in the original file, as returned by
	`SourceMap.findEntry` when a mapping is found.
**/
typedef SourceMapping = {
	var generatedLine:Int;
	var generatedColumn:Int;
	var originalSource:String;
	var originalLine:Int;
	var originalColumn:Int;

	/**
		Name of the range in the source map, when provided.
	**/
	@:optional var name:String;
}

/**
	1-indexed call-site location in the original source, as returned by
	`SourceMap.findOrigin` when a mapping is found.
**/
typedef SourceOrigin = {
	var name:Null<String>;
	var fileName:String;
	var lineNumber:Int;
	var columnNumber:Int;
}

/**
	Represents a [Source Map v3](https://tc39.es/ecma426/).

	@see https://nodejs.org/api/module.html#class-modulesourcemap
**/
@:jsRequire("module", "SourceMap")
extern class SourceMap {
	/**
		Creates a new `SourceMap` instance from a Source Map v3 payload.

		@see https://nodejs.org/api/module.html#new-sourcemappayload-linelengths
	**/
	function new(payload:SourceMapPayload, ?options:SourceMapConstructorOptions);

	/**
		Payload used to construct this `SourceMap` instance.

		@see https://nodejs.org/api/module.html#sourcemappayload
	**/
	var payload(default, null):SourceMapPayload;

	/**
		Given zero-indexed offsets in the generated source, returns the corresponding
		Source Map range, or an empty object when not found.

		@see https://nodejs.org/api/module.html#sourcemapfindentrylineoffset-columnoffset
	**/
	function findEntry(lineOffset:Int, columnOffset:Int):EitherType<SourceMapping, {}>;

	/**
		Given 1-indexed line/column from a call site in the generated source, returns
		the corresponding original location, or an empty object when not found.

		@see https://nodejs.org/api/module.html#sourcemapfindorigallinenumber-columnnumber
	**/
	function findOrigin(lineNumber:Int, columnNumber:Int):EitherType<SourceOrigin, {}>;
}
