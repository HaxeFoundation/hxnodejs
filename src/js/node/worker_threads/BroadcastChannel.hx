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

package js.node.worker_threads;

import js.node.web.EventTarget;
import js.node.web.MessageEvent;

/**
	Asynchronous one-to-many messaging with all other `BroadcastChannel` instances
	bound to the same channel name.

	Also available as the web global `js.node.web.BroadcastChannel`.

	@see https://nodejs.org/docs/latest-v24.x/api/worker_threads.html#class-broadcastchannel
**/
@:jsRequire("worker_threads", "BroadcastChannel")
extern class BroadcastChannel extends EventTarget {
	/**
		The channel name.
	**/
	var name(default, null):String;

	var onmessage:Null<MessageEvent->Void>;
	var onmessageerror:Null<MessageEvent->Void>;

	function new(name:String):Void;

	/**
		Closes the channel connection.
	**/
	function close():Void;

	/**
		Posts a message that will be delivered to all other `BroadcastChannel`
		objects listening on the same name.
	**/
	function postMessage(message:Any):Void;

	/**
		Opposite of `unref()`. Returns `this`.
	**/
	function ref():BroadcastChannel;

	/**
		Allows the thread to exit if this is the only active handle. Returns `this`.
	**/
	function unref():BroadcastChannel;
}
