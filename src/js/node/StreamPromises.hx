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

import haxe.extern.Rest;
import js.node.Stream;
import js.node.stream.Readable.IReadable;
import js.node.stream.Writable.IWritable;
#if haxe4
import js.lib.Error;
import js.lib.Promise;
#else
import js.Error;
import js.Promise;
#end

/**
	The `stream/promises` API provides an alternative set of asynchronous stream
	utilities that return `Promise` objects rather than using callbacks.

	Accessible via `require('stream/promises')` or `require('stream').promises`.

	@see https://nodejs.org/api/stream.html#streams-promises-api
**/
@:jsRequire("stream/promises")
extern class StreamPromises {
	/**
		A module method to pipe between streams forwarding errors and properly cleaning up,
		returning a Promise when the pipeline is complete.
	**/
	@:overload(function(readable:IReadable, ?options:StreamFinishedOptions):Promise<Void> {})
	@:overload(function(readable:IReadable, writable1:IWritable, ?options:StreamFinishedOptions):Promise<Void> {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, ?options:StreamFinishedOptions):Promise<Void> {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, ?options:StreamFinishedOptions):Promise<Void> {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, writable4:IWritable,
		?options:StreamFinishedOptions):Promise<Void> {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, writable4:IWritable, writable5:IWritable,
		?options:StreamFinishedOptions):Promise<Void> {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, writable4:IWritable, writable5:IWritable,
		writable6:IWritable, ?options:StreamFinishedOptions):Promise<Void> {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, writable4:IWritable, writable5:IWritable,
		writable6:IWritable, writable7:IWritable, ?options:StreamFinishedOptions):Promise<Void> {})
	@:overload(function(readable:IReadable, writable1:IWritable, writable2:IWritable, writable3:IWritable, writable4:IWritable, writable5:IWritable,
		writable6:IWritable, writable7:IWritable, writable8:IWritable, ?options:StreamFinishedOptions):Promise<Void> {})
	static function pipeline(readable:IReadable, streams:Rest<EitherType<IWritable, StreamFinishedOptions>>):Promise<Void>;

	/**
		Returns a Promise that fulfills when the stream is no longer readable,
		writable or has experienced an error or a premature close event.
	**/
	@:overload(function(stream:IStream):Promise<Void> {})
	static function finished(stream:IStream, options:StreamFinishedOptions):Promise<Void>;
}

// local alias so Rest overload typing can use EitherType without extra import noise
private typedef EitherType<T1, T2> = haxe.extern.EitherType<T1, T2>;
