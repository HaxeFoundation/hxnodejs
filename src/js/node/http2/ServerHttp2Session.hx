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
import haxe.extern.Rest;
import js.node.Http2.Http2Headers;
import js.node.events.EventEmitter.Event;
import js.node.net.Socket;
import js.node.url.URL;

/**
	Options object accepted by `ServerHttp2Session.altsvc` for an origin.
**/
typedef AlternativeServiceOptions = {
	var origin:EitherType<Int, EitherType<String, URL>>;
}

/**
	Enumeration of events emitted by `ServerHttp2Session` in addition to `Http2Session` events.
**/
enum abstract ServerHttp2SessionEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted once the server session has been successfully connected.
	**/
	var Connect:ServerHttp2SessionEvent<(session:ServerHttp2Session, socket:Socket) -> Void> = "connect";

	/**
		Emitted when a new server stream is created.
	**/
	var Stream:ServerHttp2SessionEvent<(stream:ServerHttp2Stream, headers:Http2Headers, flags:Int, rawHeaders:Array<String>) -> Void> = "stream";
}

/**
	An `Http2Session` for use on an HTTP/2 server.
	The class is not exported directly by the `node:http2` module.

	@see https://nodejs.org/api/http2.html#class-serverhttp2session
**/
extern class ServerHttp2Session extends Http2Session {
	/**
		The `Http2Server` or `Http2SecureServer` that owns this session.
	**/
	var server(default, null):EitherType<Http2Server, Http2SecureServer>;

	/**
		Submits an `ALTSVC` frame to the connected client.
	**/
	function altsvc(alt:String, originOrStream:EitherType<Int, EitherType<String, EitherType<URL, AlternativeServiceOptions>>>):Void;

	/**
		Submits an `ORIGIN` frame advertising the set of origins for which the server is authoritative.
	**/
	function origin(origins:Rest<EitherType<String, EitherType<URL, {var origin:String;}>>>):Void;
}
