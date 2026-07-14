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

package js.node.inspector;

import js.lib.Error;
import js.node.events.EventEmitter;

/**
	Enumeration of events emitted by `inspector.Session`.

	Arbitrary Chrome DevTools Protocol notification method names can also be used
	as event names (e.g. `'Runtime.consoleAPICalled'`).
**/
enum abstract SessionEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when any notification from the V8 Inspector is received.
	**/
	var InspectorNotification:SessionEvent<(message:InspectorNotificationMessage) -> Void> = "inspectorNotification";

	/**
		Emitted when an inspector notification is received with method `Debugger.paused`.
	**/
	var DebuggerPaused:SessionEvent<(message:InspectorNotificationMessage) -> Void> = "Debugger.paused";

	/**
		Emitted when an inspector notification is received with method `Debugger.resumed`.
	**/
	var DebuggerResumed:SessionEvent<(message:InspectorNotificationMessage) -> Void> = "Debugger.resumed";

	/**
		Emitted when an inspector notification is received with method `HeapProfiler.addHeapSnapshotChunk`.
	**/
	var HeapProfilerAddHeapSnapshotChunk:SessionEvent<(message:InspectorNotificationMessage) -> Void> = "HeapProfiler.addHeapSnapshotChunk";
}

/**
	A notification message object received from the V8 inspector.

	`params` shape depends on the Chrome DevTools Protocol method; kept pragmatic here.
**/
typedef InspectorNotificationMessage = {
	var method:String;
	@:optional var params:Dynamic;
}

/**
	The `inspector.Session` is used for dispatching messages to the V8 inspector
	back-end and receiving message responses and notifications.

	When using `Session`, objects outputted by the console API will not be released
	unless `Runtime.DiscardConsoleEntries` is posted manually.

	@see https://nodejs.org/docs/latest-v24.x/api/inspector.html#class-inspectorsession
**/
@:jsRequire("inspector", "Session")
extern class Session extends EventEmitter<Session> {
	/**
		Create a new instance of the `inspector.Session` class.
		The inspector session needs to be connected through `session.connect()`
		before the messages can be dispatched to the inspector backend.
	**/
	function new();

	/**
		Connects a session to the inspector back-end.
	**/
	function connect():Void;

	/**
		Connects a session to the main thread inspector back-end.
		An exception will be thrown if this API was not called on a Worker thread.
	**/
	function connectToMainThread():Void;

	/**
		Immediately close the session. All pending message callbacks will be called with an error.
		`session.connect()` will need to be called to be able to send messages again.
		Reconnected session will lose all inspector state, such as enabled agents or configured breakpoints.
	**/
	function disconnect():Void;

	/**
		Posts a message to the inspector back-end.

		`callback` will be notified when a response is received.
		`callback` is a function that accepts two optional arguments: error and message-specific result.

		Protocol method names and parameter/result shapes follow the Chrome DevTools Protocol;
		they are typed as `String` / `Dynamic` rather than enumerating the full CDP schema.
	**/
	@:overload(function(method:String, ?callback:(error:Null<Error>, result:Dynamic) -> Void):Void {})
	function post(method:String, ?params:Dynamic, ?callback:(error:Null<Error>, result:Dynamic) -> Void):Void;
}
