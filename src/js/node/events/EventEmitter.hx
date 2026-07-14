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

package js.node.events;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;
import js.lib.Symbol;
import js.node.async_hooks.AsyncResource;
import js.node.web.EventTarget;

/**
	Enumeration of events emitted by all `EventEmitter` instances.
**/
enum abstract EventEmitterEvent<T:Function>(Event<T>) to Event<T> {
	/**
		The `EventEmitter` instance will emit its own `'newListener'` event before
		a listener is added to its internal array of listeners.

		@see https://nodejs.org/api/events.html#event-newlistener
	**/
	var NewListener:EventEmitterEvent<(eventName:EitherType<String, Symbol>, listener:Function) -> Void> = "newListener";

	/**
		The `'removeListener'` event is emitted after the `listener` is removed.

		@see https://nodejs.org/api/events.html#event-removelistener
	**/
	var RemoveListener:EventEmitterEvent<(eventName:EitherType<String, Symbol>, listener:Function) -> Void> = "removeListener";
}

/**
	The `EventEmitter` class is defined and exposed by the `events` module:

	@see https://nodejs.org/api/events.html#class-eventemitter
**/
@:jsRequire("events", "EventEmitter")
extern class EventEmitter<TSelf:EventEmitter<TSelf>> implements IEventEmitter {
	function new(?options:EventEmitterOptions);

	/**
		By default, a maximum of `10` listeners can be registered for any single
		event. This limit can be changed for individual `EventEmitter` instances
		using the `emitter.setMaxListeners(n)` method. To change the default
		for all `EventEmitter` instances, the `EventEmitter.defaultMaxListeners`
		property can be used. If this value is not a positive number, a `RangeError`
		will be thrown.

		@see https://nodejs.org/api/events.html#eventsdefaultmaxlisteners
	**/
	static var defaultMaxListeners:Int;

	/**
		This symbol shall be used to install a listener for only monitoring `'error'`
		events. Listeners installed using this symbol are called before the regular
		`'error'` listeners are called.

		@see https://nodejs.org/api/events.html#eventserrormonitor
	**/
	static final errorMonitor:Symbol;

	/**
		Value: `Symbol.for('nodejs.rejection')`

		@see https://nodejs.org/api/events.html#eventscapturerejectionsymbol
	**/
	static final captureRejectionSymbol:Symbol;

	/**
		Change the default `captureRejections` option on all new `EventEmitter` objects.

		@see https://nodejs.org/api/events.html#eventscapturerejections
	**/
	static var captureRejections:Bool;

	/**
		Returns a copy of the array of listeners for the event named `name`.

		For `EventTarget`s this is the only way to get the event listeners for the event target.

		@see https://nodejs.org/api/events.html#eventsgeteventlistenersemitterortarget-eventname
	**/
	@:overload(function(emitter:EventTarget, name:EitherType<String, Symbol>):Array<Function> {})
	static function getEventListeners(emitter:IEventEmitter, name:Event<Function>):Array<Function>;

	/**
		Change the default `maxListeners` value for all `EventEmitter` / `EventTarget` instances,
		and optionally apply that change to the given emitters or targets.

		@see https://nodejs.org/api/events.html#eventssetmaxlistenersn-eventtargets
	**/
	static function setMaxListeners(n:Int, emitters:Rest<EitherType<IEventEmitter, EventTarget>>):Void;

	/**
		Returns the currently set max amount of listeners for the given emitter or target.

		@see https://nodejs.org/api/events.html#eventsgetmaxlistenersemitterortarget
	**/
	static function getMaxListeners(emitter:EitherType<IEventEmitter, EventTarget>):Int;

	/**
		A class method that returns the number of listeners for the given `eventName`
		registered on the given emitter or target.

		@see https://nodejs.org/api/events.html#eventslistenercountemitterortarget-eventname
	**/
	@:overload(function(emitter:EventTarget, eventName:EitherType<String, Symbol>):Int {})
	static function listenerCount(emitter:IEventEmitter, eventName:Event<Function>):Int;

	/**
		Alias for `emitter.on(eventName, listener)`.

		@see https://nodejs.org/api/events.html#emitteraddlistenereventname-listener
	**/
	function addListener<T:Function>(eventName:Event<T>, listener:T):TSelf;

	/**
		Synchronously calls each of the listeners registered for the event named
		`eventName`, in the order they were registered, passing the supplied arguments
		to each.

		@see https://nodejs.org/api/events.html#emitteremiteventname-args
	**/
	function emit<T:Function>(eventName:Event<T>, args:Rest<Any>):Bool;

	/**
		Returns an array listing the events for which the emitter has registered
		listeners. The values in the array will be strings or `Symbol`s.

		@see https://nodejs.org/api/events.html#emittereventnames
	**/
	function eventNames():Array<EitherType<String, Symbol>>;

	/**
		Returns the current max listener value for the `EventEmitter` which is either
		set by `emitter.setMaxListeners(n)` or defaults to
		`EventEmitter.defaultMaxListeners`.

		@see https://nodejs.org/api/events.html#emittergetmaxlisteners
	**/
	function getMaxListeners():Int;

	/**
		Returns the number of listeners listening for the event named `eventName`.
		If `listener` is provided, it will return how many times the listener is
		found in the list of the listeners of the event.

		@see https://nodejs.org/api/events.html#emitterlistenercounteventname-listener
	**/
	@:overload(function<T:Function>(eventName:Event<T>, listener:T):Int {})
	function listenerCount<T:Function>(eventName:Event<T>):Int;

	/**
		Returns a copy of the array of listeners for the event named `eventName`.

		@see https://nodejs.org/api/events.html#emitterlistenerseventname
	**/
	function listeners<T:Function>(eventName:Event<T>):Array<T>;

	/**
		Alias for `emitter.removeListener()`.

		@see https://nodejs.org/api/events.html#emitteroffeventname-listener
	**/
	function off<T:Function>(eventName:Event<T>, listener:T):TSelf;

	/**
		Adds the `listener` function to the end of the listeners array for the
		event named `eventName`. No checks are made to see if the `listener` has
		already been added. Multiple calls passing the same combination of `eventName`
		and `listener` will result in the `listener` being added, and called, multiple
		times.

		@see https://nodejs.org/api/events.html#emitteroneventname-listener
	**/
	function on<T:Function>(eventName:Event<T>, listener:T):TSelf;

	/**
		Adds a one-time `listener` function for the event named `eventName`. The
		next time `eventName` is triggered, this listener is removed and then invoked.

		@see https://nodejs.org/api/events.html#emitteronceeventname-listener
	**/
	function once<T:Function>(eventName:Event<T>, listener:T):TSelf;

	/**
		Adds the `listener` function to the beginning of the listeners array for the
		event named `eventName`. No checks are made to see if the `listener` has
		already been added. Multiple calls passing the same combination of `eventName`
		and `listener` will result in the `listener` being added, and called, multiple
		times.

		@see https://nodejs.org/api/events.html#emitterprependlistenereventname-listener
	**/
	function prependListener<T:Function>(eventName:Event<T>, listener:T):TSelf;

	/**
		Adds a one-time `listener` function for the event named `eventName` to the
		beginning of the listeners array. The next time `eventName` is triggered, this
		listener is removed, and then invoked.

		@see https://nodejs.org/api/events.html#emitterprependoncelistenereventname-listener
	**/
	function prependOnceListener<T:Function>(eventName:Event<T>, listener:T):TSelf;

	/**
		Removes all listeners, or those of the specified `eventName`.

		@see https://nodejs.org/api/events.html#emitterremovealllistenerseventname
	**/
	function removeAllListeners<T:Function>(?eventName:Event<T>):TSelf;

	/**
		Removes the specified `listener` from the listener array for the event named
		`eventName`.

		@see https://nodejs.org/api/events.html#emitterremovelistenereventname-listener
	**/
	function removeListener<T:Function>(eventName:Event<T>, listener:T):TSelf;

	/**
		By default `EventEmitter`s will print a warning if more than `10` listeners are
		added for a particular event. This is a useful default that helps finding
		memory leaks. Obviously, not all events should be limited to just 10 listeners.
		The `emitter.setMaxListeners()` method allows the limit to be modified for this
		specific `EventEmitter` instance. The value can be set to `Infinity` (or `0`)
		to indicate an unlimited number of listeners.

		@see https://nodejs.org/api/events.html#emittersetmaxlistenersn
	**/
	function setMaxListeners(n:Int):TSelf;

	/**
		Returns a copy of the array of listeners for the event named `eventName`,
		including any wrappers (such as those created by `.once()`).

		@see https://nodejs.org/api/events.html#emitterrawlistenerseventname
	**/
	function rawListeners<T:Function>(eventName:Event<T>):Array<T>;
}

