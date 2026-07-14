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

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.extern.Rest;
import js.lib.Promise;
import js.lib.Symbol;
import js.node.events.EventEmitter;
import js.node.web.AbortSignal;
import js.node.web.EventTarget;

/**
	Much of the Node.js core API is built around an idiomatic asynchronous event-driven architecture
	in which certain kinds of objects (called "emitters") emit named events that cause `Function` objects
	("listeners") to be called.

	@see https://nodejs.org/api/events.html
**/
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
		If this value is not a positive number, a `RangeError` is thrown.

		@see https://nodejs.org/api/events.html#eventsdefaultmaxlisteners
	**/
	static var defaultMaxListeners:Int;

	/**
		Creates a `Promise` that is fulfilled when the emitter emits the given
		event or that is rejected if an `EventEmitter` emits `'error'` while waiting.
		The `Promise` will resolve with an array of all the arguments emitted to the
		given event.

		Works with both `EventEmitter` and web `EventTarget` instances.

		@see https://nodejs.org/api/events.html#eventsonceemitter-name-options
	**/
	@:overload(function(emitter:EventTarget, name:String, options:EventsOnceOptions):Promise<Array<Any>> {})
	@:overload(function(emitter:EventTarget, name:String):Promise<Array<Any>> {})
	@:overload(function<T:Function>(emitter:IEventEmitter, name:Event<T>, options:EventsOnceOptions):Promise<Array<Any>> {})
	static function once<T:Function>(emitter:IEventEmitter, name:Event<T>):Promise<Array<Any>>;

	/**
		Returns an async iterator that iterates `eventName` events emitted by the `emitter`.

		@see https://nodejs.org/api/events.html#eventsonemitter-eventname-options
	**/
	@:overload(function<T:Function>(emitter:IEventEmitter, eventName:Event<T>, options:EventsOnOptions):EventsAsyncIterator {})
	static function on<T:Function>(emitter:IEventEmitter, eventName:Event<T>):EventsAsyncIterator;

	/**
		Listens once to the `abort` event on the provided `signal`.

		Returns a disposable that removes the abort listener when `[Symbol.dispose]()` is called.
		Stable since Node.js 24.

		@see https://nodejs.org/api/events.html#eventsaddabortlistenersignal-listener
	**/
	static function addAbortListener(signal:AbortSignal, listener:Function):EventsDisposable;

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
		If none are specified, `n` is set as the default max for all newly created instances.

		@see https://nodejs.org/api/events.html#eventssetmaxlistenersn-eventtargets
	**/
	static function setMaxListeners(n:Int, emitters:Rest<EitherType<IEventEmitter, EventTarget>>):Void;

	/**
		Returns the currently set max amount of listeners for the given emitter or target.

		@see https://nodejs.org/api/events.html#eventsgetmaxlistenersemitterortarget
	**/
	static function getMaxListeners(emitter:EitherType<IEventEmitter, EventTarget>):Int;

	/**
		Returns the number of listeners for the given `eventName` registered on the
		given emitter or target.

		For `EventTarget`s this is the only way to obtain the listener count
		(accepted since Node.js 24.14.0; deprecation revoked).

		@see https://nodejs.org/api/events.html#eventslistenercountemitterortarget-eventname
	**/
	@:overload(function(emitter:EventTarget, eventName:EitherType<String, Symbol>):Int {})
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
		being buffered is higher than it. Default: `Number.MAX_SAFE_INTEGER`.
		Supported only on emitters implementing `pause()` and `resume()`.
	**/
	@:optional var highWaterMark:Int;

	/**
		The low watermark. The emitter is resumed every time the size of events
		being buffered is lower than it. Default: `1`.
		Supported only on emitters implementing `pause()` and `resume()`.
	**/
	@:optional var lowWaterMark:Int;
}

/**
	Minimal async iterator surface used by `Events.on` (for `for await...of`).
**/
typedef EventsAsyncIterator = {
	function next():Promise<{done:Bool, ?value:Array<Any>}>;
}

/**
	Disposable returned by `Events.addAbortListener`.

	Call `[Symbol.dispose]()` (Node.js maps this to `Symbol.for('nodejs.dispose')`)
	to remove the abort listener. There is no named `dispose()` method.
**/
typedef EventsDisposable = {}
