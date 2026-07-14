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

package js.node.fs;

import js.node.Fs.FsPath;
import js.node.events.EventEmitter;
import js.lib.Error;

/**
	Enumeration of possible types of changes for 'change' event.
**/
enum abstract FSWatcherChangeType(String) from String to String {
	var Change = "change";
	var Rename = "rename";
}

/**
	Enumeration of the events emitted by `FSWatcher`.
**/
enum abstract FSWatcherEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when something changes in a watched directory or file. See more details in `Fs.watch`.

		Listener arguments:
			event - The type of fs change
			filename - The filename that changed (if relevant/available)
	**/
	var Change:FSWatcherEvent<(eventType:FSWatcherChangeType, filename:Null<FsPath>) -> Void> = "change";

	/**
		Emitted when an error occurs.
	**/
	var Error:FSWatcherEvent<(err:Error) -> Void> = "error";
}

/**
	Objects returned from `Fs.watch`.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#class-fswatcher
**/
extern class FSWatcher extends EventEmitter<FSWatcher> {
	/**
		Stop watching for changes on the given `FSWatcher`.
	**/
	function close():Void;

	/**
		When called, requests that the Node.js event loop not exit so long as the `FSWatcher` is active.
		Calling `ref()` multiple times has no effect.
	**/
	function ref():FSWatcher;

	/**
		When called, the active `FSWatcher` will not require the Node.js event loop to remain active.
		Calling `unref()` multiple times has no effect.
	**/
	function unref():FSWatcher;
}
