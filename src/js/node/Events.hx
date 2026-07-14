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

package js.node;

import haxe.Constraints.Function;
import haxe.extern.Rest;
import js.lib.Promise;
import js.lib.Symbol;
import js.node.events.EventEmitter;
import js.node.web.AbortSignal;

/**
	Much of the Node.js core API is built around an idiomatic asynchronous event-driven architecture
	in which certain kinds of objects (called "emitters") emit named events that cause `Function` objects
	("listeners") to be called.

	@see https://nodejs.org/api/events.html#events_events
 */
@:jsRequire("events")
extern class Events {
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
		By default, a maximum of `10` listeners can be registered for any single event.
		This alias mirrors `EventEmitter.defaultMaxListeners`.

		@see https://nodejs.org/api/events.html#eventsdefaultmaxlisteners
	**/
	static var defaultMaxListeners:Int;

	/**
		Creates a `Promise` that is fulfilled when the `EventEmitter` emits the given
		event or that is rejected if the `EventEmitter` emits `'error'` while waiting.
		The `Promise` will resolve with an array of all the arguments emitted to the
		given event.

		@see https://nodejs.org/api/events.html#eventsonceemitter-name-options
	**/
	@:overload(function<T:Function>(emitter:IEventEmitter, name:Event<T>, options:EventsOnceOptions):Promise<Array<Dynamic>> {})
	static function once<T:Function>(emitter:IEventEmitter, name:Event<T>):Promise<Array<Dynamic>>;

	/**
		Returns an `AsyncIterator` that iterates `eventName` events emitted by the `emitter`.

		@see https://nodejs.org/api/events.html#eventsonemitter-eventname-options
	**/
	@:overload(function<T:Function>(emitter:IEventEmitter, eventName:Event<T>, options:EventsOnOptions):EventsAsyncIterator {})
	static function on<T:Function>(emitter:IEventEmitter, eventName:Event<T>):EventsAsyncIterator;

	/**
		Listens once to the `abort` event on the provided `signal`.

		Returns a disposable that removes the abort listener when disposed.

		@see https://nodejs.org/api/events.html#eventsaddabortlistenersignal-listener
	**/
	static function addAbortListener(signal:AbortSignal, listener:Function):EventsDisposable;

	/**
		Returns a copy of the array of listeners for the event named `name`.

		@see https://nodejs.org/api/events.html#eventsgeteventlistenersemitter-name
	**/
	static function getEventListeners(emitter:IEventEmitter, name:Event<Function>):Array<Function>;

	/**
		Change the default `maxListeners` value for all `EventEmitter` instances,
		and optionally apply that change to the given emitters.

		@see https://nodejs.org/api/events.html#eventssetmaxlistenersn-eventtargets
	**/
	static function setMaxListeners(n:Int, emitters:Rest<IEventEmitter>):Void;

	/**
		Returns the currently set max amount of listeners for the given emitter.

		@see https://nodejs.org/api/events.html#eventsgetmaxlistenersemitterortarget
	**/
	static function getMaxListeners(emitter:IEventEmitter):Int;

	/**
		Returns the number of listeners for the given `eventName` registered on the
		given `emitter`.

		@see https://nodejs.org/api/events.html#eventslistenercountemitterortarget-eventname
	**/
	static function listenerCount(emitter:IEventEmitter, eventName:Event<Function>):Int;
}

/**
	Options for `Events.once`.
**/
typedef EventsOnceOptions = {
	/**
		An `AbortSignal` that can be used to cancel waiting for the event.
	**/
	@:optional var signal:AbortSignal;
}

/**
	Options for `Events.on`.
**/
typedef EventsOnOptions = {
	/**
		Can be used to cancel awaiting events.
	**/
	@:optional var signal:AbortSignal;

	/**
		Names of events that will end the iteration.
	**/
	@:optional var close:Array<String>;

	/**
		The high watermark. The emitter is paused every time the size of events
		being buffered is higher than it.
	**/
	@:optional var highWaterMark:Int;

	/**
		The low watermark. The emitter is resumed every time the size of events
		being buffered is lower than it.
	**/
	@:optional var lowWaterMark:Int;
}

/**
	Minimal async iterator surface used by `Events.on` (for `for await...of`).
**/
typedef EventsAsyncIterator = {
	function next():Promise<{done:Bool, ?value:Array<Dynamic>}>;
}

/**
	Disposable returned by `Events.addAbortListener`.
**/
typedef EventsDisposable = {
	function dispose():Void;
}
