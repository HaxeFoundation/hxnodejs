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
	The `EventEmitter` class is defined and exposed by the `events` module:

	@see https://nodejs.org/api/events.html#events_class_eventemitter
**/
@:jsRequire("events", "EventEmitter")
extern class EventEmitter<TSelf:EventEmitter<TSelf>> implements IEventEmitter {
	function new();

	/**
		By default, a maximum of `10` listeners can be registered for any single
		event. This limit can be changed for individual `EventEmitter` instances
		using the `emitter.setMaxListeners(n)` method. To change the default
		for all `EventEmitter` instances, the `EventEmitter.defaultMaxListeners`
		property can be used. If this value is not a positive number, a `TypeError`
		will be thrown.

		@see https://nodejs.org/api/events.html#events_eventemitter_defaultmaxlisteners
	**/
	static var defaultMaxListeners:Int;

	/**
		Alias for `emitter.on(eventName, listener)`.

		@see https://nodejs.org/api/events.html#events_emitter_addlistener_eventname_listener
	**/
	function addListener<T:Function>(event:Event<T>, listener:T):TSelf;

	/**
		Synchronously calls each of the listeners registered for the event named
		`eventName`, in the order they were registered, passing the supplied arguments
		to each.

		@see https://nodejs.org/api/events.html#events_emitter_emit_eventname_args
	**/
	function emit<T:Function>(event:Event<T>, args:haxe.extern.Rest<Dynamic>):Bool;

	/**
		Returns an array listing the events for which the emitter has registered
		listeners. The values in the array will be strings or `Symbol`s.

		@see https://nodejs.org/api/events.html#events_emitter_eventnames
	**/
	function eventNames():Array<String>;

	/**
		Returns the current max listener value for the `EventEmitter` which is either
		set by `emitter.setMaxListeners(n)` or defaults to
		`EventEmitter.defaultMaxListeners`.

		@see https://nodejs.org/api/events.html#events_emitter_getmaxlisteners
	**/
	function getMaxListeners():Int;

	/**
		Returns the number of listeners listening to the event named `eventName`.

		@see https://nodejs.org/api/events.html#events_emitter_listenercount_eventname
	**/
	static function listenerCount<T:Function>(emitter:IEventEmitter, event:Event<T>):Int;

	/**
		Returns a copy of the array of listeners for the event named `eventName`.

		@see https://nodejs.org/api/events.html#events_emitter_listeners_eventname
	**/
	function listeners<T:Function>(event:Event<T>):Array<T>;

	/**
		Alias for `emitter.removeListener()`.

		@see https://nodejs.org/api/events.html#events_emitter_off_eventname_listener
	**/
	function off<T:Function>(event:Event<T>, listener:T):TSelf;

	/**
		Adds the `listener` function to the end of the listeners array for the
		event named `eventName`. No checks are made to see if the `listener` has
		already been added. Multiple calls passing the same combination of `eventName`
		and `listener` will result in the `listener` being added, and called, multiple
		times.

		@see https://nodejs.org/api/events.html#events_emitter_on_eventname_listener
	**/
	function on<T:Function>(event:Event<T>, listener:T):TSelf;

	/**
		Adds a one-time `listener` function for the event named `eventName`. The
		next time `eventName` is triggered, this listener is removed and then invoked.

		@see https://nodejs.org/api/events.html#events_emitter_once_eventname_listener
	**/
	function once<T:Function>(event:Event<T>, listener:T):TSelf;

	/**
		Adds the `listener` function to the beginning of the listeners array for the
		event named `eventName`. No checks are made to see if the `listener` has
		already been added. Multiple calls passing the same combination of `eventName`
		and `listener` will result in the `listener` being added, and called, multiple
		times.

		@see https://nodejs.org/api/events.html#events_emitter_prependlistener_eventname_listener
	**/
	function prependListener<T:Function>(event:Event<T>, listener:T):TSelf;

	/**
		Adds a one-time `listener` function for the event named `eventName` to the
		beginning of the listeners array. The next time `eventName` is triggered, this
		listener is removed, and then invoked.

		@see https://nodejs.org/api/events.html#events_emitter_prependoncelistener_eventname_listener
	**/
	function prependOnceListener<T:Function>(event:Event<T>, listener:T):TSelf;

	/**
		Removes all listeners, or those of the specified `eventName`.

		@see https://nodejs.org/api/events.html#events_emitter_removealllisteners_eventname
	**/
	function removeAllListeners<T:Function>(?event:Event<T>):TSelf;

	/**
		Removes the specified `listener` from the listener array for the event named
		`eventName`.

		@see https://nodejs.org/api/events.html#events_emitter_removelistener_eventname_listener
	**/
	function removeListener<T:Function>(event:Event<T>, listener:T):TSelf;

	/**
		By default `EventEmitter`s will print a warning if more than `10` listeners are
		added for a particular event. This is a useful default that helps finding
		memory leaks. Obviously, not all events should be limited to just 10 listeners.
		The `emitter.setMaxListeners()` method allows the limit to be modified for this
		specific `EventEmitter` instance. The value can be set to `Infinity` (or `0`)
		to indicate an unlimited number of listeners.

		@see https://nodejs.org/api/events.html#events_emitter_setmaxlisteners_n
	**/
	function setMaxListeners(n:Int):Void;

	/**
		Returns a copy of the array of listeners for the event named `eventName`,
		including any wrappers (such as those created by `.once()`).

		@see https://nodejs.org/api/events.html#events_emitter_rawlisteners_eventname
	**/
	function rawListeners<T:Function>(eventName:Event<T>):Void;

	/**
		Creates a `Promise` that is resolved when the `EventEmitter` emits the given
		event or that is rejected when the `EventEmitter` emits `'error'`.
		The `Promise` will resolve with an array of all the arguments emitted to the
		given event.

		@see https://nodejs.org/api/events.html#events_events_once_emitter_name
	**/
	static inline function eventsOnce<T>(emitter:IEventEmitter, name:String):Promise<T> {
		return EventsModules.once(emitter, name);
	}
}