/**
	`EventEmitter` constructor options.
**/
typedef EventEmitterOptions = {
	/**
		Enables automatic capturing of promise rejection. Default: `false`.
	**/
	@:optional var captureRejections:Bool;
}

/**
	Integrates `EventEmitter` with `AsyncResource` for `EventEmitter`s that
	require manual async tracking.

	@see https://nodejs.org/api/events.html#class-eventemitterasyncresource
**/
@:jsRequire("events", "EventEmitterAsyncResource")
extern class EventEmitterAsyncResource extends EventEmitter<EventEmitterAsyncResource> {
	function new(?options:EventEmitterAsyncResourceOptions);

	/**
		Call all `destroy` hooks. This should only ever be called once. An error will
		be thrown if it is called more than once. This must be manually called. If
		the resource is left to be collected by the GC then the `destroy` hooks will
		never be called.
	**/
	function emitDestroy():Void;

	/**
		The unique `asyncId` assigned to the resource.
	**/
	var asyncId(default, null):Float;

	/**
		The same `triggerAsyncId` that is passed to the `AsyncResource` constructor.
	**/
	var triggerAsyncId(default, null):Float;

	/**
		The underlying `AsyncResource`.

		The returned object has an additional `eventEmitter` property that references
		this `EventEmitterAsyncResource`.
	**/
	var asyncResource(default, null):AsyncResource;
}

