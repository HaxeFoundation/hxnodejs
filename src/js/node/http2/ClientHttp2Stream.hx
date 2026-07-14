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

package js.node.http2;

import js.node.Http2.Http2Headers;
import js.node.events.EventEmitter.Event;

/**
	Enumeration of events emitted by `ClientHttp2Stream` in addition to `Http2Stream` events.
**/
enum abstract ClientHttp2StreamEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when the server sends a `100 Continue` response.
	**/
	var Continue:ClientHttp2StreamEvent<() -> Void> = "continue";

	/**
		Emitted when additional headers are received for an open stream.
	**/
	var Headers:ClientHttp2StreamEvent<(headers:Http2Headers, flags:Int, rawHeaders:Array<String>) -> Void> = "headers";

	/**
		Emitted when the server pushes a stream.
	**/
	var Push:ClientHttp2StreamEvent<(headers:Http2Headers, flags:Int, rawHeaders:Array<String>) -> Void> = "push";

	/**
		Emitted when a response `HEADERS` frame has been received.
	**/
	var Response:ClientHttp2StreamEvent<(headers:Http2Headers, flags:Int, rawHeaders:Array<String>) -> Void> = "response";
}

/**
	An `Http2Stream` for use on an HTTP/2 client.
	The class is not exported directly by the `node:http2` module.

	@see https://nodejs.org/api/http2.html#class-clienthttp2stream
**/
extern class ClientHttp2Stream extends Http2Stream {}
