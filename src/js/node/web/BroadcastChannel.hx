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

package js.node.web;

/**
	A channel for broadcasting messages to other contexts listening on the same name.

	Also available via `worker_threads` (see section 5); this is the web global form.

	@see https://nodejs.org/api/globals.html#class-broadcastchannel
	@see https://nodejs.org/api/worker_threads.html#class-broadcastchannel
**/
@:native("BroadcastChannel")
extern class BroadcastChannel extends EventTarget {
	/**
		The channel name.
	**/
	var name(default, null):String;

	var onmessage:Null<MessageEvent->Void>;
	var onmessageerror:Null<MessageEvent->Void>;

	function new(name:String):Void;

	/**
		Closes the channel.
	**/
	function close():Void;

	/**
		Posts a message that will be delivered to all other `BroadcastChannel` objects listening on the same name.
	**/
	function postMessage(message:Any):Void;

	/**
		Increases the Node.js event-loop reference count for this channel. Returns `this`.
	**/
	function ref():BroadcastChannel;

	/**
		Decreases the Node.js event-loop reference count for this channel. Returns `this`.
	**/
	function unref():BroadcastChannel;
}
