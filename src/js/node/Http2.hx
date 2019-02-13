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
package js.node;

import haxe.extern.EitherType;

/**
	The http2 module provides an implementation of the HTTP/2 protocol.
**/
@:jsRequire("http2")
extern class Http2 {

}

/**
	Headers are represented as own-properties on JavaScript objects.
	The property keys will be serialized to lower-case.
	Property values should be strings (if they are not they will be coerced to strings) or an Array of strings (in order to send more than one value per header field).
**/
typedef Http2Headers = haxe.DynamicAccess<EitherType<String,Array<String>>>;

typedef Http2Settings = {
	/**
		Specifies the maximum number of bytes used for header compression.
		The minimum allowed value is 0. The maximum allowed value is 232-1.
		Default: 4,096 octets.
	**/
	@:optional var headerTableSize:Int;

	/**
		Specifies true if HTTP/2 Push Streams are to be permitted on the Http2Session instances.
	**/
	@:optional var enablePush:Bool;

	/**
		Specifies the senders initial window size for stream-level flow control.
		The minimum allowed value is 0. The maximum allowed value is 232-1.
		Default: 65,535 bytes.
	**/
	@:optional var initialWindowSize:Int;

	/**
		Specifies the size of the largest frame payload.
		The minimum allowed value is 16,384. The maximum allowed value is 224-1.
		Default: 16,384 bytes.
	**/
	@:optional var maxFrameSize:Int;

	/**
		Specifies the maximum number of concurrent streams permitted on an `Http2Session`.
		There is no default value which implies, at least theoretically, 231-1 streams may be open concurrently at any given time in an `Http2Session`.
		The minimum value is 0. The maximum allowed value is 231-1.
	**/
	@:optional var maxConcurrentStreams:Int;

	/**
		Specifies the maximum size (uncompressed octets) of header list that will be accepted.
		The minimum allowed value is 0. The maximum allowed value is 232-1. Default: 65535.
	**/
	@:optional var maxHeaderListSize:Int;

}
