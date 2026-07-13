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

package js.node.perf_hooks;

/**
	Provides detailed network timing data regarding the loading of an application's resources.

	The constructor of this class is not exposed to users directly.

	@see https://nodejs.org/api/perf_hooks.html#class-performanceresourcetiming
**/
@:jsRequire("perf_hooks", "PerformanceResourceTiming")
extern class PerformanceResourceTiming extends PerformanceEntry {
	/**
		The high resolution millisecond timestamp at immediately before dispatching the `fetch` request.
		If the resource is not intercepted by a worker the property will always return 0.
	**/
	var workerStart(default, null):Float;

	/**
		The high resolution millisecond timestamp that represents the start time of the fetch which
		initiates the redirect.
	**/
	var redirectStart(default, null):Float;

	/**
		The high resolution millisecond timestamp that will be created immediately after receiving the
		last byte of the response of the last redirect.
	**/
	var redirectEnd(default, null):Float;

	/**
		The high resolution millisecond timestamp immediately before the Node.js starts to fetch the resource.
	**/
	var fetchStart(default, null):Float;

	/**
		The high resolution millisecond timestamp immediately before the Node.js starts the domain name
		lookup for the resource.
	**/
	var domainLookupStart(default, null):Float;

	/**
		The high resolution millisecond timestamp representing the time immediately after the Node.js
		finished the domain name lookup for the resource.
	**/
	var domainLookupEnd(default, null):Float;

	/**
		The high resolution millisecond timestamp representing the time immediately before Node.js starts
		to establish the connection to the server to retrieve the resource.
	**/
	var connectStart(default, null):Float;

	/**
		The high resolution millisecond timestamp representing the time immediately after Node.js finishes
		establishing the connection to the server to retrieve the resource.
	**/
	var connectEnd(default, null):Float;

	/**
		The high resolution millisecond timestamp representing the time immediately before Node.js starts
		the handshake process to secure the current connection.
	**/
	var secureConnectionStart(default, null):Float;

	/**
		The high resolution millisecond timestamp representing the time immediately before Node.js receives
		the first byte of the response from the server.
	**/
	var requestStart(default, null):Float;

	/**
		The high resolution millisecond timestamp representing the time immediately after Node.js receives
		the last byte of the resource or immediately before the transport connection is closed, whichever
		comes first.
	**/
	var responseEnd(default, null):Float;

	/**
		A number representing the size (in octets) of the fetched resource. The size includes the response
		header fields plus the response payload body.
	**/
	var transferSize(default, null):Float;

	/**
		A number representing the size (in octets) received from the fetch (HTTP or cache), of the payload
		body, before removing any applied content-codings.
	**/
	var encodedBodySize(default, null):Float;

	/**
		A number representing the size (in octets) received from the fetch (HTTP or cache), of the message
		body, after removing any applied content-codings.
	**/
	var decodedBodySize(default, null):Float;

	/**
		Returns an object that is the JSON representation of the `PerformanceResourceTiming` object.
	**/
	override function toJSON():Dynamic;
}
