/*
 * Copyright (C)2014-2025 Haxe Foundation
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

import js.lib.Error;
import js.node.events.EventEmitter;

/**
	Events emitted by `MessagePort`.
**/
enum abstract MessagePortEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	var Close:MessagePortEvent<Void->Void> = "close";
	// TODO(section-5): message value is structured-clone Dynamic
	var Message:MessagePortEvent<Dynamic->Void> = "message";
	var MessageError:MessagePortEvent<Error->Void> = "messageerror";
}

/**
	Instances of `MessagePort` represent one end of an asynchronous two-way communication channel.

	@see https://nodejs.org/docs/latest-v24.x/api/worker_threads.html#class-messageport
**/
@:jsRequire("worker_threads", "MessagePort")
extern class MessagePort extends EventEmitter<MessagePort> {
	/**
		Sends a JavaScript value to the receiving end of the channel.
		`transferList` may include ArrayBuffer, MessagePort, AbortSignal, FileHandle, or web streams.
		// TODO(section-5): value typing for structured clone remains application-defined Dynamic
	**/
	function postMessage(value:Dynamic, ?transferList:Array<Transferable>):Void;

	/**
		Disables further sending of messages from either port. Once done, no further messages can be received.
	**/
	function close():Void;

	/**
		Starts receiving messages. Automatically called if a listener for `'message'` is attached.
	**/
	function start():Void;

	/**
		Opposite of `unref()`. Increases active handle count.
	**/
	function ref():Void;

	/**
		Decreases the reference count. Allows the thread to exit if this is the only active handle.
	**/
	function unref():Void;

	/**
		If true, the MessagePort will keep the event loop of the thread alive.
	**/
	function hasRef():Bool;
}
