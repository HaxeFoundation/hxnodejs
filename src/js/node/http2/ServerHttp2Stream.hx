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

import haxe.extern.EitherType;
import js.lib.Error;
import js.node.Http2.Http2Headers;
import js.node.Http2.Http2PushStreamOptions;
import js.node.Http2.Http2ServerStreamFileResponseOptions;
import js.node.Http2.Http2ServerStreamResponseOptions;
import js.node.fs.FileHandle;

/**
	An `Http2Stream` for use on an HTTP/2 server.
	The class is not exported directly by the `node:http2` module.

	@see https://nodejs.org/api/http2.html#class-serverhttp2stream
**/
extern class ServerHttp2Stream extends Http2Stream {
	/**
		`true` if headers were sent, `false` otherwise.
	**/
	var headersSent(default, null):Bool;

	/**
		`true` if the remote peer accepts push streams.
	**/
	var pushAllowed(default, null):Bool;

	/**
		Sends an additional informational `HEADERS` frame.
	**/
	function additionalHeaders(headers:Http2Headers):Void;

	/**
		Initiates a push stream.
	**/
	@:overload(function(headers:Http2Headers, options:Http2PushStreamOptions,
		?callback:(err:Null<Error>, pushStream:ServerHttp2Stream, headers:Http2Headers) -> Void):Void {})
	function pushStream(headers:Http2Headers, ?callback:(err:Null<Error>, pushStream:ServerHttp2Stream, headers:Http2Headers) -> Void):Void;

	/**
		Sends an HTTP/2 response header to the connected client.
	**/
	@:overload(function(?headers:Array<String>, ?options:Http2ServerStreamResponseOptions):Void {})
	function respond(?headers:Http2Headers, ?options:Http2ServerStreamResponseOptions):Void;

	/**
		Sends a regular file as the response.
	**/
	@:overload(function(path:String, ?options:Http2ServerStreamFileResponseOptions):Void {})
	function respondWithFile(path:String, ?headers:Http2Headers, ?options:Http2ServerStreamFileResponseOptions):Void;

	/**
		Sends a regular file as the response using an open file descriptor or `FileHandle`.
	**/
	@:overload(function(fd:EitherType<Int, FileHandle>, ?options:Http2ServerStreamFileResponseOptions):Void {})
	function respondWithFD(fd:EitherType<Int, FileHandle>, ?headers:Http2Headers, ?options:Http2ServerStreamFileResponseOptions):Void;
}
