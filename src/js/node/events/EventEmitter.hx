/*
 * Copyright (C)2014-2019 Haxe Foundation
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

package js.node.events;

import js.lib.Promise;
import haxe.Constraints.Function;

/**
	Enumeration of events emitted by all `EventEmitter` instances.
**/
@:enum abstract EventEmitterEvent<T:Function>(Event<T>) to Event<T> {
	/**
		The `EventEmitter` instance will emit its own `'newListener'` event before
		a listener is added to its internal array of listeners.

		@see https://nodejs.org/api/events.html#events_event_newlistener
	**/
	var NewListener:EventEmitterEvent<String->Function->Void> = "newListener";

	/**
		The `'removeListener'` event is emitted after the `listener` is removed.

		@see https://nodejs.org/api/events.html#events_event_removelistener
	**/
	var RemoveListener:EventEmitterEvent<String->Function->Void> = "removeListener";
}

/**
	Abstract type for events. Its type parameter is a signature
	of a listener for a concrete event.
**/
abstract Event<T:Function>(String) from String to String {}

/**
	All objects which emit events are instances of `EventEmitter`.

	Typically, event names are represented by a camel-cased string, however,
	there aren't any strict restrictions on that, as any string will be accepted.

	Functions can then be attached to objects, to be executed when an event is emitted.
	These functions are called listeners.

	When an `EventEmitter` instance experiences an error, the typical action is to emit an 'error' event.
	Error events are treated as a special case in node. If there is no listener for it, then the default action
	is to print a stack trace and exit the program.

	All `EventEmitter`s emit the event `newListener` when new listeners are added
	and `removeListener` when a listener is removed.
**/
@:jsRequire("events", "EventEmitter")
extern class EventEmitter<TSelf:EventEmitter<TSelf>> implements IEventEmitter {
	function new();

	static var defaultMaxListeners:Int;
	function addListener<T:Function>(event:Event<T>, listener:T):TSelf;

	function emit<T:Function>(event:Event<T>, args:haxe.extern.Rest<Dynamic>):Bool;
	function eventNames():Array<String>;
	function getMaxListeners():Int;
	static function listenerCount<T:Function>(emitter:IEventEmitter, event:Event<T>):Int;
	function listeners<T:Function>(event:Event<T>):Array<T>;

	function off<T:Function>(event:Event<T>, listener:T):TSelf;
	function on<T:Function>(event:Event<T>, listener:T):TSelf;

	function once<T:Function>(event:Event<T>, listener:T):TSelf;
	function prependListener<T:Function>(event:Event<T>, listener:T):TSelf;

	function prependOnceListener<T:Function>(event:Event<T>, listener:T):TSelf;

	function removeAllListeners<T:Function>(?event:Event<T>):TSelf;
	function removeListener<T:Function>(event:Event<T>, listener:T):TSelf;

	function setMaxListeners(n:Int):Void;
	function rawListeners<T:Function>(eventName:Event<T>):Void;
	static inline function eventsOnce<T>(emitter:IEventEmitter,name:String):Promise<T>
	{
		return EventsModules.once(emitter,name);
	}
}

@js:Require("events")
private extern class EventsModules
{
	static function once<T>(emitter:IEventEmitter,name:String):Promise<T>;
}

/**
	`IEventEmitter` interface is used as "any EventEmitter".

	See `EventEmitter` for actual class documentation.
**/
@:remove
extern interface IEventEmitter {
	function addListener<T:Function>(event:Event<T>, listener:T):IEventEmitter;
	function emit<T:Function>(event:Event<T>, args:haxe.extern.Rest<Dynamic>):Bool;
	function eventNames():Array<String>;
	function getMaxListeners():Int;
	function listeners<T:Function>(event:Event<T>):Array<T>;
	function on<T:Function>(event:Event<T>, listener:T):IEventEmitter;
	function once<T:Function>(event:Event<T>, listener:T):IEventEmitter;
	function prependListener<T:Function>(event:Event<T>, listener:T):IEventEmitter;
	function prependOnceListener<T:Function>(event:Event<T>, listener:T):IEventEmitter;
	function removeAllListeners<T:Function>(?event:Event<T>):IEventEmitter;
	function removeListener<T:Function>(event:Event<T>, listener:T):IEventEmitter;
	function setMaxListeners(n:Int):Void;
}
