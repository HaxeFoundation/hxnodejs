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
import haxe.extern.EitherType;
import haxe.extern.Rest;
import js.lib.Symbol;
import js.node.async_hooks.AsyncLocalStorage;

/**
	Channel name: a string or symbol.
**/
typedef ChannelName = EitherType<String, Symbol>;

/**
	Handler invoked when a message is published on a channel.

	Arguments:
		* `message` - The message data
		* `name` - The name of the channel
**/
typedef ChannelListener = (message:Dynamic, name:ChannelName) -> Void;

/**
	Transform function used by `Channel.bindStore` to convert published context
	data into the value stored in an `AsyncLocalStorage` instance.
**/
typedef ChannelStoreTransform = (context:Dynamic) -> Dynamic;

/**
	The class `Channel` represents an individual named channel within the data pipeline.
	It is used to track subscribers and to publish messages when there are subscribers present.
	It exists as a separate object to avoid channel lookups at publish time, enabling very fast
	publish speeds and allowing for heavy use while incurring very minimal cost.

	Channels are created with `DiagnosticsChannel.channel(name)`; constructing a channel
	directly with `new Channel(name)` is not supported.

	@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#class-channel
**/
@:jsRequire("diagnostics_channel", "Channel")
extern class Channel {
	private function new();

	/**
		The channel name.
	**/
	final name:ChannelName;

	/**
		Check if there are active subscribers to this channel.
		This is helpful if the message you want to send might be expensive to prepare.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#channelhassubscribers
	**/
	final hasSubscribers:Bool;

	/**
		Publish a message to any subscribers to the channel.
		This will trigger message handlers synchronously so they will execute within
		the same context.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#channelpublishmessage
	**/
	function publish(message:Dynamic):Void;

	/**
		Register a message handler to subscribe to this channel.
		This message handler will be run synchronously whenever a message is published
		to the channel. Any errors thrown in the message handler will trigger an
		`'uncaughtException'`.

		Deprecation of this method was revoked in Node.js v24.8.0; prefer
		`DiagnosticsChannel.subscribe(name, onMessage)` for module-level subscribe when convenient.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#channelsubscribeonmessage
	**/
	function subscribe(onMessage:ChannelListener):Void;

	/**
		Remove a message handler previously registered to this channel with
		`channel.subscribe(onMessage)`.

		Returns `true` if the handler was found, `false` otherwise.

		Deprecation of this method was revoked in Node.js v24.8.0; prefer
		`DiagnosticsChannel.unsubscribe(name, onMessage)` for module-level unsubscribe when convenient.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#channelunsubscribeonmessage
	**/
	function unsubscribe(onMessage:ChannelListener):Bool;

	/**
		When `channel.runStores(context, ...)` is called, the given context data will be
		applied to any store bound to the channel. If the store has already been bound
		the previous `transform` function will be replaced with the new one.
		The `transform` function may be omitted to set the given context data as the
		context directly.

		`store` should be an `AsyncLocalStorage` instance from `node:async_hooks`.

		Stability: 1 - Experimental

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#channelbindstorestore-transform
	**/
	function bindStore(store:AsyncLocalStorage<Dynamic>, ?transform:ChannelStoreTransform):Void;

	/**
		Remove a store previously bound to this channel with `channel.bindStore(store)`.

		`store` should be an `AsyncLocalStorage` instance from `node:async_hooks`.

		Returns `true` if the store was found, `false` otherwise.

		Stability: 1 - Experimental

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#channelunbindstorestore
	**/
	function unbindStore(store:AsyncLocalStorage<Dynamic>):Bool;

	/**
		Applies the given data to any AsyncLocalStorage instances bound to the channel
		for the duration of the given function, then publishes to the channel within
		the scope of that data is applied to the stores.

		If a transform function was given to `channel.bindStore(store)` it will be
		applied to transform the message data before it becomes the context value for
		the store. The prior storage context is accessible from within the transform
		function in cases where context linking is required.

		Stability: 1 - Experimental

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#channelrunstorescontext-fn-thisarg-args
	**/
	function runStores(context:Dynamic, fn:Function, ?thisArg:Dynamic, args:Rest<Dynamic>):Dynamic;
}
