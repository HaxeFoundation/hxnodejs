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

package js.node.inspector;

import haxe.DynamicAccess;

/**
	Broadcast helpers for Chrome DevTools Protocol `Network.*` events.

	Stability: 1.1 - Active development.

	These APIs require the `--experimental-network-inspection` flag.

	Usage: `Network.requestWillBeSent({ ... })` (maps to `inspector.Network` in Node.js).

	@see https://nodejs.org/docs/latest-v24.x/api/inspector.html#integration-with-devtools
**/
@:jsRequire("inspector", "Network")
extern class Network {
	/**
		Broadcasts the `Network.dataReceived` event to connected frontends, or buffers the data if
		`Network.streamResourceContent` command was not invoked for the given request yet.

		Also enables `Network.getResponseBody` command to retrieve the response data.

		Added in: v24.2.0.
	**/
	static function dataReceived(?params:NetworkDataReceivedParams):Void;

	/**
		Enables `Network.getRequestPostData` command to retrieve the request data.

		Added in: v24.3.0.
	**/
	static function dataSent(?params:NetworkDataSentParams):Void;

	/**
		Broadcasts the `Network.requestWillBeSent` event to connected frontends.
		This event indicates that the application is about to send an HTTP request.
	**/
	static function requestWillBeSent(?params:NetworkRequestWillBeSentParams):Void;

	/**
		Broadcasts the `Network.responseReceived` event to connected frontends.
		This event indicates that HTTP response is available.
	**/
	static function responseReceived(?params:NetworkResponseReceivedParams):Void;

	/**
		Broadcasts the `Network.loadingFinished` event to connected frontends.
		This event indicates that HTTP request has finished loading.
	**/
	static function loadingFinished(?params:NetworkLoadingFinishedParams):Void;

	/**
		Broadcasts the `Network.loadingFailed` event to connected frontends.
		This event indicates that HTTP request has failed to load.
	**/
	static function loadingFailed(?params:NetworkLoadingFailedParams):Void;

	/**
		Broadcasts the `Network.webSocketCreated` event to connected frontends.
		This event indicates that a WebSocket connection has been initiated.

		Added in: v24.7.0. Not available on Maintenance LTS 22.x.
	**/
	static function webSocketCreated(?params:NetworkWebSocketCreatedParams):Void;

	/**
		Broadcasts the `Network.webSocketHandshakeResponseReceived` event to connected frontends.
		This event indicates that the WebSocket handshake response has been received.

		Added in: v24.7.0. Not available on Maintenance LTS 22.x.
	**/
	static function webSocketHandshakeResponseReceived(?params:NetworkWebSocketHandshakeResponseReceivedParams):Void;

	/**
		Broadcasts the `Network.webSocketClosed` event to connected frontends.
		This event indicates that a WebSocket connection has been closed.

		Added in: v24.7.0. Not available on Maintenance LTS 22.x.
	**/
	static function webSocketClosed(?params:NetworkWebSocketClosedParams):Void;
}

/**
	Pragmatic subset of CDP `Network.Request`.
**/
typedef NetworkRequest = {
	var url:String;
	var method:String;
	@:optional var headers:DynamicAccess<String>;
	@:optional var postData:String;
	@:optional var hasPostData:Bool;
}

/**
	Pragmatic subset of CDP `Network.Response`.
**/
typedef NetworkResponse = {
	@:optional var url:String;
	@:optional var status:Int;
	@:optional var statusText:String;
	@:optional var headers:DynamicAccess<String>;
	@:optional var mimeType:String;
	@:optional var charset:String;
}

/**
	Pragmatic subset of CDP request initiator.

	`stack` remains `Any` pending a CDP `StackTrace` model in hxnodejs.
**/
typedef NetworkInitiator = {
	var type:String;
	@:optional var url:String;
	@:optional var lineNumber:Float;
	@:optional var columnNumber:Float;
	@:optional var stack:Any;
}

/**
	Parameters for `Network.requestWillBeSent`.
**/
typedef NetworkRequestWillBeSentParams = {
	var requestId:String;
	var timestamp:Float;
	var wallTime:Float;
	var request:NetworkRequest;
	@:optional var initiator:NetworkInitiator;
	@:optional var type:String;
	@:optional var frameId:String;
	@:optional var hasUserGesture:Bool;
}

/**
	Parameters for `Network.responseReceived`.
**/
typedef NetworkResponseReceivedParams = {
	var requestId:String;
	var timestamp:Float;
	var type:String;
	var response:NetworkResponse;
	@:optional var frameId:String;
}

/**
	Parameters for `Network.loadingFinished`.
**/
typedef NetworkLoadingFinishedParams = {
	var requestId:String;
	var timestamp:Float;
	@:optional var encodedDataLength:Float;
}

/**
	Parameters for `Network.loadingFailed`.
**/
typedef NetworkLoadingFailedParams = {
	var requestId:String;
	var timestamp:Float;
	var type:String;
	var errorText:String;
	@:optional var canceled:Bool;
}

/**
	Parameters for `Network.dataReceived`.
**/
typedef NetworkDataReceivedParams = {
	var requestId:String;
	var timestamp:Float;
	var dataLength:Int;
	var encodedDataLength:Int;
	@:optional var data:String;
}

/**
	Parameters for `Network.dataSent`.
**/
typedef NetworkDataSentParams = {
	var requestId:String;
	@:optional var timestamp:Float;
	@:optional var dataLength:Int;
	@:optional var data:String;
}

/**
	Parameters for `Network.webSocketCreated`.
**/
typedef NetworkWebSocketCreatedParams = {
	var requestId:String;
	var url:String;
	@:optional var initiator:NetworkInitiator;
}

/**
	Parameters for `Network.webSocketHandshakeResponseReceived`.
**/
typedef NetworkWebSocketHandshakeResponseReceivedParams = {
	var requestId:String;
	var timestamp:Float;
	var response:NetworkWebSocketResponse;
}

/**
	Pragmatic subset of CDP WebSocket handshake response.
**/
typedef NetworkWebSocketResponse = {
	var status:Int;
	var statusText:String;
	@:optional var headers:DynamicAccess<String>;
}

/**
	Parameters for `Network.webSocketClosed`.
**/
typedef NetworkWebSocketClosedParams = {
	var requestId:String;
	var timestamp:Float;
}
