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

package js.node;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.http2.ClientHttp2Session;
import js.node.http2.Http2Constants;
import js.node.http2.Http2SecureServer;
import js.node.http2.Http2Server;
import js.node.http2.Http2ServerRequest;
import js.node.http2.Http2ServerResponse;
import js.node.http2.ServerHttp2Session;
import js.node.stream.Duplex.IDuplex;
import js.node.tls.SecureContext.SecureContextOptions;
import js.node.url.URL;
import js.node.web.AbortSignal;
import js.lib.Symbol;

/**
	HTTP/2 headers object.

	Header names are lower-cased. Pseudo-headers such as `:status` may be present.
	Outgoing `:status` values are numeric.
**/
typedef Http2Headers = DynamicAccess<EitherType<EitherType<String, Array<String>>, Int>>;

/**
	Incoming HTTP/2 headers. Values are strings or string arrays; `:status` may appear as a number on responses.
**/
typedef IncomingHttp2Headers = DynamicAccess<EitherType<EitherType<String, Array<String>>, Int>>;

/**
	Settings object used by `Http2Session` instances.
**/
typedef Http2Settings = {
	@:optional var headerTableSize:Int;
	@:optional var enablePush:Bool;
	@:optional var initialWindowSize:Int;
	@:optional var maxFrameSize:Int;
	@:optional var maxConcurrentStreams:Int;
	@:optional var maxHeaderListSize:Int;
	@:optional var enableConnectProtocol:Bool;
	@:optional var customSettings:DynamicAccess<Int>;
}

/**
	State information about an `Http2Session`.
**/
typedef Http2SessionState = {
	@:optional var effectiveLocalWindowSize:Int;
	@:optional var effectiveRecvDataLength:Int;
	@:optional var nextStreamID:Int;
	@:optional var localWindowSize:Int;
	@:optional var lastProcStreamID:Int;
	@:optional var remoteWindowSize:Int;
	@:optional var outboundQueueSize:Int;
	@:optional var deflateDynamicTableSize:Int;
	@:optional var inflateDynamicTableSize:Int;
}

/**
	State information about an `Http2Stream`.
**/
typedef Http2StreamState = {
	@:optional var localWindowSize:Int;
	@:optional var state:Int;
	@:optional var localClose:Int;
	@:optional var remoteClose:Int;
	@:deprecated("Priority signaling is no longer supported in Node.js") @:optional var sumDependencyWeight:Int;
	@:deprecated("Priority signaling is no longer supported in Node.js") @:optional var weight:Int;
}

/**
	Base session options shared by client and server sessions.
**/
typedef Http2SessionOptions = {
	/**
		Sets the maximum dynamic table size for deflating header fields.
		Default: `4096`.
	**/
	@:optional var maxDeflateDynamicTableSize:Int;

	/**
		Sets the maximum number of settings entries per `SETTINGS` frame.
		Default: `32`.
	**/
	@:optional var maxSettings:Int;

	/**
		Sets the maximum memory that the `Http2Session` is permitted to use (megabytes).
		Default: `10`.
	**/
	@:optional var maxSessionMemory:Int;

	/**
		Sets the maximum number of header entries.
		Default: `128`.
	**/
	@:optional var maxHeaderListPairs:Int;

	/**
		Sets the maximum number of outstanding, unacknowledged pings.
		Default: `10`.
	**/
	@:optional var maxOutstandingPings:Int;

	/**
		Sets the maximum allowed size for a serialized, compressed block of headers.
	**/
	@:optional var maxSendHeaderBlockLength:Int;

	/**
		Strategy used for determining the amount of padding to use for `HEADERS` and `DATA` frames.
		Default: `Http2.constants.PADDING_STRATEGY_NONE`.
	**/
	@:optional var paddingStrategy:Int;

	/**
		Sets the maximum number of concurrent streams for the remote peer.
		Default: `100`.
	**/
	@:optional var peerMaxConcurrentStreams:Int;

	/**
		The initial settings to send to the remote peer upon connection.
	**/
	@:optional var settings:Http2Settings;

	/**
		Setting types included in the `customSettings` property of received remote settings.
	**/
	@:optional var remoteCustomSettings:Array<Int>;

	/**
		Timeout in milliseconds when an `'unknownProtocol'` event is emitted.
		Default: `10000`.
	**/
	@:optional var unknownProtocolTimeout:Int;

	/**
		If `true`, turns on strict leading/trailing whitespace validation for HTTP/2 header fields.
		Default: `true`.
	**/
	@:optional var strictFieldWhitespaceValidation:Bool;
}

