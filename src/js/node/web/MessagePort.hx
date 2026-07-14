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

package js.node.web;

/**
	One end of a two-way communication channel created by `MessageChannel`.

	Also available via `worker_threads` (see section 5); this is the web global form.

	@see https://nodejs.org/api/globals.html#class-messageport
**/
@:native("MessagePort")
extern class MessagePort extends EventTarget {
	var onmessage:Null<MessageEvent->Void>;
	var onmessageerror:Null<MessageEvent->Void>;

	/**
		Posts a message through the channel. `transfer` is a list of transferable objects
		to transfer ownership of.

		TODO(section-5): tighten `transfer` once worker_threads transferable types are externed.
	**/
	function postMessage(message:Any, ?transfer:Array<Any>):Void;

	/**
		Starts dispatching messages received on this port. (Implicit when `onmessage` is set.)
	**/
	function start():Void;

	/**
		Disconnects the port and stops receiving messages.
	**/
	function close():Void;

	function ref():MessagePort;
	function unref():MessagePort;
	function hasRef():Bool;
}
