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

package js.node.module;

/**
	Raw Source Map v3 payload used to construct a `SourceMap`.

	@see https://nodejs.org/api/module.html#class-modulesourcemap
**/
typedef SourceMapPayload = {
	var file:String;
	var version:Float;
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
	@:optional var lineLengths:Array<Float>;
}

/**
	Zero-indexed Source Map range in the original file.
**/
typedef SourceMapping = {
	var generatedLine:Float;
	var generatedColumn:Float;
	var originalSource:String;
	var originalLine:Float;
	var originalColumn:Float;
}

/**
	1-indexed call-site location in the original source.
**/
typedef SourceOrigin = {
	var name:Null<String>;
	var fileName:String;
	var lineNumber:Float;
	var columnNumber:Float;
}

/**
	Represents a [Source Map v3](https://tc39.es/ecma426/).

	@see https://nodejs.org/api/module.html#class-modulesourcemap
**/
@:jsRequire("module", "SourceMap")
extern class SourceMap {
	function new(payload:SourceMapPayload, ?options:SourceMapConstructorOptions);

	/**
		Payload used to construct this `SourceMap` instance.
	**/
	var payload(default, null):SourceMapPayload;

	/**
		Given zero-indexed offsets in the generated source, returns the corresponding
		Source Map range, or an empty object when not found.
	**/
	function findEntry(lineOffset:Float, columnOffset:Float):Dynamic;

	/**
		Given 1-indexed line/column from a call site in the generated source, returns
		the corresponding original location, or an empty object when not found.
	**/
	function findOrigin(lineNumber:Float, columnNumber:Float):Dynamic;
}