/**
	Options for `Http2.connect`.
**/
typedef Http2ClientSessionOptions = {
	> Http2SessionOptions,

	/**
		Maximum number of reserved push streams the client will accept.
		Default: `200`.
	**/
	@:optional var maxReservedRemoteStreams:Int;

	/**
		Optional callback that returns a `Duplex` stream to use as the connection.
	**/
	@:optional var createConnection:(authority:URL, options:Http2SessionOptions) -> IDuplex;

	/**
		The protocol to connect with if not set in the authority.
		Default: `'https:'`.
	**/
	@:optional var protocol:String;
}

/**
	Secure client session options (combines session and TLS connect options).
**/
typedef Http2SecureClientSessionOptions = {
	> Http2ClientSessionOptions,
	> js.node.Tls.TlsConnectOptions,
	> SecureContextOptions,
}

/**
	Options for HTTP/1 fallback classes used by HTTP/2 servers.
**/
typedef Http2Http1Options = {
	@:optional var IncomingMessage:Class<js.node.http.IncomingMessage>;
	@:optional var ServerResponse:Class<js.node.http.ServerResponse>;
	@:optional var keepAliveTimeout:Int;
}

/**
	Options for `Http2.createServer`.
**/
typedef Http2ServerOptions = {
	> Http2SessionOptions,

	@:optional var maxSessionRejectedStreams:Int;
	@:optional var maxSessionInvalidFrames:Int;
	@:optional var streamResetBurst:Int;
	@:optional var streamResetRate:Int;

	/**
		Deprecated. Use `http1Options.IncomingMessage` instead.
		See DEP0202.
	**/
	@:deprecated("Use http1Options.IncomingMessage instead")
	@:optional var Http1IncomingMessage:Class<js.node.http.IncomingMessage>;

	/**
		Deprecated. Use `http1Options.ServerResponse` instead.
		See DEP0202.
	**/
	@:deprecated("Use http1Options.ServerResponse instead")
	@:optional var Http1ServerResponse:Class<js.node.http.ServerResponse>;

	/**
		Options for configuring the HTTP/1 fallback when `allowHTTP1` is `true`.
		Added in Node.js v24.15.0 (Active LTS); not available on Maintenance LTS 22.x.
	**/
	@:optional var http1Options:Http2Http1Options;

	@:optional var Http2ServerRequest:Class<Http2ServerRequest>;
	@:optional var Http2ServerResponse:Class<Http2ServerResponse>;

	/**
		If `true`, strict validation is used for headers and trailers defined as
		having only a single value.
		Default: `true`.
		Added in Node.js v24.15.0 (Active LTS); not available on Maintenance LTS 22.x.
	**/
	@:optional var strictSingleValueFields:Bool;
}

/**
	Options for `Http2.createSecureServer`.
**/
typedef Http2SecureServerOptions = {
	> Http2ServerOptions,
	> js.node.Tls.TlsCreateServerOptions,
	> SecureContextOptions,

	/**
		Set to `true` to enable support for HTTP/1.1 requests.
	**/
	@:optional var allowHTTP1:Bool;

	/**
		Origins to include in an `ORIGIN` frame.
	**/
	@:optional var origins:Array<String>;
}

/**
	Options for `ClientHttp2Session.request`.
**/
typedef Http2ClientSessionRequestOptions = {
	@:optional var endStream:Bool;
	@:optional var exclusive:Bool;
	@:optional var parent:Int;

	/**
		Priority signaling is deprecated (RFC 9113). Ignored with a runtime warning since Node.js v24.2.0.
	**/
	@:deprecated("Priority signaling is no longer supported in Node.js")
	@:optional var weight:Int;

	@:optional var waitForTrailers:Bool;
	@:optional var signal:AbortSignal;
}

