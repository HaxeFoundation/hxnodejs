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
import js.node.Buffer;
import js.node.Fs;
import js.node.events.EventEmitter;
import js.node.events.EventEmitter.Event;
import js.node.readline.Interface;
import js.lib.Promise;

/**
	A `FileHandle` object is a wrapper for a numeric file descriptor.

	Instances are created by `FsPromises.open()`.
	Not a public export of `fs/promises` (`require("fs/promises").FileHandle` is undefined),
	so this is a plain extern like `Stats` / `ReadStream`.

	`Symbol.asyncDispose` (await using) is intentionally deferred.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#class-filehandle
**/
extern class FileHandle extends EventEmitter<FileHandle> {
	/**
		The numeric file descriptor managed by this `FileHandle`.
	**/
	final fd:Int;

	/**
		Alias of `writeFile()`.
		Asynchronously append data to a file, creating the file if it does not exist.
	**/
	@:overload(function(data:EitherType<String, Buffer>):Promise<Void> {})
	function appendFile(data:EitherType<String, Buffer>, options:EitherType<String, FsWriteFileOptions>):Promise<Void>;

	/**
		Modifies the permissions on the file. See chmod(2).
	**/
	function chmod(mode:FsMode):Promise<Void>;

	/**
		Changes the ownership of the file. See chown(2).
	**/
	function chown(uid:Int, gid:Int):Promise<Void>;

	/**
		Closes the file handle after waiting for any pending operation on the handle to complete.
	**/
	function close():Promise<Void>;

	/**
		Unlike `createReadStream` on the `fs` module, this reads sequentially from the current file position.
	**/
	function createReadStream(?options:FsCreateReadStreamOptions):ReadStream;

	/**
		Creates a write stream associated with this file handle.
	**/
	function createWriteStream(?options:FsCreateWriteStreamOptions):WriteStream;

	/**
		Forces all currently queued I/O operations associated with the file to the
		operating system's synchronized I/O completion state. See fdatasync(2).
	**/
	function datasync():Promise<Void>;

	/**
		Reads data from the file and stores that in the given buffer.
	**/
	@:overload(function(?options:FileHandleReadOptions):Promise<FileHandleReadResult> {})
	@:overload(function(buffer:Buffer, ?options:FileHandleReadOptions):Promise<FileHandleReadResult> {})
	function read(buffer:Buffer, offset:Int, length:Int, position:Null<EitherType<Int, Float>>):Promise<FileHandleReadResult>;

	/**
		Asynchronously reads the entire contents of a file.
		If no encoding is specified, the data is returned as a `Buffer`.
	**/
	@:overload(function():Promise<Buffer> {})
	@:overload(function(options:EitherType<String, {encoding:String}>):Promise<String> {})
	function readFile(?options:{?encoding:String}):Promise<EitherType<String, Buffer>>;

	/**
		Convenience method to create a `readline` interface and stream over the file.
	**/
	function readLines(?options:FsCreateReadStreamOptions):Interface;

	/**
		Returns a byte-oriented `ReadableStream` for the file contents.
	**/
	function readableWebStream(?options:FileHandleReadableWebStreamOptions):js.node.web.ReadableStream;

	/**
		Read from a file and write to an array of buffers.
	**/
	@:overload(function(buffers:Array<FsVectorBuffer>):Promise<FileHandleReadvResult> {})
	function readv(buffers:Array<FsVectorBuffer>, position:Null<Int>):Promise<FileHandleReadvResult>;

	/**
		Retrieves `fs.Stats` for the file.

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#filehandlestatoptions
	**/
	@:overload(function():Promise<Stats> {})
	function stat(options:js.node.Fs.FsStatOptions):Promise<Stats>;

	/**
		Request that all data for the open file descriptor is flushed to the storage device.
		See fsync(2).
	**/
	function sync():Promise<Void>;

	/**
		Truncates the file.
		If `len` is negative then `0` will be used.
	**/
	@:overload(function():Promise<Void> {})
	function truncate(len:Int):Promise<Void>;

	/**
		Change the file system timestamps of the object referenced by this `FileHandle`.
	**/
	function utimes(atime:EitherType<Date, EitherType<Float, String>>,
		mtime:EitherType<Date, EitherType<Float, String>>):Promise<Void>;

	/**
		Write `buffer` / `string` to the file.
	**/
	@:overload(function(buffer:Buffer, ?options:FileHandleWriteOptions):Promise<FileHandleWriteResult> {})
	@:overload(function(string:String, ?position:Null<Int>, ?encoding:String):Promise<FileHandleWriteResult> {})
	function write(buffer:Buffer, offset:Int, ?length:Int, ?position:Null<Int>):Promise<FileHandleWriteResult>;

	/**
		Asynchronously writes data to a file, replacing the file if it already exists.
	**/
	@:overload(function(data:EitherType<String, Buffer>):Promise<Void> {})
	function writeFile(data:EitherType<String, Buffer>, options:EitherType<String, FsWriteFileOptions>):Promise<Void>;

	/**
		Write an array of buffers to the file.
	**/
	@:overload(function(buffers:Array<FsVectorBuffer>):Promise<FileHandleWritevResult> {})
	function writev(buffers:Array<FsVectorBuffer>, position:Null<Int>):Promise<FileHandleWritevResult>;
}

