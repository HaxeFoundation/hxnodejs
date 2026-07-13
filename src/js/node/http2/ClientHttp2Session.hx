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

package js.node.http2;

import js.node.Http2.Http2ClientSessionRequestOptions;
import js.node.Http2.Http2Headers;
import js.node.events.EventEmitter.Event;
import js.node.net.Socket;

/**
	Enumeration of events emitted by `ClientHttp2Session` in addition to `Http2Session` events.
**/
enum abstract ClientHttp2SessionEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when an `ALTSVC` frame is received.
	**/
	#if haxe4
	var Altsvc:ClientHttp2SessionEvent<(alt:String, origin:String, streamId:Int) -> Void> = "altsvc";
	#else
	var Altsvc:ClientHttp2SessionEvent<String->String->Int->Void> = "altsvc";
	#end

	/**
		Emitted once the client session has been successfully connected.
	**/
	#if haxe4
	var Connect:ClientHttp2SessionEvent<(session:ClientHttp2Session, socket:Socket) -> Void> = "connect";
	#else
	var Connect:ClientHttp2SessionEvent<ClientHttp2Session->Socket->Void> = "connect";
	#end

	/**
		Emitted when an `ORIGIN` frame is received.
	**/
	var Origin:ClientHttp2SessionEvent<Array<String>->Void> = "origin";

	/**
		Emitted when a new client stream is created.
	**/
	#if haxe4
	var Stream:ClientHttp2SessionEvent<(stream:ClientHttp2Stream, headers:Http2Headers, flags:Int, rawHeaders:Array<String>) -> Void> = "stream";
	#else
	var Stream:ClientHttp2SessionEvent<ClientHttp2Stream->Http2Headers->Int->Array<String>->Void> = "stream";
	#end
}

/**
	An `Http2Session` for use on an HTTP/2 client.
**/
@:jsRequire("http2", "ClientHttp2Session")
extern class ClientHttp2Session extends Http2Session {
	/**
		Creates and returns an `Http2Stream` instance that can be used to send an HTTP/2 request.
	**/
	@:overload(function(?headers:Array<String>, ?options:Http2ClientSessionRequestOptions):ClientHttp2Stream {})
	function request(?headers:Http2Headers, ?options:Http2ClientSessionRequestOptions):ClientHttp2Stream;
}