@:jsRequire("events")
private extern class EventsModules {
	/**
		Creates a `Promise` that is resolved when the `EventEmitter` emits the given
		event or that is rejected when the `EventEmitter` emits `'error'`.
		The `Promise` will resolve with an array of all the arguments emitted to the
		given event.

		@see https://nodejs.org/api/events.html#events_events_once_emitter_name
	**/
	static function once<T>(emitter:IEventEmitter, name:String):Promise<T>;
}

/**
	`IEventEmitter` interface is used as "any EventEmitter".

	See `EventEmitter` for actual class documentation.
**/
@:remove
extern interface IEventEmitter {
	/**
		Alias for `emitter.on(eventName, listener)`.

		@see https://nodejs.org/api/events.html#events_emitter_addlistener_eventname_listener
	**/
	function addListener<T:Function>(event:Event<T>, listener:T):IEventEmitter;

	/**
		Synchronously calls each of the listeners registered for the event named
		`eventName`, in the order they were registered, passing the supplied arguments
		to each.

		@see https://nodejs.org/api/events.html#events_emitter_emit_eventname_args
	**/
	function emit<T:Function>(event:Event<T>, args:haxe.extern.Rest<Dynamic>):Bool;

	/**
		Returns an array listing the events for which the emitter has registered
		listeners. The values in the array will be strings or `Symbol`s.

		@see https://nodejs.org/api/events.html#events_emitter_eventnames
	**/
	function eventNames():Array<String>;

	/**
		Returns the current max listener value for the `EventEmitter` which is either
		set by `emitter.setMaxListeners(n)` or defaults to
		`EventEmitter.defaultMaxListeners`.

		@see https://nodejs.org/api/events.html#events_emitter_getmaxlisteners
	**/
	function getMaxListeners():Int;

	/**
		Returns a copy of the array of listeners for the event named `eventName`.

		@see https://nodejs.org/api/events.html#events_emitter_listeners_eventname
	**/
	/**
		Alias for `emitter.removeListener()`.

		@see https://nodejs.org/api/events.html#events_emitter_off_eventname_listener
	**/
	function listeners<T:Function>(event:Event<T>):Array<T>;

	/**
		Alias for `emitter.removeListener()`.

		@see https://nodejs.org/api/events.html#events_emitter_off_eventname_listener
	**/
	function off<T:Function>(event:Event<T>, listener:T):IEventEmitter;

	/**
		Adds the `listener` function to the end of the listeners array for the
		event named `eventName`. No checks are made to see if the `listener` has
		already been added. Multiple calls passing the same combination of `eventName`
		and `listener` will result in the `listener` being added, and called, multiple
		times.

		@see https://nodejs.org/api/events.html#events_emitter_on_eventname_listener
	**/
	function on<T:Function>(event:Event<T>, listener:T):IEventEmitter;

	/**
		Adds a one-time `listener` function for the event named `eventName`. The
		next time `eventName` is triggered, this listener is removed and then invoked.

		@see https://nodejs.org/api/events.html#events_emitter_once_eventname_listener
	**/
	function once<T:Function>(event:Event<T>, listener:T):IEventEmitter;

	/**
		Adds the `listener` function to the beginning of the listeners array for the
		event named `eventName`. No checks are made to see if the `listener` has
		already been added. Multiple calls passing the same combination of `eventName`
		and `listener` will result in the `listener` being added, and called, multiple
		times.

		@see https://nodejs.org/api/events.html#events_emitter_prependlistener_eventname_listener
	**/
	function prependListener<T:Function>(event:Event<T>, listener:T):IEventEmitter;

	/**
		Adds a one-time `listener` function for the event named `eventName` to the
		beginning of the listeners array. The next time `eventName` is triggered, this
		listener is removed, and then invoked.

		@see https://nodejs.org/api/events.html#events_emitter_prependoncelistener_eventname_listener
	**/
	function prependOnceListener<T:Function>(event:Event<T>, listener:T):IEventEmitter;

	/**
		Removes all listeners, or those of the specified `eventName`.

		@see https://nodejs.org/api/events.html#events_emitter_removealllisteners_eventname
	**/
	function removeAllListeners<T:Function>(?event:Event<T>):IEventEmitter;

	/**
		Removes the specified `listener` from the listener array for the event named
		`eventName`.

		@see https://nodejs.org/api/events.html#events_emitter_removelistener_eventname_listener
	**/
	function removeListener<T:Function>(event:Event<T>, listener:T):IEventEmitter;

	/**
		By default `EventEmitter`s will print a warning if more than `10` listeners are
		added for a particular event. This is a useful default that helps finding
		memory leaks. Obviously, not all events should be limited to just 10 listeners.
		The `emitter.setMaxListeners()` method allows the limit to be modified for this
		specific `EventEmitter` instance. The value can be set to `Infinity` (or `0`)
		to indicate an unlimited number of listeners.

		@see https://nodejs.org/api/events.html#events_emitter_setmaxlisteners_n
	**/
	function setMaxListeners(n:Int):Void;

	/**
		Returns a copy of the array of listeners for the event named `eventName`,
		including any wrappers (such as those created by `.once()`).

		@see https://nodejs.org/api/events.html#events_emitter_rawlisteners_eventname
	**/
	function rawListeners<T:Function>(eventName:Event<T>):Void;
}
