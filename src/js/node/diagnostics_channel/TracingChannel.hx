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

package js.node.diagnostics_channel;

import haxe.Constraints.Function;
import haxe.extern.Rest;
import js.lib.Promise;

/**
	Object containing all the TracingChannel Channels, passed to
	`DiagnosticsChannel.tracingChannel`.
**/
typedef TracingChannelChannels = {
	var start:Channel;
	var end:Channel;
	var asyncStart:Channel;
	var asyncEnd:Channel;
	var error:Channel;
}

/**
	Handler for a tracing channel message.
**/
typedef TracingChannelMessageHandler = (message:Dynamic) -> Void;

/**
	Set of TracingChannel Channels subscribers.
	Each handler is optional; omit any that are not needed.
**/
typedef TracingChannelSubscribers = {
	/**
		The `start` event subscriber.
	**/
	@:optional var start:TracingChannelMessageHandler;

	/**
		The `end` event subscriber.
	**/
	@:optional var end:TracingChannelMessageHandler;

	/**
		The `asyncStart` event subscriber.
	**/
	@:optional var asyncStart:TracingChannelMessageHandler;

	/**
		The `asyncEnd` event subscriber.
	**/
	@:optional var asyncEnd:TracingChannelMessageHandler;

	/**
		The `error` event subscriber.
	**/
	@:optional var error:TracingChannelMessageHandler;
}

/**
	The class `TracingChannel` is a collection of TracingChannel Channels which
	together express a single traceable action. It is used to formalize and simplify
	the process of producing events for tracing application flow.

	`DiagnosticsChannel.tracingChannel()` is used to construct a `TracingChannel`.
	As with `Channel` it is recommended to create and reuse a single `TracingChannel`
	at the top-level of the file rather than creating them dynamically.

	Stability: 1 - Experimental

	@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#class-tracingchannel
**/
extern class TracingChannel {
	private function new();

	/**
		Channel for the `start` event (`tracing:${name}:start`).
	**/
	final start:Channel;

	/**
		Channel for the `end` event (`tracing:${name}:end`).
	**/
	final end:Channel;

	/**
		Channel for the `asyncStart` event (`tracing:${name}:asyncStart`).
	**/
	final asyncStart:Channel;

	/**
		Channel for the `asyncEnd` event (`tracing:${name}:asyncEnd`).
	**/
	final asyncEnd:Channel;

	/**
		Channel for the `error` event (`tracing:${name}:error`).
	**/
	final error:Channel;

	/**
		This is a helper to check if any of the TracingChannel Channels have subscribers.
		Returns `true` if any of them have at least one subscriber, `false` otherwise.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#tracingchannelhassubscribers
	**/
	final hasSubscribers:Bool;

	/**
		Helper to subscribe a collection of functions to the corresponding channels.
		This is the same as calling `channel.subscribe(onMessage)` on each channel
		individually.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#tracingchannelsubscribesubscribers
	**/
	function subscribe(subscribers:TracingChannelSubscribers):Void;

	/**
		Helper to unsubscribe a collection of functions from the corresponding channels.
		This is the same as calling `channel.unsubscribe(onMessage)` on each channel
		individually.

		Returns `true` if all handlers were successfully unsubscribed, and `false` otherwise.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#tracingchannelunsubscribesubscribers
	**/
	function unsubscribe(subscribers:TracingChannelSubscribers):Bool;

	/**
		Trace a synchronous function call. This will always produce a `start` event and
		`end` event around the execution and may produce an `error` event if the given
		function throws an error.

		This will run the given function using `channel.runStores(context, ...)` on the
		`start` channel which ensures all events should have any bound stores set to
		match this trace context.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#tracingchanneltracesyncfn-context-thisarg-args
	**/
	function traceSync(fn:Function, ?context:{}, ?thisArg:Dynamic, args:Rest<Dynamic>):Dynamic;

	/**
		Trace a promise-returning function call. This will always produce a `start`
		event and `end` event around the synchronous portion of the function execution,
		and will produce an `asyncStart` event and `asyncEnd` event when a promise
		continuation is reached. It may also produce an `error` event if the given
		function throws an error or the returned promise rejects.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#tracingchanneltracepromisefn-context-thisarg-args
	**/
	function tracePromise(fn:Function, ?context:{}, ?thisArg:Dynamic, args:Rest<Dynamic>):Promise<Dynamic>;

	/**
		Trace a callback-receiving function call. The callback is expected to follow
		the error as first arg convention typically used.

		This will always produce a `start` event and `end` event around the synchronous
		portion of the function execution, and will produce a `asyncStart` event and
		`asyncEnd` event around the callback execution. It may also produce an `error`
		event if the given function throws or the first argument passed to the callback
		is set.

		`position` is the zero-indexed argument position of the expected callback
		(defaults to last argument if `undefined` is passed).

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#tracingchanneltracecallbackfn-position-context-thisarg-args
	**/
	function traceCallback(fn:Function, ?position:Int, ?context:{}, ?thisArg:Dynamic, args:Rest<Dynamic>):Dynamic;
}
