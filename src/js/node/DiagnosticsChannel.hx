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

import haxe.extern.EitherType;
import js.node.diagnostics_channel.Channel;
import js.node.diagnostics_channel.Channel.ChannelListener;
import js.node.diagnostics_channel.Channel.ChannelName;
import js.node.diagnostics_channel.TracingChannel;
import js.node.diagnostics_channel.TracingChannel.TracingChannelChannels;

/**
	The `node:diagnostics_channel` module provides an API to create named channels
	to report arbitrary message data for diagnostics purposes.

	@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html
**/
@:jsRequire("diagnostics_channel")
extern class DiagnosticsChannel {
	/**
		Check if there are active subscribers to the named channel.
		This is helpful if the message you want to send might be expensive to prepare.

		This API is optional but helpful when trying to publish messages from very
		performance-sensitive code.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#diagnostics_channelhassubscribersname
	**/
	static function hasSubscribers(name:ChannelName):Bool;

	/**
		This is the primary entry-point for anyone wanting to publish to a named channel.
		It produces a channel object which is optimized to reduce overhead at publish time
		as much as possible.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#diagnostics_channelchannelname
	**/
	static function channel(name:ChannelName):Channel;

	/**
		Register a message handler to subscribe to this channel.
		This message handler will be run synchronously whenever a message is published
		to the channel. Any errors thrown in the message handler will trigger an
		`'uncaughtException'`.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#diagnostics_channelsubscribename-onmessage
	**/
	static function subscribe(name:ChannelName, onMessage:ChannelListener):Void;

	/**
		Remove a message handler previously registered to this channel with
		`DiagnosticsChannel.subscribe(name, onMessage)`.

		Returns `true` if the handler was found, `false` otherwise.

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#diagnostics_channelunsubscribename-onmessage
	**/
	static function unsubscribe(name:ChannelName, onMessage:ChannelListener):Bool;

	/**
		Creates a `TracingChannel` wrapper for the given TracingChannel Channels.
		If a name is given, the corresponding tracing channels will be created in the
		form of `tracing:${name}:${eventType}` where `eventType` corresponds to the
		types of TracingChannel Channels.

		Stability: 1 - Experimental

		@see https://nodejs.org/docs/latest-v24.x/api/diagnostics_channel.html#diagnostics_channeltracingchannelnameorchannels
	**/
	static function tracingChannel(nameOrChannels:EitherType<String, TracingChannelChannels>):TracingChannel;
}
