/*
 * Copyright (C)2014-2017 Haxe Foundation
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

/**
	Each instance of the `Http2Stream` class represents a bidirectional HTTP/2 communications stream over an `Http2Session` instance.
	Any single `Http2Session` may have up to 2^31-1 `Http2Stream` instances over its lifetime.

	User code will not construct `Http2Stream` instances directly. Rather, these are created, managed, and provided to user code through the `Http2Session` instance.
	On the server, `Http2Stream` instances are created either in response to an incoming HTTP request (and handed off to user code via the 'stream' event),
	or in response to a call to the `Http2stream.pushStream` method. On the client, `Http2Stream` instances are created and returned when either the `Http2session.request` method is called,
	or in response to an incoming 'push' event.

	*Note*: The `Http2Stream` class is a base for the `ServerHttp2Stream` and `ClientHttp2Stream` classes,
	each of which is used specifically by either the Server or Client side, respectively.

	All `Http2Stream` instances are Duplex streams. The `Writable` side of the `Duplex` is used to send data to the connected peer,
	while the `Readable` side is used to receive data sent by the connected peer.
**/
@:jsRequire("http2", "Http2Stream")
extern class Http2Stream extends js.node.stream.Duplex<Http2Stream> {
}
