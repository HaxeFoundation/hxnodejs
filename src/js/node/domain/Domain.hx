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

package js.node.domain;

import haxe.Constraints.Function;
import haxe.extern.Rest;
import js.node.events.EventEmitter;

/**
	Enumeration of events emitted by `Domain` objects.

	Stability: 0 - Deprecated. Prefer `AsyncLocalStorage` / `async_hooks`.

	Note: the former `'dispose'` event was removed with `Domain.dispose()` (DEP0012, End-of-Life in Node.js v9.0.0).
**/
@:deprecated("The domain module is deprecated. Use AsyncLocalStorage / async_hooks instead.")
enum abstract DomainEvent<T:Function>(Event<T>) to Event<T> {
	/**
		Emitted when an error is routed to this domain.
	**/
	var Error:DomainEvent<DomainError->Void> = "error";
}

/**
	Extra fields added to an `Error` when it is routed through a domain.

	These properties are set on the error object itself (typically a `js.lib.Error`).
**/
@:deprecated("The domain module is deprecated. Use AsyncLocalStorage / async_hooks instead.")
typedef DomainError = {
	/**
		The domain that first handled the error.
	**/
	var domain:Domain;

	/**
		The event emitter that emitted an `'error'` event with the error object.
	**/
	var domainEmitter:IEventEmitter;

	/**
		The callback function which was bound to the domain, and passed an error as its first argument.
	**/
	var domainBound:Function;

	/**
		A boolean indicating whether the error was thrown, emitted, or passed to a bound callback function.
	**/
	var domainThrown:Bool;
}

/**
	The `Domain` class encapsulates the functionality of routing errors
	and uncaught exceptions to the active `Domain` object.

	Listen to its `'error'` event to handle caught errors.

	Stability: 0 - Deprecated. Prefer `AsyncLocalStorage` / `async_hooks`.

	@see https://nodejs.org/docs/latest-v24.x/api/domain.html#class-domain
**/
@:deprecated("The domain module is deprecated. Use AsyncLocalStorage / async_hooks instead.")
extern class Domain extends EventEmitter<Domain> {
	/**
		Run the supplied function in the context of the domain, implicitly binding all event emitters, timers,
		and low-level requests that are created in that context.

		Optionally, arguments can be passed to the function.

		This is the most basic way to use a domain.

		@see https://nodejs.org/docs/latest-v24.x/api/domain.html#domainrunfn-args
	**/
	function run(fn:Function, args:Rest<Dynamic>):Dynamic;

	/**
		An array of event emitters that have been explicitly added to the domain.

		@see https://nodejs.org/docs/latest-v24.x/api/domain.html#domainmembers
	**/
	var members(default, null):Array<IEventEmitter>;

	/**
		Explicitly adds an `emitter` to the domain.

		If any event handlers called by the emitter throw an error, or if the emitter emits an `'error'` event,
		it will be routed to the domain's `'error'` event, just like with implicit binding.

		If the `EventEmitter` was already bound to a domain, it is removed from that one,
		and bound to this one instead.

		As of Node.js 9.3.0, this method no longer accepts timer objects.

		@see https://nodejs.org/docs/latest-v24.x/api/domain.html#domainaddemitter
	**/
	function add(emitter:IEventEmitter):Void;

	/**
		The opposite of `add`. Removes domain handling from the specified emitter.

		@see https://nodejs.org/docs/latest-v24.x/api/domain.html#domainremoveemitter
	**/
	function remove(emitter:IEventEmitter):Void;

	/**
		The returned function will be a wrapper around the supplied `callback` function.
		When the returned function is called, any errors that are thrown will be routed to the domain's `'error'` event.

		@see https://nodejs.org/docs/latest-v24.x/api/domain.html#domainbindcallback
	**/
	function bind<T:Function>(callback:T):T;

	/**
		This method is almost identical to `bind`. However, in addition to catching thrown errors, it will also
		intercept `Error` objects sent as the first argument to the function.

		In this way, the common `if (err != null) return callback(err);` pattern
		can be replaced with a single error handler in a single place.

		@see https://nodejs.org/docs/latest-v24.x/api/domain.html#domaininterceptcallback
	**/
	function intercept<T:Function>(callback:T):T;

	/**
		The `enter` method is plumbing used by the `run`, `bind`, and `intercept` methods to set the active domain.

		It sets `domain.active` and `process.domain` to the domain, and implicitly pushes the domain onto
		the domain stack managed by the domain module (see `exit` for details on the domain stack).

		The call to `enter` delimits the beginning of a chain of asynchronous calls and I/O operations bound to a domain.

		Calling `enter` changes only the active domain, and does not alter the domain itself.
		`enter` and `exit` can be called an arbitrary number of times on a single domain.

		@see https://nodejs.org/docs/latest-v24.x/api/domain.html#domainenter
	**/
	function enter():Void;

	/**
		The `exit` method exits the current domain, popping it off the domain stack.

		Any time execution is going to switch to the context of a different chain of asynchronous calls,
		it's important to ensure that the current domain is exited. The call to `exit` delimits either the end of
		or an interruption to the chain of asynchronous calls and I/O operations bound to a domain.

		If there are multiple, nested domains bound to the current execution context,
		`exit` will exit any domains nested within this domain.

		Calling `exit` changes only the active domain, and does not alter the domain itself.
		`enter` and `exit` can be called an arbitrary number of times on a single domain.

		@see https://nodejs.org/docs/latest-v24.x/api/domain.html#domainexit
	**/
	function exit():Void;
}
