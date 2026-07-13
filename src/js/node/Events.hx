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
import js.node.events.EventEmitter;
#if haxe4
import js.lib.Promise;
import js.lib.Symbol;
#else
import js.Promise;
#end

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
	#if haxe4
	static final errorMonitor:Symbol;
	#else
	static var errorMonitor(default, never):Dynamic;
	#end

	/**
		Value: `Symbol.for('nodejs.rejection')`

		@see https://nodejs.org/api/events.html#eventscapturerejectionsymbol
	**/
	#if haxe4
	static final captureRejectionSymbol:Symbol;
	#else
	static var captureRejectionSymbol(default, never):Dynamic;
	#end

	/**
		Creates a `Promise` that is resolved when the `EventEmitter` emits the given
		event or that is rejected when the `EventEmitter` emits `'error'`.
		The `Promise` will resolve with an array of all the arguments emitted to the
		given event.

		@see https://nodejs.org/api/events.html#events_events_once_emitter_name
	**/
	static function once<T:Function>(emitter:IEventEmitter, name:Event<T>):Promise<Array<Dynamic>>;

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
