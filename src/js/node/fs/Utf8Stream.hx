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

import haxe.extern.EitherType;
import js.lib.Error;
import js.node.Buffer;
import js.node.Fs.FsMode;
import js.node.Fs.FsPath;
import js.node.events.EventEmitter;
import js.node.events.EventEmitter.Event;

/**
	An optimized UTF-8 stream writer with on-demand flushing.

	Stability: 1 - Experimental (added in Node.js v24.6.0).

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#class-fsutf8stream
**/
@:jsRequire("fs", "Utf8Stream")
extern class Utf8Stream extends EventEmitter<Utf8Stream> {
	/**
		Whether the stream is appending to the file or truncating it.
	**/
	final append:Bool;

	/**
		The type of data that can be written: `'utf8'` or `'buffer'`.
	**/
	final contentMode:String;

	/**
		The file descriptor being written to.
	**/
	final fd:Null<Int>;

	/**
		The file being written to.
	**/
	final file:Null<FsPath>;

	/**
		Whether `fs.fsyncSync()` is performed after every write.
	**/
	final fsync:Bool;

	/**
		Maximum length of the internal buffer.
	**/
	final maxLength:Null<Int>;

	/**
		Minimum length of the internal buffer required before flushing.
	**/
	final minLength:Null<Int>;

	/**
		Whether the stream ensures the destination directory exists.
	**/
	final mkdir:Bool;

	/**
		Mode of the file being written to.
	**/
	final mode:Null<FsMode>;

	/**
		Milliseconds between periodic flushes (`0` disables).
	**/
	final periodicFlush:Int;

	/**
		Whether the stream writes synchronously.
	**/
	final sync:Bool;

	/**
		Whether the stream is currently writing.
	**/
	final writing:Bool;

	function new(?options:Utf8StreamOptions);

	/**
		Close the stream immediately, without flushing the internal buffer.
	**/
	function destroy():Void;

	/**
		Close the stream gracefully, flushing the internal buffer before closing.
	**/
	function end():Void;

	/**
		Writes the current buffer to the file if a write is not already in progress.
	**/
	function flush(callback:(err:Null<Error>) -> Void):Void;

	/**
		Flushes buffered data synchronously.
	**/
	function flushSync():Void;

	/**
		Reopen the file in place (useful for log rotation).
	**/
	function reopen(file:FsPath):Void;

	/**
		Write `data` to the stream.
		Returns `true` if the data was written / buffered successfully.
	**/
	function write(data:EitherType<String, Buffer>):Bool;
}

/**
	Events emitted by `Utf8Stream`.
**/
enum abstract Utf8StreamEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	var Close:Utf8StreamEvent<() -> Void> = "close";
	var Drain:Utf8StreamEvent<() -> Void> = "drain";

	/**
		Emitted when `maxLength` is reached and data is dropped.
	**/
	var Drop:Utf8StreamEvent<(data:EitherType<String, Buffer>) -> Void> = "drop";

	var Error:Utf8StreamEvent<(err:Error) -> Void> = "error";
	var Finish:Utf8StreamEvent<() -> Void> = "finish";
	var Ready:Utf8StreamEvent<() -> Void> = "ready";

	/**
		Emitted when a write completes; argument is the number of bytes written.
	**/
	var Write:Utf8StreamEvent<(bytesWritten:Int) -> Void> = "write";
}

/**
	Options for `new Utf8Stream()`.
**/
typedef Utf8StreamOptions = {
	/**
		Append writes instead of truncating.
		Default: `true`.
	**/
	@:optional var append:Bool;

	/**
		`'utf8'` or `'buffer'`.
		Default: `'utf8'`.
	**/
	@:optional var contentMode:String;

	/**
		Destination file path.
	**/
	@:optional var dest:FsPath;

	/**
		Existing file descriptor.
	**/
	@:optional var fd:Int;

	/**
		Custom `fs` implementation for mocking / testing.
	**/
	// TODO: type as structural fs subset once practical
	@:optional var fs:Dynamic;

	/**
		Perform `fsyncSync` after every write.
	**/
	@:optional var fsync:Bool;

	/**
		Maximum internal buffer length; excess writes emit `drop`.
	**/
	@:optional var maxLength:Int;

	/**
		Maximum bytes per write.
		Default: `16384`.
	**/
	@:optional var maxWrite:Int;

	/**
		Minimum buffer length required before flushing.
	**/
	@:optional var minLength:Int;

	/**
		Ensure directory for `dest` exists.
		Default: `false`.
	**/
	@:optional var mkdir:Bool;

	/**
		File mode when creating.
	**/
	@:optional var mode:FsMode;

	/**
		Call flush every `periodicFlush` milliseconds.
	**/
	@:optional var periodicFlush:Int;

	/**
		Called on `EAGAIN` / `EBUSY`; return `true` to retry.
	**/
	@:optional var retryEAGAIN:(err:Null<Error>, writeBufferLen:Int, remainingBufferLen:Int) -> Bool;

	/**
		Perform writes synchronously.
	**/
	@:optional var sync:Bool;
}
