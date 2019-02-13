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

import haxe.extern.EitherType;
import js.html.ArrayBufferView;

import js.node.events.EventEmitter;
import js.node.net.Socket;
import js.node.tls.TLSSocket;
import js.node.Http2;

/**
	Enumeration of events emitted by `Http2Session` objects.
**/
@:enum abstract Http2SessionEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		The 'close' event is emitted once the `Http2Session` has been destroyed.
	**/
	var Close : Http2SessionEvent<Void->Void> = "close";

	/**
		The 'connect' event is emitted once the Http2Session has been successfully connected
		to the remote peer and communication may begin.

		*Note*: User code will typically not listen for this event directly.
	**/
	var Connect : Http2SessionEvent<Http2Session->Socket->Void> = "connect";

	/**
		The 'error' event is emitted when an error occurs during the processing of an `Http2Session`.
	**/
	var Error : Http2SessionEvent<js.Error->Void> = "error";

	/**
		The 'frameError' event is emitted when an error occurs while attempting to send a frame on the session.
		If the frame that could not be sent is associated with a specific `Http2Stream`,
		an attempt to emit 'frameError' event on the `Http2Stream` is made.
	**/
	var FrameError : Http2SessionEvent<
		#if haxe4 (type:Int, code:Int, id:Int)->Void #else Int->Int->Int->Void #end
	> = "frameError";

	/**
		The 'goaway' event is emitted when a GOAWAY frame is received.

		The `Http2Session` instance will be shut down automatically when the 'goaway' event is emitted.
	**/
	var Goaway : Http2SessionEvent<
		#if haxe4
		(errorCode:Int, lastStreamID:Int, opaqueData:Buffer)->Void
		#else
		Int->Int->Buffer->Void
		#end
	> = "goaway";

	/**
		The 'localSettings' event is emitted when an acknowledgment SETTINGS frame has been received.

		*Note*: When using `Http2Session.settings` to submit new settings, the modified settings do not take effect until the 'localSettings' event is emitted.
	**/
	var LocalSettings : Http2SessionEvent<Http2Settings->Void> = "localSettings";

	/**
		The 'ping' event is emitted whenever a PING frame is received from the connected peer.
	**/
	var Ping : Http2SessionEvent<#if haxe4 (payload:Buffer)->Void #else Buffer->Void #end> = "ping";

	/**
		The 'remoteSettings' event is emitted when a new SETTINGS frame is received from the connected peer.
	**/
	var RemoteSettings : Http2SessionEvent<Http2Settings->Void> = "remoteSettings";

	/**
		The 'stream' event is emitted when a new `Http2Stream` is created.

		On the server side, user code will typically not listen for this event directly,
		and would instead register a handler for the 'stream' event emitted by the net.Server or tls.Server instances
		returned by `Http2.createServer` and `Http2.createSecureServer`, respectively.
	**/
	var Stream : Http2SessionEvent<
		#if haxe4
		(stream:Http2Stream, headers:Http2Headers, flags:Int, rawHeaders:Array<String>)->Void
		#else
		Http2Stream->Http2Headers->Int->Array<String>->Void
		#end
	> = "stream";

	/**
		After the `Http2session.setTimeout` method is used to set the timeout period for this `Http2Session`,
		the 'timeout' event is emitted if there is no activity on the `Http2Session` after the configured number of milliseconds.
	**/
	var Timeout : Http2SessionEvent<Void->Void> = "timeout";
}

