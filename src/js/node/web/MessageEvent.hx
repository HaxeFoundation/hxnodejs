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
	Represents a message sent via `MessagePort` / `BroadcastChannel` / `WebSocket`.

	@see https://nodejs.org/api/globals.html#class-messageevent
**/
@:native("MessageEvent")
extern class MessageEvent extends Event {
	/**
		The data sent by the message emitter.
	**/
	var data(default, null):Any;

	/**
		The origin of the message.
	**/
	var origin(default, null):String;

	/**
		A unique ID for the event.
	**/
	var lastEventId(default, null):String;

	/**
		A `MessagePort` object or `null`.
	**/
	var source(default, null):Null<MessagePort>;

	/**
		An array of `MessagePort` objects.
	**/
	var ports(default, null):Array<MessagePort>;

	function new(type:String, ?eventInitDict:MessageEventInit):Void;

	/**
		Initializes a `MessageEvent`.

		Stability: 3 - Legacy.
	**/
	@:deprecated("Use the MessageEvent constructor instead")
	function initMessageEvent(type:String, ?bubbles:Bool, ?cancelable:Bool, ?data:Any, ?origin:String, ?lastEventId:String,
		?source:Null<MessagePort>, ?ports:Array<MessagePort>):Void;
}

/**
	Options for the `MessageEvent` constructor.
**/
typedef MessageEventInit = {
	@:optional var bubbles:Bool;
	@:optional var cancelable:Bool;
	@:optional var composed:Bool;
	@:optional var data:Any;
	@:optional var origin:String;
	@:optional var lastEventId:String;
	@:optional var source:Null<MessagePort>;
	@:optional var ports:Array<MessagePort>;
}
