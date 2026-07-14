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

package js.node.perf_hooks;

/**
	Provides detailed network timing data regarding the loading of an application's resources.

	The constructor of this class is not exposed to users directly.

	@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#class-performanceresourcetiming
**/
@:jsRequire("perf_hooks", "PerformanceResourceTiming")
extern class PerformanceResourceTiming extends PerformanceEntry {
	/**
		The high resolution millisecond timestamp at immediately before dispatching the `fetch` request.
		If the resource is not intercepted by a worker the property will always return 0.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingworkerstart
	**/
	final workerStart:Float;

	/**
		The high resolution millisecond timestamp that represents the start time of the fetch which
		initiates the redirect.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingredirectstart
	**/
	final redirectStart:Float;

	/**
		The high resolution millisecond timestamp that will be created immediately after receiving the
		last byte of the response of the last redirect.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingredirectend
	**/
	final redirectEnd:Float;

	/**
		The high resolution millisecond timestamp immediately before the Node.js starts to fetch the resource.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingfetchstart
	**/
	final fetchStart:Float;

	/**
		The high resolution millisecond timestamp immediately before the Node.js starts the domain name
		lookup for the resource.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingdomainlookupstart
	**/
	final domainLookupStart:Float;

	/**
		The high resolution millisecond timestamp representing the time immediately after the Node.js
		finished the domain name lookup for the resource.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingdomainlookupend
	**/
	final domainLookupEnd:Float;

	/**
		The high resolution millisecond timestamp representing the time immediately before Node.js starts
		to establish the connection to the server to retrieve the resource.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingconnectstart
	**/
	final connectStart:Float;

	/**
		The high resolution millisecond timestamp representing the time immediately after Node.js finishes
		establishing the connection to the server to retrieve the resource.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingconnectend
	**/
	final connectEnd:Float;

	/**
		The high resolution millisecond timestamp representing the time immediately before Node.js starts
		the handshake process to secure the current connection.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingsecureconnectionstart
	**/
	final secureConnectionStart:Float;

	/**
		The high resolution millisecond timestamp representing the time immediately before Node.js receives
		the first byte of the response from the server.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingrequeststart
	**/
	final requestStart:Float;

	/**
		The high resolution millisecond timestamp representing the time immediately after the first byte of
		the response is received from the server.
	**/
	final responseStart:Float;

	/**
		The high resolution millisecond timestamp representing the time immediately after Node.js receives
		the last byte of the resource or immediately before the transport connection is closed, whichever
		comes first.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingresponseend
	**/
	final responseEnd:Float;

	/**
		A number representing the size (in octets) of the fetched resource. The size includes the response
		header fields plus the response payload body.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingtransfersize
	**/
	final transferSize:Float;

	/**
		A number representing the size (in octets) received from the fetch (HTTP or cache), of the payload
		body, before removing any applied content-codings.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingencodedbodysize
	**/
	final encodedBodySize:Float;

	/**
		A number representing the size (in octets) received from the fetch (HTTP or cache), of the message
		body, after removing any applied content-codings.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingdecodedbodysize
	**/
	final decodedBodySize:Float;

	/**
		A string representing the type of resource fetch that initiated this timing entry
		(for example `'fetch'` or `'xmlhttprequest'`).
	**/
	final initiatorType:String;

	/**
		A string representing the network protocol used to fetch the resource
		(for example `'http/1.1'` or `'h2'`).
	**/
	final nextHopProtocol:String;

	/**
		A number representing the HTTP response status code returned when fetching the resource.
	**/
	final responseStatus:Float;

	/**
		A string representing how the resource was delivered (for example cache delivery type).
		Empty string when not applicable.
	**/
	final deliveryType:String;

	/**
		Returns an object that is the JSON representation of the `PerformanceResourceTiming` object.

		@see https://nodejs.org/docs/latest-v24.x/api/perf_hooks.html#performanceresourcetimingtojson
	**/
	override function toJSON():Any;
}
