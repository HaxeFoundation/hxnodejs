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

import js.lib.ArrayBufferView;
import js.lib.Error;
import js.node.Buffer;
import js.node.Http2.Http2Headers;
import js.node.Http2.Http2SessionState;
import js.node.Http2.Http2Settings;
import js.node.events.EventEmitter;
import js.node.events.EventEmitter.Event;
import js.node.net.Socket;

/**
	Enumeration of events emitted by `Http2Session` in addition to its parent class events.
**/
enum abstract Http2SessionEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted once the `Http2Session` has been destroyed.
	**/
	var Close:Http2SessionEvent<() -> Void> = "close";

	/**
		Emitted once the `Http2Session` has been successfully connected to the remote peer.
	**/
	var Connect:Http2SessionEvent<(session:Http2Session, socket:Socket) -> Void> = "connect";

	/**
		Emitted when an error occurs during processing of an `Http2Session`.
	**/
	var Error:Http2SessionEvent<(error:Error) -> Void> = "error";

	/**
		Emitted when an error occurs while attempting to send a frame on the session.
	**/
	var FrameError:Http2SessionEvent<(type:Int, code:Int, id:Int) -> Void> = "frameError";

	/**
		Emitted when a `GOAWAY` frame is received.
	**/
	var Goaway:Http2SessionEvent<(errorCode:Int, lastStreamID:Int, opaqueData:Null<Buffer>) -> Void> = "goaway";

	/**
		Emitted when an acknowledgment `SETTINGS` frame has been received.
	**/
	var LocalSettings:Http2SessionEvent<(settings:Http2Settings) -> Void> = "localSettings";

	/**
		Emitted whenever a `PING` frame is received from the connected peer.
	**/
	var Ping:Http2SessionEvent<(payload:Buffer) -> Void> = "ping";

	/**
		Emitted when a new `SETTINGS` frame is received from the connected peer.
	**/
	var RemoteSettings:Http2SessionEvent<(settings:Http2Settings) -> Void> = "remoteSettings";

	/**
		Emitted when a new `Http2Stream` is created.
	**/
	var Stream:Http2SessionEvent<(stream:Http2Stream, headers:Http2Headers, flags:Int, rawHeaders:Array<String>) -> Void> = "stream";

	/**
		Emitted after the `Http2Session` times out due to inactivity.
	**/
	var Timeout:Http2SessionEvent<() -> Void> = "timeout";
}

/**
	The `Http2Session` class represents an active communications session between an HTTP/2 client and server.

	Instances of this class are not intended to be constructed directly by user code.
	The class is not exported directly by the `node:http2` module.

	@see https://nodejs.org/api/http2.html#class-http2session
**/
extern class Http2Session extends EventEmitter<Http2Session> {
	/**
		Value will be `undefined` if the session is not yet connected to a socket,
		`'h2c'` if not connected to a `TLSSocket`, or the connected socket's `alpnProtocol`.
	**/
	var alpnProtocol(default, null):Null<String>;

	/**
		`true` if this `Http2Session` instance has been closed.
	**/
	var closed(default, null):Bool;

	/**
		`true` if this `Http2Session` instance is still connecting.
	**/
	var connecting(default, null):Bool;

	/**
		`true` if this `Http2Session` instance has been destroyed.
	**/
	var destroyed(default, null):Bool;

	/**
		`true` if connected with a `TLSSocket`, `false` for other sockets, `undefined` if not yet connected.
	**/
	var encrypted(default, null):Null<Bool>;

	/**
		A prototype-less object describing the current local settings of this session.
	**/
	var localSettings(default, null):Http2Settings;

	/**
		Array of origins for which the session may be considered authoritative (TLS only).
	**/
	var originSet(default, null):Null<Array<String>>;

	/**
		`true` while waiting for acknowledgment of a sent `SETTINGS` frame.
	**/
	var pendingSettingsAck(default, null):Bool;

	/**
		A prototype-less object describing the current remote settings of this session.
	**/
	var remoteSettings(default, null):Http2Settings;

	/**
		A `Proxy` object that acts as a `net.Socket` / `tls.TLSSocket` but limits available methods.
	**/
	var socket(default, null):Socket;

	/**
		Miscellaneous information about the current state of the session.
	**/
	var state(default, null):Http2SessionState;

	/**
		Equal to `NGHTTP2_SESSION_SERVER` or `NGHTTP2_SESSION_CLIENT`.
	**/
	var type(default, null):Int;

	/**
		Gracefully closes the `Http2Session`, allowing existing streams to complete.
	**/
	function close(?callback:() -> Void):Void;

	/**
		Immediately terminates the `Http2Session` and the associated socket.
	**/
	function destroy(?error:Error, ?code:Int):Void;

	/**
		Transmits a `GOAWAY` frame without shutting down the session.
	**/
	function goaway(?code:Int, ?lastStreamID:Int, ?opaqueData:ArrayBufferView):Void;

	/**
		Sends a `PING` frame to the connected HTTP/2 peer.
		Optional `payload` must be 8 bytes (`Buffer`, `TypedArray`, or `DataView`).
	**/
	@:overload(function(payload:ArrayBufferView, callback:(err:Null<Error>, duration:Float, payload:Buffer) -> Void):Bool {})
	function ping(callback:(err:Null<Error>, duration:Float, payload:Buffer) -> Void):Bool;

	/**
		Calls `ref()` on this session's underlying socket.
	**/
	function ref():Void;

	/**
		Sets the local endpoint's window size (total, not delta).
	**/
	function setLocalWindowSize(windowSize:Int):Void;

	/**
		Sets a callback invoked when there is no activity on the session after `msecs` milliseconds.
	**/
	function setTimeout(msecs:Int, ?callback:() -> Void):Void;

	/**
		Updates the current local settings and sends a new `SETTINGS` frame.
	**/
	function settings(settings:Http2Settings, ?callback:(err:Null<Error>, settings:Http2Settings, duration:Float) -> Void):Void;

	/**
		Calls `unref()` on this session's underlying socket.
	**/
	function unref():Void;
}