/**
	Events emitted by `FileHandle`.
**/
enum abstract FileHandleEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when the `FileHandle` has been closed and can no longer be used.
	**/
	var Close:FileHandleEvent<() -> Void> = "close";
}

/**
	Options for `FileHandle.readableWebStream`.
**/
typedef FileHandleReadableWebStreamOptions = {
	/**
		When `true`, closes the `FileHandle` when the stream is closed.
		Default: `false`.
	**/
	@:optional var autoClose:Bool;

	/**
		AbortSignal to abort an in-progress readable web stream.
	**/
	@:optional var signal:js.node.web.AbortSignal;
}

/**
	Options for `FileHandle.read`.
**/
typedef FileHandleReadOptions = {
	/**
		A buffer that will be filled with the file data read.
		Default: `Buffer.alloc(16384)`.
	**/
	@:optional var buffer:Buffer;

	/**
		The location in the buffer at which to start filling.
		Default: `0`.
	**/
	@:optional var offset:Int;

	/**
		The number of bytes to read.
		Default: `buffer.byteLength - offset`.
	**/
	@:optional var length:Int;

	/**
		The location where to begin reading data from the file.
		If `null` or `-1`, data will be read from the current file position.
		Default: `null`.
	**/
	@:optional var position:Null<EitherType<Int, Float>>;
}

/**
	Result of `FileHandle.read`.
**/
typedef FileHandleReadResult = {
	var bytesRead:Int;
	var buffer:Buffer;
}

/**
	Result of `FileHandle.readv`.
**/
typedef FileHandleReadvResult = {
	var bytesRead:Int;
	var buffers:Array<FsVectorBuffer>;
}

/**
	Options for `FileHandle.write` (buffer form).
**/
typedef FileHandleWriteOptions = {
	/**
		The start position from within `buffer` where the data to write begins.
		Default: `0`.
	**/
	@:optional var offset:Int;

	/**
		The number of bytes from `buffer` to write.
		Default: `buffer.byteLength - offset`.
	**/
	@:optional var length:Int;

	/**
		The offset from the beginning of the file where the data should be written.
		Default: `null` (write at current position).
	**/
	@:optional var position:Null<Int>;
}

/**
	Result of `FileHandle.write`.
**/
typedef FileHandleWriteResult = {
	var bytesWritten:Int;
	var buffer:EitherType<String, Buffer>;
}

/**
	Result of `FileHandle.writev`.
**/
typedef FileHandleWritevResult = {
	var bytesWritten:Int;
	var buffers:Array<FsVectorBuffer>;
}