/**
	Options for `ServerHttp2Stream.respond`.
**/
typedef Http2ServerStreamResponseOptions = {
	@:optional var endStream:Bool;
	@:optional var waitForTrailers:Bool;
}

/**
	Options for `ServerHttp2Stream.pushStream`.
**/
typedef Http2PushStreamOptions = {
	@:optional var exclusive:Bool;
	@:optional var parent:Int;

	/**
		Priority signaling is deprecated (RFC 9113). Ignored with a runtime warning since Node.js v24.2.0.
	**/
	@:deprecated("Priority signaling is no longer supported in Node.js")
	@:optional var weight:Int;

	@:optional var silent:Bool;
}

/**
	`statCheck` options for file responses.
**/
typedef Http2StatOptions = {
	var offset:Int;
	var length:Int;
}

/**
	Options for `ServerHttp2Stream.respondWithFile` / `respondWithFD`.
**/
typedef Http2ServerStreamFileResponseOptions = {
	@:optional var statCheck:(stats:js.node.fs.Stats, headers:Http2Headers, statOptions:Http2StatOptions) -> EitherType<Void, Bool>;
	@:optional var waitForTrailers:Bool;
	@:optional var offset:Int;
	@:optional var length:Int;
	@:optional var onError:(err:js.lib.Error) -> Void;
}

/**
	The `node:http2` module provides an implementation of the HTTP/2 protocol.

	@see https://nodejs.org/api/http2.html
**/
@:jsRequire("http2")
extern class Http2 {
	/**
		Constants for HTTP/2 sessions, streams, headers, methods and status codes.
	**/
	static var constants(default, null):Http2Constants;

	/**
		Symbol that can be set as a property on an HTTP/2 headers object with an array value
		to mark headers as sensitive.
	**/
	static var sensitiveHeaders(default, null):Symbol;

	/**
		Returns an object containing the default settings for an `Http2Session` instance.
		This method returns a new object instance every time it is called.
	**/
	static function getDefaultSettings():Http2Settings;

	/**
		Returns a `Buffer` containing the serialized representation of the given HTTP/2 settings.
	**/
	static function getPackedSettings(settings:Http2Settings):Buffer;

	/**
		Returns an HTTP/2 settings object containing the deserialized settings from the given buffer
		(or `TypedArray` / `DataView`).
	**/
	static function getUnpackedSettings(buf:js.lib.ArrayBufferView):Http2Settings;

	/**
		Returns a `net.Server` instance that creates and manages `Http2Session` instances.
	**/
	@:overload(function(options:Http2ServerOptions, ?onRequestHandler:(request:Http2ServerRequest, response:Http2ServerResponse) -> Void):Http2Server {})
	static function createServer(?onRequestHandler:(request:Http2ServerRequest, response:Http2ServerResponse) -> Void):Http2Server;

	/**
		Returns a `tls.Server` instance that creates and manages `Http2Session` instances.
	**/
	@:overload(function(options:Http2SecureServerOptions, ?onRequestHandler:(request:Http2ServerRequest, response:Http2ServerResponse) -> Void):Http2SecureServer {})
	static function createSecureServer(?onRequestHandler:(request:Http2ServerRequest, response:Http2ServerResponse) -> Void):Http2SecureServer;

	/**
		Returns a `ClientHttp2Session` instance.
	**/
	@:overload(function(authority:URL, listener:(session:ClientHttp2Session, socket:js.node.net.Socket) -> Void):ClientHttp2Session {})
	@:overload(function(authority:String, listener:(session:ClientHttp2Session, socket:js.node.net.Socket) -> Void):ClientHttp2Session {})
	@:overload(function(authority:URL, ?options:EitherType<Http2ClientSessionOptions, Http2SecureClientSessionOptions>,
		?listener:(session:ClientHttp2Session, socket:js.node.net.Socket) -> Void):ClientHttp2Session {})
	static function connect(authority:String, ?options:EitherType<Http2ClientSessionOptions, Http2SecureClientSessionOptions>,
		?listener:(session:ClientHttp2Session, socket:js.node.net.Socket) -> Void):ClientHttp2Session;

	/**
		Create an HTTP/2 server session from an existing duplex socket.
	**/
	static function performServerHandshake(socket:IDuplex, ?options:Http2ServerOptions):ServerHttp2Session;
}