@:jsRequire("http2", "Http2Session")
extern class Http2Session extends EventEmitter<Http2Session> {
	/**
		Value will be `null` if the `Http2Session` is not yet connected to a socket,
		`h2c` if the `Http2Session` is not connected to a `TLSSocket`,
		or will return the value of the connected `TLSSocket`'s own `alpnProtocol` property.
	**/
	var alpnProtocol:Null<String>;

	/**
		Gracefully closes the `Http2Session`, allowing any existing streams to complete on their own
		and preventing new `Http2Stream` instances from being created.
		Once closed, `Http2Session.destroy` might be called if there are no open `Http2Stream` instances.

		If specified, the `callback` function is registered as a handler for the 'close' event.
	**/
	function close(?callback:Void->Void):Void;

	/**
		Will be `true` if this `Http2Session` instance has been closed, otherwise `false`.
	**/
	var closed:Bool;

	/**
		Will be `true` if this `Http2Session` instance is still connecting,
		will be set to `false` before emitting `connect` event and/or calling the `Http2.connect` callback.
	**/
	var connecting:Bool;

	/**
		Immediately terminates the `Http2Session` and the associated net.Socket or tls.TLSSocket.

		Once destroyed, the `Http2Session` will emit the 'close' event. If error is not undefined, an 'error' event will be emitted immediately after the 'close' event.

		If there are any remaining open `Http2Stream`s associated with the `Http2Session`, those will also be destroyed.

		@param error An Error object if the Http2Session is being destroyed due to an error.
		@param code The HTTP/2 error code to send in the final `GOAWAY` frame. If unspecified, and error is not undefined, the default is INTERNAL_ERROR, otherwise defaults to NO_ERROR.
	**/
	@:overload(function(?code:Int):Void {})
	function destroy(error:js.Error, ?code:Int):Void;

	/**
		Will be `true` if this `Http2Session` instance has been destroyed and must no longer be used, otherwise `false`.
	**/
	var destroyed:Bool;

	/**
		Value is `null` if the `Http2Session` session socket has not yet been connected,
		`true` if the `Http2Session` is connected with a `TLSSocket`,
		and `false` if the `Http2Session` is connected to any other kind of socket or stream.
	**/
	var encrypted:Null<Bool>;

	/**
		Transmits a `GOAWAY` frame to the connected peer without shutting down the `Http2Session`.

		@param code An HTTP/2 error code
		@param lastStreamID The numeric ID of the last processed Http2Stream
		@param opaqueData A TypedArray or DataView instance containing additional data to be carried within the GOAWAY frame.
	**/
	@:overload(function(code:Int, lastStreamID:Int, ?opaqueData:EitherType<Buffer,ArrayBufferView>):Void {})
	function goaway(?code:Int):Void;

	/**
		An object describing the current local settings of this `Http2Session`.
		The local settings are local to this `Http2Session` instance.
	**/
	var localSettings:Http2Settings;

	/**
		If the `Http2Session` is connected to a `TLSSocket`, the `originSet` property will return an Array of origins
		for which the `Http2Session` may be considered authoritative.

		The `originSet` property is only available when using a secure TLS connection.
	**/
	var originSet:Null<Array<String>>;

	/**
		Indicates whether or not the `Http2Session` is currently waiting for an acknowledgment for a sent `SETTINGS` frame.
		Will be `true` after calling the `Http2session.settings` method. Will be `false` once all sent `SETTINGS` frames have been acknowledged.
	**/
	var pendingSettingsAck:Bool;
	
	/**
		Sends a `PING` frame to the connected HTTP/2 peer.

		The method will return `true` if the `PING` was sent, `false` otherwise.

		The maximum number of outstanding (unacknowledged) pings is determined by the `maxOutstandingPings` configuration option. The default maximum is 10.

		If provided, the `payload` must be a Buffer, TypedArray, or DataView containing 8 bytes of data that will be transmitted with the PING and returned with the ping acknowledgment.
	**/
	@:overload(function(payload:EitherType<Buffer, ArrayBufferView>, callback:Http2SessionPingCallback):Void {})
	function ping(callback:Http2SessionPingCallback):Bool;

	/**
		Calls `ref()` on this `Http2Session` instance's underlying `net.Socket`.
	**/
	function ref():Void;

	/**
		An object describing the current remote settings of this `Http2Session`.
		The remote settings are set by the connected HTTP/2 peer.
	**/
	var remoteSettings:Http2Settings;

	/**
		Used to set a callback function that is called when there is no activity on the `Http2Session` after `msecs` milliseconds.
		The given `callback` is registered as a listener on the 'timeout' event.
	**/
	function setTimeout(msecs:Int, callback:Void->Void):Void;

	/**
		Returns a Proxy object that acts as a `net.Socket` (or `tls.TLSSocket`) but limits available methods to ones safe to use with HTTP/2.
		
		`destroy`, `emit`, `end`, `pause`, `read`, `resume`, and `write` will throw an error with code `ERR_HTTP2_NO_SOCKET_MANIPULATION`.

		`setTimeout` method will be called on this `Http2Session`.

		All other interactions will be routed directly to the socket.
	**/
	var socket:EitherType<Socket,TLSSocket>;

	/**
		Provides miscellaneous information about the current state of the `Http2Session`.
	**/
	var state:Http2SessionState;

	/**
		Updates the current local settings for this `Http2Session` and sends a new `SETTINGS` frame to the connected HTTP/2 peer.
		
		Once called, the `pendingSettingsAck` property will be `true` while the session is waiting for the remote peer to acknowledge the new settings.

		*Note*: The new settings will not become effective until the `SETTINGS` acknowledgment is received and the 'localSettings' event is emitted. It is possible to send multiple `SETTINGS` frames while acknowledgment is still pending.
	**/
	function settings(settings:Http2Settings):Void;

	/**
		The `type` will be equal to `http2.Constants.NGHTTP2_SESSION_SERVER` if this `Http2Session` instance is a server, and `http2.Constants.NGHTTP2_SESSION_CLIENT` if the instance is a client.
	**/
	var type:Int;

	/**
		Calls `unref` on this `Http2Session` instance's underlying `net.Socket`.
	**/
	function unref():Void;
}

/**
	The type of callback for `Http2Session.ping`.

	The callback will be invoked with three arguments:
	- an error argument that will be null if the PING was successfully acknowledged,
	- a duration argument that reports the number of milliseconds elapsed since the ping was sent and the acknowledgment was received
	- and a Buffer containing the 8-byte PING payload.
**/
typedef Http2SessionPingCallback = 
	#if haxe4
	(error:Null<js.Error>, duration:Int, payload:Buffer)->Void
	#else
	Null<js.Error>->Int->Buffer->Void
	#end
	;

/**
	An object describing the current status of this `Http2Session`.
**/
typedef Http2SessionState = {
	/**
		The current local (receive) flow control window size for the `Http2Session`.
	**/
	var effectiveLocalWindowSize:Int;

	/**
		The current number of bytes that have been received since the last flow control `WINDOW_UPDATE`.
	**/
	var effectiveRecvDataLength:Int;

	/**
		The numeric identifier to be used the next time a new `Http2Stream` is created by this `Http2Session`.
	**/
	var nextStreamID:Int;

	/**
		The number of bytes that the remote peer can send without receiving a `WINDOW_UPDATE`.
	**/
	var localWindowSize:Int;

	/**
		The numeric id of the `Http2Stream` for which a `HEADERS` or `DATA` frame was most recently received.
	**/
	var lastProcStreamID:Int;

	/**
		The number of bytes that this `Http2Session` may send without receiving a `WINDOW_UPDATE`.
	**/
	var remoteWindowSize:Int;

	/**
		The number of frames currently within the outbound queue for this `Http2Session`.
	**/
	var outboundQueueSize:Int;

	/**
		The current size in bytes of the outbound header compression state table.
	**/
	var deflateDynamicTableSize:Int;

	/**
		The current size in bytes of the inbound header compression state table.
	**/
	var inflateDynamicTableSize:Int;
}
