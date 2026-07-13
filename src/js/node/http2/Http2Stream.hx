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

import js.node.Http2.Http2Headers;
import js.node.Http2.Http2StreamState;
import js.node.events.EventEmitter.Event;
import js.node.stream.Duplex;

/**
	Enumeration of events emitted by `Http2Stream` in addition to duplex stream events.
**/
enum abstract Http2StreamEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when the `Http2Stream` instance is aborted abnormally.
	**/
	var Aborted:Http2StreamEvent<Void->Void> = "aborted";

	/**
		Emitted when an error occurs while attempting to send a frame.
	**/
	#if haxe4
	var FrameError:Http2StreamEvent<(type:Int, code:Int, id:Int) -> Void> = "frameError";
	#else
	var FrameError:Http2StreamEvent<Int->Int->Int->Void> = "frameError";
	#end

	/**
		Emitted when the `Http2Stream` has been opened and is ready for use.
	**/
	var Ready:Http2StreamEvent<Void->Void> = "ready";

	/**
		Emitted when the `Http2Stream` instance is closed.
	**/
	var StreamClosed:Http2StreamEvent<Int->Void> = "streamClosed";

	/**
		Emitted after the stream times out due to inactivity.
	**/
	var Timeout:Http2StreamEvent<Void->Void> = "timeout";

	/**
		Emitted when trailing headers are received.
	**/
	#if haxe4
	var Trailers:Http2StreamEvent<(trailers:Http2Headers, flags:Int) -> Void> = "trailers";
	#else
	var Trailers:Http2StreamEvent<Http2Headers->Int->Void> = "trailers";
	#end

	/**
		Emitted when the stream is ready for trailing headers to be sent.
	**/
	var WantTrailers:Http2StreamEvent<Void->Void> = "wantTrailers";
}

/**
	A duplex `Http2Stream` class representing a bidirectional HTTP/2 stream.
**/
@:jsRequire("http2", "Http2Stream")
extern class Http2Stream extends Duplex<Http2Stream> {
	/**
		`true` if the `Http2Stream` instance was aborted abnormally.
	**/
	var aborted(default, null):Bool;

	/**
		Number of characters currently buffered to be written.
	**/
	var bufferSize(default, null):Int;

	/**
		`true` if the `Http2Stream` instance has been closed.
	**/
	var closed(default, null):Bool;

	// `destroyed` is inherited from Readable/Duplex.

	/**
		`true` if the `END_STREAM` flag was set in the received headers.
	**/
	var endAfterHeaders(default, null):Bool;

	/**
		The numeric stream identifier, or `undefined` if not yet assigned.
	**/
	var id(default, null):Null<Int>;

	/**
		`true` if the stream has not yet been assigned a numeric stream identifier.
	**/
	var pending(default, null):Bool;

	/**
		The `RST_STREAM` error code reported when the stream was destroyed, if any.
	**/
	var rstCode(default, null):Null<Int>;

	/**
		Outbound headers sent for this stream.
	**/
	var sentHeaders(default, null):Http2Headers;

	/**
		Outbound informational headers sent for this stream.
	**/
	var sentInfoHeaders(default, null):Null<Array<Http2Headers>>;

	/**
		Outbound trailers sent for this stream.
	**/
	var sentTrailers(default, null):Null<Http2Headers>;

	/**
		The `Http2Session` that owns this stream.
	**/
	var session(default, null):Null<Http2Session>;

	/**
		Miscellaneous information about the current state of the stream.
	**/
	var state(default, null):Http2StreamState;

	/**
		Closes the stream by sending an `RST_STREAM` frame.
	**/
	function close(?code:Int, ?callback:Void->Void):Void;

	/**
		Priority signaling is no longer supported in Node.js.
	**/
	@:deprecated("Priority signaling is no longer supported in Node.js")
	function priority(options:Dynamic):Void;

	/**
		Sets the stream timeout value.
	**/
	function setTimeout(msecs:Int, ?callback:Void->Void):Void;

	/**
		Sends a trailing `HEADERS` frame. Must be called after `'wantTrailers'`.
	**/
	function sendTrailers(headers:Http2Headers):Void;
}
