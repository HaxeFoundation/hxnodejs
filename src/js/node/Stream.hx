/*
 * Copyright (C)2014-2019 Haxe Foundation
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
import js.node.events.EventEmitter;
#if haxe4
import js.lib.Promise;
#else
import js.Promise;
#end

/**
	Base class for all streams.
**/
@:jsRequire("stream") // the module itself is also a class
extern class Stream<TSelf:Stream<TSelf>> extends EventEmitter<TSelf> implements IStream {
	private function new();

	/**
		A module method to pipe between streams forwarding errors and properly cleaning up
		and provide a callback when the pipeline is complete.

		@see https://nodejs.org/api/stream.html#stream_stream_pipeline_streams_callback
	**/
	// TODO Support callback argument
	static function pipeline(streams:Rest<IStream>):Promise<Void>;
}

/**
	`IStream` interface is used as "any Stream".

	See `Stream` for actual class.
**/
@:remove
extern interface IStream extends IEventEmitter {}