/**
	Options for `EventEmitterAsyncResource`.
**/
typedef EventEmitterAsyncResourceOptions = {
	> EventEmitterOptions,

	/**
		The type of async event.
		Default: `new.target.name` if instantiated using `new`, else `'EventEmitterAsyncResource'`.
	**/
	@:optional var name:String;

	/**
		The ID of the execution context that created this async event.
		Default: `executionAsyncId()`.
	**/
	@:optional var triggerAsyncId:Float;

	/**
		Disables automatic `emitDestroy` when the object is garbage collected.
		Default: `false`.
	**/
	@:optional var requireManualDestroy:Bool;
}

/**
	`IEventEmitter` interface is used as "any EventEmitter".

	See `EventEmitter` for actual class documentation.
**/
@:remove
extern interface IEventEmitter {
	function addListener<T:Function>(eventName:Event<T>, listener:T):IEventEmitter;

	function emit<T:Function>(eventName:Event<T>, args:Rest<Any>):Bool;

	function eventNames():Array<EitherType<String, Symbol>>;

	function getMaxListeners():Int;

	@:overload(function<T:Function>(eventName:Event<T>, listener:T):Int {})
	function listenerCount<T:Function>(eventName:Event<T>):Int;

	function listeners<T:Function>(eventName:Event<T>):Array<T>;

	function off<T:Function>(eventName:Event<T>, listener:T):IEventEmitter;

	function on<T:Function>(eventName:Event<T>, listener:T):IEventEmitter;

	function once<T:Function>(eventName:Event<T>, listener:T):IEventEmitter;

	function prependListener<T:Function>(eventName:Event<T>, listener:T):IEventEmitter;

	function prependOnceListener<T:Function>(eventName:Event<T>, listener:T):IEventEmitter;

	function removeAllListeners<T:Function>(?eventName:Event<T>):IEventEmitter;

	function removeListener<T:Function>(eventName:Event<T>, listener:T):IEventEmitter;

	function setMaxListeners(n:Int):IEventEmitter;

	function rawListeners<T:Function>(eventName:Event<T>):Array<T>;
}

/**
	Abstract type for events. Its type parameter is a signature
	of a listener for a concrete event.
**/
abstract Event<T:Function>(Dynamic) from String to String from Symbol to Symbol {}
