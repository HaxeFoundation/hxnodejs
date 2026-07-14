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

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.Buffer;
import js.node.fs.Dir;
import js.node.fs.Dirent;
import js.node.fs.FSWatcher;
import js.node.fs.ReadStream;
import js.node.fs.Stats;
import js.node.fs.StatsFs;
import js.node.fs.StatWatcher;
import js.node.fs.WriteStream;
import js.lib.Error;
import js.lib.Promise;
import js.node.web.Blob;
import js.node.url.URL;

/**
	Path argument accepted by most `fs` methods: a string path, `Buffer`, or WHATWG `URL`
	with the `file:` protocol.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#file-paths
**/
typedef FsPath = EitherType<String, EitherType<Buffer, URL>>;

/**
	Options for `Fs.watchFile`.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fswatchfilefilename-options-listener
**/
typedef FsWatchFileOptions = {
	/**
		Whether the process should continue to run as long as files are being watched.
		Default: `true`.
	**/
	@:optional var persistent:Bool;

	/**
		How often the target should be polled, in milliseconds.
		Default: `5007`.
	**/
	@:optional var interval:Int;
}

/**
	The `mode` argument used by `Fs.open` and related functions
	can be either an integer or a string with octal number.
**/
typedef FsMode = EitherType<Int, String>;

/**
	Options for `Fs.writeFile` / `Fs.appendFile` and their promise / `FileHandle` counterparts.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fswritefilefile-data-options-callback
**/
typedef FsWriteFileOptions = {
	/**
		Encoding for writing strings.
		Default: `'utf8'`.
		Ignored if data is a buffer.
	**/
	@:optional var encoding:String;

	/**
		File mode. Default: `0o666`.
	**/
	@:optional var mode:FsMode;

	/**
		File system flag.
		Default: `'w'` for `writeFile`, `'a'` for `appendFile`.
	**/
	@:optional var flag:FsOpenFlag;

	/**
		If `true`, the underlying file descriptor is flushed prior to closing it.
		Default: `false`.
	**/
	@:optional var flush:Bool;

	/**
		AbortSignal to abort an in-progress write.
	**/
	@:optional var signal:js.node.web.AbortSignal;
}

/**
	Options for `Fs.createReadStream` / `FileHandle.createReadStream`.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fscreatereadstreampath-options
**/
typedef FsCreateReadStreamOptions = {
	/**
		Default: `'r'`.
	**/
	@:optional var flags:FsOpenFlag;

	/**
		Character encoding. Default: `null`.
	**/
	@:optional var encoding:String;

	/**
		If specified, ignores `path` and uses the given file descriptor instead.
	**/
	@:optional var fd:Int;

	/**
		Default: `0o666`.
	**/
	@:optional var mode:FsMode;

	/**
		If `false`, the file descriptor is not closed on error or end.
		Default: `true`.
	**/
	@:optional var autoClose:Bool;

	/**
		If `false`, the stream will not emit `'close'` after it has been destroyed.
		Default: `true`.
	**/
	@:optional var emitClose:Bool;

	/**
		Start of the inclusive byte range to read.
	**/
	@:optional var start:Int;

	/**
		End of the inclusive byte range to read.
	**/
	@:optional var end:Int;

	/**
		Default: `64 * 1024`.
	**/
	@:optional var highWaterMark:Int;

	/**
		AbortSignal to abort an in-progress read stream.
	**/
	@:optional var signal:js.node.web.AbortSignal;
}

/**
	Options for `Fs.createWriteStream` / `FileHandle.createWriteStream`.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fscreatewritestreampath-options
**/
typedef FsCreateWriteStreamOptions = {
	/**
		Default: `'w'`.
	**/
	@:optional var flags:FsOpenFlag;

	/**
		Default: `'utf8'`.
	**/
	@:optional var encoding:String;

	/**
		If specified, ignores `path` and uses the given file descriptor instead.
	**/
	@:optional var fd:Int;

	/**
		Default: `0o666`.
	**/
	@:optional var mode:FsMode;

	/**
		If `false`, the file descriptor is not closed on error or finish.
		Default: `true`.
	**/
	@:optional var autoClose:Bool;

	/**
		If `false`, the stream will not emit `'close'` after it has been destroyed.
		Default: `true`.
	**/
	@:optional var emitClose:Bool;

	/**
		Start position for writing data past the beginning of the file.
	**/
	@:optional var start:Int;

	/**
		When `true`, flushes the underlying file descriptor synchronously after each write.
		Default: `false`.
	**/
	@:optional var flush:Bool;
}

/**
	Enumeration of possible symlink types
**/
enum abstract SymlinkType(String) from String to String {
	var Dir = "dir";
	var File = "file";
	var Junction = "junction";
}

/**
	Options for `Fs.stat` / `Fs.lstat` / `Fs.fstat` and their sync / promise counterparts.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fsstatpath-options-callback
**/
typedef FsStatOptions = {
	/**
		Whether the numeric values in the returned `Stats` object should be `bigint`.
		Default: `false`.
	**/
	@:optional var bigint:Bool;

	/**
		Whether an exception is thrown if no file system entry exists (sync API).
		Default: `true`.
	**/
	@:optional var throwIfNoEntry:Bool;

	/**
		AbortSignal to cancel the operation (async / promises / `FileHandle.stat`; Node.js 24+).
	**/
	@:optional var signal:js.node.web.AbortSignal;
}

/**
	Options for `Fs.watch`.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fswatchfilename-options-listener
**/
typedef FsWatchOptions = {
	/**
		Whether the process should continue to run as long as files are being watched.
		Default: `true`.
	**/
	@:optional var persistent:Bool;

	/**
		Watch subdirectories recursively (platform-dependent).
		Default: `false`.
	**/
	@:optional var recursive:Bool;

	/**
		Character encoding for the filename passed to the listener.
		Default: `'utf8'`.
	**/
	@:optional var encoding:String;

	/**
		AbortSignal that closes the returned `FSWatcher` when aborted.
	**/
	@:optional var signal:js.node.web.AbortSignal;

	/**
		Whether an exception should be thrown when the path does not exist.
		Default: `true`.
	**/
	@:optional var throwIfNoEntry:Bool;
}

/**
	Enumeration of possible flags for opening file.

	The exclusive flag 'x' (O_EXCL flag in open(2)) ensures that path is newly created.
	On POSIX systems, path is considered to exist even if it is a symlink to a non-existent file.
	The exclusive flag may or may not work with network file systems.

	On Linux, positional writes don't work when the file is opened in append mode.
	The kernel ignores the position argument and always appends the data to the end of the file.
**/
enum abstract FsOpenFlag(String) from String to String {
	/**
		Open file for reading.
		An exception occurs if the file does not exist.
	**/
	var Read = "r";

	/**
		Open file for reading and writing.
		An exception occurs if the file does not exist.
	**/
	var ReadWrite = "r+";

	/**
		Open file for reading in synchronous mode. Instructs the operating system to bypass the local file system cache.

		This is primarily useful for opening files on NFS mounts as it allows you to skip the potentially stale local cache.
		It has a very real impact on I/O performance so don't use this flag unless you need it.

		Note that this doesn't turn `Fs.open` into a synchronous blocking call.
		If that's what you want then you should be using `Fs.openSync`
	**/
	var ReadSync = "rs";

	/**
		Open file for reading and writing, telling the OS to open it synchronously.
		See notes for `ReadSync` about using this with caution.
	**/
	var ReadWriteSync = "rs+";

	/**
		Open file for writing.
		The file is created (if it does not exist) or truncated (if it exists).
	**/
	var WriteCreate = "w";

	/**
		Like `WriteCreate` but fails if path exists.
	**/
	var WriteCheck = "wx";

	/**
		Open file for reading and writing.
		The file is created (if it does not exist) or truncated (if it exists).
	**/
	var WriteReadCreate = "w+";

	/**
		Like `WriteReadCreate` but fails if path exists.
	**/
	var WriteReadCheck = "wx+";

	/**
		Open file for appending.
		The file is created if it does not exist.
	**/
	var AppendCreate = "a";

	/**
		Like `AppendCreate` but fails if path exists.
	**/
	var AppendCheck = "ax";

	/**
		Open file for reading and appending.
		The file is created if it does not exist.
	 */
	var AppendReadCreate = "a+";

	/**
		Like `AppendReadCreate` but fails if path exists.
	**/
	var AppendReadCheck = "ax+";
}

/**
	Constants for use in `Fs` module.

	Note: Not every constant will be available on every operating system.
**/
typedef FsConstants = {
	/**
		Flag indicating that the file is visible to the calling process.
		Meant for use with `Fs.access`.
	**/
	var F_OK:Int;

	/**
		Flag indicating that the file can be read by the calling process.
		Meant for use with `Fs.access`.
	**/
	var R_OK:Int;

	/**
		Flag indicating that the file can be written by the calling process.
		Meant for use with `Fs.access`.
	**/
	var W_OK:Int;

	/**
		Flag indicating that the file can be executed by the calling process.
		Meant for use with `Fs.access`.
	**/
	var X_OK:Int;

	/**
		Flag indicating to open a file for read-only access.
	**/
	var O_RDONLY:Int;

	/**
		Flag indicating to open a file for write-only access.
	**/
	var O_WRONLY:Int;

	/**
		Flag indicating to open a file for read-write access.
	**/
	var O_RDWR:Int;

	/**
		Flag indicating to create the file if it does not already exist.
	**/
	var O_CREAT:Int;

	/**
		Flag indicating that opening a file should fail if the O_CREAT flag is set and the file already exists.
	**/
	var O_EXCL:Int;

	/**
		Flag indicating that if path identifies a terminal device, opening the path shall not cause that terminal to become the controlling terminal for the process (if the process does not already have one).
	**/
	var O_NOCTTY:Int;

	/**
		Flag indicating that if the file exists and is a regular file, and the file is opened successfully for write access, its length shall be truncated to zero.
	**/
	var O_TRUNC:Int;

	/**
		Flag indicating that data will be appended to the end of the file.
	**/
	var O_APPEND:Int;

	/**
		Flag indicating that the open should fail if the path is not a directory.
	**/
	var O_DIRECTORY:Int;

	/**
		Flag indicating reading accesses to the file system will no longer result in an update to the atime information associated with the file. This flag is available on Linux operating systems only.
	**/
	var O_NOATIME:Int;

	/**
		Flag indicating that the open should fail if the path is a symbolic link.
	**/
	var O_NOFOLLOW:Int;

	/**
		Flag indicating that the file is opened for synchronous I/O.
	**/
	var O_SYNC:Int;

	/**
		Flag indicating to open the symbolic link itself rather than the resource it is pointing to.
	**/
	var O_SYMLINK:Int;

	/**
		When set, an attempt will be made to minimize caching effects of file I/O.
	**/
	var O_DIRECT:Int;

	/**
		Flag indicating to open the file in nonblocking mode when possible.
	**/
	var O_NONBLOCK:Int;

	/**
		Bit mask used to extract the file type code.
	**/
	var S_IFMT:Int;

	/**
		File type constant for a regular file.
	**/
	var S_IFREG:Int;

	/**
		File type constant for a directory.
	**/
	var S_IFDIR:Int;

	/**
		File type constant for a character-oriented device file.
	**/
	var S_IFCHR:Int;

	/**
		File type constant for a block-oriented device file.
	**/
	var S_IFBLK:Int;

	/**
		File type constant for a FIFO/pipe.
	**/
	var S_IFIFO:Int;

	/**
		File type constant for a symbolic link.
	**/
	var S_IFLNK:Int;

	/**
		File type constant for a socket.
	**/
	var S_IFSOCK:Int;

	/**
		File mode indicating readable, writable and executable by owner.
	**/
	var S_IRWXU:Int;

	/**
		File mode indicating readable by owner.
	**/
	var S_IRUSR:Int;

	/**
		File mode indicating writable by owner.
	**/
	var S_IWUSR:Int;

	/**
		File mode indicating executable by owner.
	**/
	var S_IXUSR:Int;

	/**
		File mode indicating readable, writable and executable by group.
	**/
	var S_IRWXG:Int;

	/**
		File mode indicating readable by group.
	**/
	var S_IRGRP:Int;

	/**
		File mode indicating writable by group.
	**/
	var S_IWGRP:Int;

	/**
		File mode indicating executable by group.
	**/
	var S_IXGRP:Int;

	/**
		File mode indicating readable, writable and executable by others.
	**/
	var S_IRWXO:Int;

	/**
		File mode indicating readable by others.
	**/
	var S_IROTH:Int;

	/**
		File mode indicating writable by others.
	**/
	var S_IWOTH:Int;

	/**
		File mode indicating executable by others.
	**/
	var S_IXOTH:Int;

	/**
		Constant for `Fs.copyFile`.
		If present, the copy operation will fail with an error if the destination path already exists.
	**/
	var COPYFILE_EXCL:Int;

	/**
		Constant for `Fs.copyFile`.
		If present, the copy operation will attempt to create a copy-on-write reflink.
		If the underlying platform does not support copy-on-write, then a fallback copy mechanism is used.
	**/
	var COPYFILE_FICLONE:Int;

	/**
		Constant for `Fs.copyFile`.
		If present, the copy operation will attempt to create a copy-on-write reflink.
		If the underlying platform does not support copy-on-write, then the operation will fail with an error.
	**/
	var COPYFILE_FICLONE_FORCE:Int;
}

/**
	Options for `Fs.rmdir` and `Fs.rmdirSync`.
**/
typedef FsRmdirOptions = {
	/**
		If an `EBUSY`, `EMFILE`, `ENFILE`, `ENOTEMPTY`, or `EPERM` error is encountered,
		Node.js will retry the operation with a linear backoff wait of `retryDelay` ms longer on each try.
		This option represents the number of retries.
		This option is ignored if the `recursive` option is not `true`.
	**/
	@:optional var maxRetries:Int;

	/**
		If `true`, perform a recursive directory removal.
		In recursive mode, errors are not reported if `path` does not exist,
		and operations are retried on failure.
	**/
	@:optional var recursive:Bool;

	/**
		The amount of time in milliseconds to wait between retries.
		This option is ignored if the `recursive` option is not `true`.
	**/
	@:optional var retryDelay:Int;
}

/**
	Options for `Fs.rm` and `Fs.rmSync`.
**/
typedef FsRmOptions = {
	/**
		When `true`, exceptions will be ignored if `path` does not exist.
		Default: `false`.
	**/
	@:optional var force:Bool;

	/**
		If an `EBUSY`, `EMFILE`, `ENFILE`, `ENOTEMPTY`, or `EPERM` error is encountered,
		Node.js will retry the operation with a linear backoff wait of `retryDelay` ms longer on each try.
		This option represents the number of retries.
		This option is ignored if the `recursive` option is not `true`.
		Default: `0`.
	**/
	@:optional var maxRetries:Int;

	/**
		If `true`, perform a recursive removal.
		In recursive mode, operations are retried on failure.
		Default: `false`.
	**/
	@:optional var recursive:Bool;

	/**
		The amount of time in milliseconds to wait between retries.
		This option is ignored if the `recursive` option is not `true`.
		Default: `100`.
	**/
	@:optional var retryDelay:Int;
}

/**
	Options for `Fs.cp` and `Fs.cpSync`.
**/
typedef FsCpOptions = {
	/**
		Dereference symlinks.
		Default: `false`.
	**/
	@:optional var dereference:Bool;

	/**
		When `force` is `false`, and the destination exists, throw an error.
		Default: `false`.
	**/
	@:optional var errorOnExist:Bool;

	/**
		Function to filter copied files/directories.
		Return `true` to copy the item, `false` to ignore it.
		When ignoring a directory, all of its contents will be skipped as well.
	**/
	@:optional var filter:(src:String, dest:String) -> Bool;

	/**
		Overwrite existing file or directory.
		The copy operation will ignore errors if you set this to `false` and the destination exists.
		Use the `errorOnExist` option to change this behavior.
		Default: `true`.
	**/
	@:optional var force:Bool;

	/**
		Modifiers for copy operation.
		Default: `0`.
		See `mode` flag of `Fs.copyFile`.
	**/
	@:optional var mode:Int;

	/**
		When `true`, timestamps from `src` will be preserved.
		Default: `false`.
	**/
	@:optional var preserveTimestamps:Bool;

	/**
		Copy directories recursively.
		Default: `false`.
	**/
	@:optional var recursive:Bool;

	/**
		When `true`, path resolution for symlinks will be skipped.
		Default: `false`.
	**/
	@:optional var verbatimSymlinks:Bool;
}

/**
	Options for `Fs.opendir` and `Fs.opendirSync`.
**/
typedef FsOpendirOptions = {
	/**
		Encoding for the path while opening the directory and subsequent read operations.
		Default: `'utf8'`.
	**/
	@:optional var encoding:String;

	/**
		Number of directory entries that are buffered internally when reading from the directory.
		Higher values lead to better performance but higher memory usage.
		Default: `32`.
	**/
	@:optional var bufferSize:Int;

	/**
		When `true`, reads the directory recursively.
		Default: `false`.
	**/
	@:optional var recursive:Bool;
}

/**
	Options for `Fs.glob` and `Fs.globSync`.
**/
typedef FsGlobOptions = {
	/**
		Current working directory.
		Default: `process.cwd()`.
	**/
	@:optional var cwd:EitherType<String, URL>;

	/**
		Function to filter out files/directories, or a list of glob patterns to be excluded.
		If a function is provided, return `true` to exclude the item, `false` to include it.
	**/
	@:optional var exclude:EitherType<(path:String) -> Bool, Array<String>>;

	/**
		When `true`, symbolic links to directories are followed while expanding `**` patterns.
		Default: `false`.
	**/
	@:optional var followSymlinks:Bool;

	/**
		`true` if the glob should return paths as `Dirent`s, `false` otherwise.
		Default: `false`.
	**/
	@:optional var withFileTypes:Bool;
}

/**
	Disposable temporary directory returned by `Fs.mkdtempDisposableSync`.
**/
typedef FsMkdtempDisposable = {
	/**
		The path of the created directory.
	**/
	var path:String;

	/**
		Removes the created directory and its contents.
		Same as the `[Symbol.dispose]` method on the returned object.
	**/
	function remove():Void;
}

/**
	Options for `Fs.openAsBlob`.
**/
typedef FsOpenAsBlobOptions = {
	/**
		An optional MIME type for the blob.
	**/
	@:optional var type:String;
}

/**
	A buffer for `Fs.readv` / `Fs.writev`.

	Node.js accepts an `ArrayBufferView` (Buffer, TypedArray, or DataView).
	This library follows the existing `Fs.read` / `Fs.write` convention of typing these as `Buffer`.
**/
typedef FsVectorBuffer = Buffer;

/**
	File I/O wrappers around POSIX functions (`node:fs`).
	Most methods have asynchronous (callback), synchronous, and promise-based forms
	(see `FsPromises` / `Fs.promises`).

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html
**/
@:jsRequire("fs")
extern class Fs {
	/**
		Commonly used constants for file system operations.
	**/
	static final constants:FsConstants;

	/**
		Promise-based file system methods (`require('fs').promises`).
		Same module object as `js.node.FsPromises`.

		Prefer calling static methods on `FsPromises` for Haxe typing of overloads.
	**/
	// TODO: value type mirroring FsPromises static surface (static-method extern cannot be reused as value type)
	static final promises:Dynamic;

	/**
		Asynchronous rename(2).
	**/
	static function rename(oldPath:FsPath, newPath:FsPath, callback:(err:Error) -> Void):Void;

	/**
		Synchronous rename(2).
	**/
	static function renameSync(oldPath:FsPath, newPath:FsPath):Void;

	/**
		Asynchronously copies `src` to `dest`.
		By default, `dest` is overwritten if it already exists.

		No arguments other than a possible exception are given to the callback function.

		`mode` is an optional integer that specifies the behavior of the copy operation.
		It is possible to create a mask consisting of the bitwise OR of two or more values
		(e.g. `Fs.constants.COPYFILE_EXCL | Fs.constants.COPYFILE_FICLONE`).
	**/
	@:overload(function(src:FsPath, dest:FsPath, callback:(err:Error) -> Void):Void {})
	static function copyFile(src:FsPath, dest:FsPath, mode:Int, callback:(err:Error) -> Void):Void;

	/**
		Synchronously copies `src` to `dest`.
		By default, `dest` is overwritten if it already exists.

		`mode` is an optional integer that specifies the behavior of the copy operation.
		See `copyFile` for details.
	**/
	@:overload(function(src:FsPath, dest:FsPath):Void {})
	static function copyFileSync(src:FsPath, dest:FsPath, mode:Int):Void;

	/**
		Asynchronously copies the entire directory structure from `src` to `dest`,
		including subdirectories and files.

		When copying a directory to another directory, globs are not supported and
		behavior is similar to `cp dir1/ dir2/`.
	**/
	@:overload(function(src:FsPath, dest:FsPath, callback:(err:Error) -> Void):Void {})
	static function cp(src:FsPath, dest:FsPath, options:FsCpOptions, callback:(err:Error) -> Void):Void;

	/**
		Synchronously copies the entire directory structure from `src` to `dest`,
		including subdirectories and files.
	**/
	static function cpSync(src:FsPath, dest:FsPath, ?options:FsCpOptions):Void;

	/**
		Asynchronous ftruncate(2).
	**/
	static function ftruncate(fd:Int, len:Int, callback:(err:Error) -> Void):Void;

	/**
		Synchronous ftruncate(2).
	**/
	static function ftruncateSync(fd:Int, len:Int):Void;

	/**
		Asynchronous truncate(2).
	**/
	static function truncate(path:FsPath, len:Int, callback:(err:Error) -> Void):Void;

	/**
		Synchronous truncate(2).
	**/
	static function truncateSync(path:FsPath, len:Int):Void;

	/**
		Asynchronous chown(2).
	**/
	static function chown(path:FsPath, uid:Int, gid:Int, callback:(err:Error) -> Void):Void;

	/**
		Synchronous chown(2).
	**/
	static function chownSync(path:FsPath, uid:Int, gid:Int):Void;

	/**
		Asynchronous fchown(2).
	**/
	static function fchown(fd:Int, uid:Int, gid:Int, callback:(err:Error) -> Void):Void;

	/**
		Synchronous fchown(2).
	**/
	static function fchownSync(fd:Int, uid:Int, gid:Int):Void;

	/**
		Asynchronous lchown(2).
	**/
	static function lchown(path:FsPath, uid:Int, gid:Int, callback:(err:Error) -> Void):Void;

	/**
		Synchronous lchown(2).
	**/
	static function lchownSync(path:FsPath, uid:Int, gid:Int):Void;

	/**
		Asynchronous chmod(2).
	**/
	static function chmod(path:FsPath, mode:FsMode, callback:(err:Error) -> Void):Void;

	/**
		Synchronous chmod(2).
	**/
	static function chmodSync(path:FsPath, mode:FsMode):Void;

	/**
		Asynchronous fchmod(2).
	**/
	static function fchmod(fd:Int, mode:FsMode, callback:(err:Error) -> Void):Void;

	/**
		Synchronous fchmod(2).
	**/
	static function fchmodSync(fd:Int, mode:FsMode):Void;

	/**
		Asynchronous lchmod(2).
		Only available on Mac OS X.
	**/
	static function lchmod(path:FsPath, mode:FsMode, callback:(err:Error) -> Void):Void;

	/**
		Synchronous lchmod(2).
	**/
	static function lchmodSync(path:FsPath, mode:FsMode):Void;

	/**
		Asynchronous stat(2).

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fsstatpath-options-callback
	**/
	@:overload(function(path:FsPath, options:FsStatOptions, callback:(err:Error, stats:Stats) -> Void):Void {})
	static function stat(path:FsPath, callback:(err:Error, stats:Stats) -> Void):Void;

	/**
		Asynchronous lstat(2) — like `stat`, but does not follow symbolic links.

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fslstatpath-options-callback
	**/
	@:overload(function(path:FsPath, options:FsStatOptions, callback:(err:Error, stats:Stats) -> Void):Void {})
	static function lstat(path:FsPath, callback:(err:Error, stats:Stats) -> Void):Void;

	/**
		Asynchronous fstat(2) — like `stat`, for an open file descriptor.

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fsfstatfd-options-callback
	**/
	@:overload(function(fd:Int, options:FsStatOptions, callback:(err:Error, stats:Stats) -> Void):Void {})
	static function fstat(fd:Int, callback:(err:Error, stats:Stats) -> Void):Void;

	/**
		Synchronous stat(2).
	**/
	@:overload(function(path:FsPath, options:FsStatOptions):Null<Stats> {})
	static function statSync(path:FsPath):Stats;

	/**
		Synchronous lstat(2).
	**/
	@:overload(function(path:FsPath, options:FsStatOptions):Null<Stats> {})
	static function lstatSync(path:FsPath):Stats;

	/**
		Synchronous fstat(2).
	**/
	@:overload(function(fd:Int, options:FsStatOptions):Stats {})
	static function fstatSync(fd:Int):Stats;

	/**
		Asynchronous statfs(2).
		Returns information about the mounted file system which contains `path`.

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fsstatfspath-options-callback
	**/
	@:overload(function(path:FsPath, options:{?bigint:Bool}, callback:(err:Error, stats:StatsFs) -> Void):Void {})
	static function statfs(path:FsPath, callback:(err:Error, stats:StatsFs) -> Void):Void;

	/**
		Synchronous statfs(2).
	**/
	@:overload(function(path:FsPath, options:{?bigint:Bool}):StatsFs {})
	static function statfsSync(path:FsPath):StatsFs;

	/**
		Asynchronous link(2).
	**/
	static function link(srcpath:FsPath, dstpath:FsPath, callback:(err:Error) -> Void):Void;

	/**
		Synchronous link(2).
	**/
	static function linkSync(srcpath:FsPath, dstpath:FsPath):Void;

	/**
		Asynchronous symlink(2).

		The `type` argument can be set to 'dir', 'file', or 'junction' (default is 'file')
		and is only available on Windows (ignored on other platforms). Note that Windows junction
		points require the destination path to be absolute. When using 'junction', the destination
		argument will automatically be normalized to absolute path.
	**/
	@:overload(function(srcpath:FsPath, dstpath:FsPath, callback:(err:Error) -> Void):Void {})
	static function symlink(srcpath:FsPath, dstpath:FsPath, type:SymlinkType, callback:(err:Error) -> Void):Void;

	/**
		Synchronous symlink(2).
	**/
	@:overload(function(srcpath:FsPath, dstpath:FsPath):Void {})
	static function symlinkSync(srcpath:FsPath, dstpath:FsPath, type:SymlinkType):Void;

	/**
		Asynchronous readlink(2).
	**/
	static function readlink(path:FsPath, callback:(err:Error, result:String) -> Void):Void;

	/**
		Synchronous readlink(2).
		Returns the symbolic link's string value.
	**/
	static function readlinkSync(path:FsPath):String;

	/**
		Asynchronous realpath(2).

		The callback gets two arguments `(err, resolvedPath)`.

		May use `process.cwd` to resolve relative paths.

		`cache` is an object literal of mapped paths that can be used to force a specific path resolution
		or avoid additional `stat` calls for known real paths.

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fsrealpathpath-options-callback
	**/
	@:overload(function(path:FsPath, callback:(err:Error, result:String) -> Void):Void {})
	static function realpath(path:FsPath, cache:DynamicAccess<String>, callback:(err:Error, result:String) -> Void):Void;

	/**
		Asynchronous realpath(3) using the native binding (`fs.realpath.native`).

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fsrealpathnativepath-options-callback
	**/
	@:native("realpath.native")
	@:overload(function(path:FsPath, options:EitherType<String, {?encoding:String}>,
		callback:(err:Error, result:EitherType<String, Buffer>) -> Void):Void {})
	static function realpathNative(path:FsPath, callback:(err:Error, result:String) -> Void):Void;

	/**
		Synchronous realpath(2).
		Returns the resolved path.
	**/
	@:overload(function(path:FsPath):String {})
	static function realpathSync(path:FsPath, cache:DynamicAccess<String>):String;

	/**
		Synchronous realpath(3) using the native binding (`fs.realpathSync.native`).

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fsrealpathsyncnativepath-options
	**/
	@:native("realpathSync.native")
	@:overload(function(path:FsPath, options:EitherType<String, {?encoding:String}>):EitherType<String, Buffer> {})
	static function realpathSyncNative(path:FsPath):String;

	/**
		Asynchronous unlink(2).
	**/
	static function unlink(path:FsPath, callback:(err:Error) -> Void):Void;

	/**
		Synchronous unlink(2).
	**/
	static function unlinkSync(path:FsPath):Void;

	/**
		Asynchronously removes files and directories (modeled on the standard POSIX `rm` utility).

		No arguments other than a possible exception are given to the completion callback.

		To get a behavior similar to the `rm -rf` Unix command, use `Fs.rm` with options
		`{ recursive: true, force: true }`.
	**/
	@:overload(function(path:FsPath, callback:(err:Error) -> Void):Void {})
	static function rm(path:FsPath, options:FsRmOptions, callback:(err:Error) -> Void):Void;

	/**
		Synchronously removes files and directories (modeled on the standard POSIX `rm` utility).
	**/
	static function rmSync(path:FsPath, ?options:FsRmOptions):Void;

	/**
		Asynchronous rmdir(2).
	**/
	@:overload(function(path:FsPath, callback:(err:Error) -> Void):Void {})
	static function rmdir(path:FsPath, options:FsRmdirOptions, callback:(err:Error) -> Void):Void;

	/**
		Synchronous rmdir(2).
	**/
	static function rmdirSync(path:FsPath, ?options:FsRmdirOptions):Void;

	/**
		Asynchronous mkdir(2).

		When `options.recursive` is `true`, the callback may receive the first directory path created.

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fsmkdirpath-options-callback
	**/
	@:overload(function(path:FsPath, callback:(err:Error, ?path:String) -> Void):Void {})
	@:overload(function(path:FsPath, mode:FsMode, callback:(err:Error, ?path:String) -> Void):Void {})
	static function mkdir(path:FsPath, options:{?recursive:Bool, ?mode:FsMode}, callback:(err:Error, ?path:String) -> Void):Void;

	/**
		Synchronous mkdir(2).

		When `options.recursive` is `true`, returns the first directory path created, if any.
	**/
	@:overload(function(path:FsPath, ?mode:FsMode):Null<String> {})
	static function mkdirSync(path:FsPath, ?options:{?recursive:Bool, ?mode:FsMode}):Null<String>;

	/**
		Creates a unique temporary directory.

		Generates six random characters to be appended behind a required `prefix` to create a unique temporary directory.

		The created folder path is passed as a string to the `callback`'s second parameter.
	**/
	@:overload(function(prefix:String, options:EitherType<String, {?encoding:String}>, callback:(err:Error, result:String) -> Void):Void {})
	static function mkdtemp(prefix:String, callback:(err:Error, result:String) -> Void):Void;

	/**
		The synchronous version of `mkdtemp`.

		Returns the created folder path.
	**/
	@:overload(function(prefix:String, options:EitherType<String, {?encoding:String}>):String {})
	static function mkdtempSync(prefix:String):String;

	/**
		Synchronously creates a unique temporary directory and returns a disposable object.

		When the object is disposed (or `remove` is called), the directory and its contents are removed
		if they still exist.

		@see https://nodejs.org/api/fs.html#fsmkdtempdisposablesyncprefix-options
	**/
	@:overload(function(prefix:String, options:EitherType<String, {?encoding:String}>):FsMkdtempDisposable {})
	static function mkdtempDisposableSync(prefix:String):FsMkdtempDisposable;

	/**
		Asynchronous readdir(3).
		Reads the contents of a directory.

		The callback gets two arguments (err, files) where files is an array of the
		names of the files in the directory excluding '.' and '..'.
	**/
	static function readdir(path:FsPath, callback:(err:Error, files:Array<String>) -> Void):Void;

	/**
		Synchronous readdir(3).
		Returns an array of filenames excluding '.' and '..'.
	**/
	static function readdirSync(path:FsPath):Array<String>;

	/**
		Asynchronously open a directory for iterative scanning.
		See the POSIX opendir(3) documentation for more details.

		Creates a `Dir`, which contains all further functions for reading from
		and cleaning up the directory.

		The `callback` gets two arguments `(err, dir)`.
	**/
	@:overload(function(path:FsPath, callback:(err:Error, dir:Dir) -> Void):Void {})
	static function opendir(path:FsPath, options:FsOpendirOptions, callback:(err:Error, dir:Dir) -> Void):Void;

	/**
		Synchronously open a directory.
		See `opendir` for more details.
	**/
	static function opendirSync(path:FsPath, ?options:FsOpendirOptions):Dir;

	/**
		Retrieves the files matching the specified pattern.

		The `callback` gets two arguments `(err, matches)`.
		When `options.withFileTypes` is `true`, `matches` is an array of `Dirent` objects;
		otherwise it is an array of path strings.
	**/
	@:overload(function(pattern:EitherType<String, Array<String>>, callback:(err:Error, files:Array<String>) -> Void):Void {})
	@:overload(function(pattern:EitherType<String, Array<String>>, options:FsGlobOptions, callback:(err:Error, files:Array<String>) -> Void):Void {})
	static function glob(pattern:EitherType<String, Array<String>>, options:{
		?cwd:EitherType<String, URL>,
		?exclude:EitherType<(path:String) -> Bool, Array<String>>,
		?followSymlinks:Bool,
		withFileTypes:Bool
	}, callback:(err:Error, files:Array<Dirent>) -> Void):Void;

	/**
		Synchronously retrieves the files matching the specified pattern.

		When `options.withFileTypes` is `true`, returns an array of `Dirent` objects;
		otherwise returns an array of path strings.
	**/
	@:overload(function(pattern:EitherType<String, Array<String>>):Array<String> {})
	@:overload(function(pattern:EitherType<String, Array<String>>, options:FsGlobOptions):Array<String> {})
	static function globSync(pattern:EitherType<String, Array<String>>, options:{
		?cwd:EitherType<String, URL>,
		?exclude:EitherType<(path:String) -> Bool, Array<String>>,
		?followSymlinks:Bool,
		withFileTypes:Bool
	}):Array<Dirent>;

	/**
		Asynchronous close(2).
	**/
	static function close(fd:Int, callback:(err:Error) -> Void):Void;

	/**
		Synchronous close(2).
	**/
	static function closeSync(fd:Int):Void;

	/**
		Asynchronous file open. See open(2).

		See `FsOpenFlag` for description of possible `flags`.

		`mode` sets the file mode (permission and sticky bits), but only if the file was created.
		It defaults to 0666, readable and writeable.

		The `callback` gets two arguments (err, fd).
	**/
	@:overload(function(path:FsPath, flags:FsOpenFlag, callback:(err:Error, result:Int) -> Void):Void {})
	static function open(path:FsPath, flags:FsOpenFlag, mode:FsMode, callback:(err:Error, result:Int) -> Void):Void;

	/**
		Synchronous version of open().
	**/
	@:overload(function(path:FsPath, flags:FsOpenFlag):Int {})
	static function openSync(path:FsPath, flags:FsOpenFlag, mode:FsMode):Int;

	/**
		Returns a `Blob` whose data is backed by the given file.

		The file must not be modified after the `Blob` is created.
		Any modifications will cause reading the `Blob` data to fail with a `DOMException` error.

		@see https://nodejs.org/api/fs.html#fsopenasblobpath-options
	**/
	@:overload(function(path:FsPath):Promise<Blob> {})
	static function openAsBlob(path:FsPath, options:FsOpenAsBlobOptions):Promise<Blob>;

	/**
		Change file timestamps of the file referenced by the supplied path.
	**/
	static function utimes(path:FsPath, atime:Date, mtime:Date, callback:(err:Error) -> Void):Void;

	/**
		Change file timestamps of the file referenced by the supplied path.
	**/
	static function utimesSync(path:FsPath, atime:Date, mtime:Date):Void;

	/**
		Change the file timestamps of a file referenced by the supplied file descriptor.
	**/
	static function futimes(fd:Int, atime:Date, mtime:Date, callback:(err:Error) -> Void):Void;

	/**
		Change the file timestamps of a file referenced by the supplied file descriptor.
	**/
	static function futimesSync(fd:Int, atime:Date, mtime:Date):Void;

	/**
		Change the file system timestamps of the symbolic link referenced by `path`.

		Same as `utimes`, except that if the path refers to a symbolic link,
		then the link is not dereferenced: instead, the timestamps of the symbolic link itself are changed.
	**/
	static function lutimes(path:FsPath, atime:Date, mtime:Date, callback:(err:Error) -> Void):Void;

	/**
		Change the file system timestamps of the symbolic link referenced by `path`.
		This is the synchronous version of `lutimes`.
	**/
	static function lutimesSync(path:FsPath, atime:Date, mtime:Date):Void;

	/**
		Asynchronous fsync(2).
	**/
	static function fsync(fd:Int, callback:(err:Error) -> Void):Void;

	/**
		Synchronous fsync(2).
	**/
	static function fsyncSync(fd:Int):Void;

	/**
		Asynchronous fdatasync(2).

		Forces all currently queued I/O operations associated with the file to the
		operating system's synchronized I/O completion state.
		Refer to the POSIX fdatasync(2) documentation for details.

		No arguments other than a possible exception are given to the completion callback.
	**/
	static function fdatasync(fd:Int, callback:(err:Error) -> Void):Void;

	/**
		Synchronous fdatasync(2).
	**/
	static function fdatasyncSync(fd:Int):Void;

	/**
		Documentation for the overloads with the `buffer` argument:

		Write `buffer` to the file specified by `fd`.

		`offset` and `length` determine the part of the `buffer` to be written.

		`position` refers to the offset from the beginning of the file where this data should be written.
		If position is null, the data will be written at the current position. See pwrite(2).

		The `callback` will be given three arguments (err, written, buffer)
		where `written` specifies how many bytes were written from `buffer`.

		---

		Documentation for the overloads with the `data` argument:

		Write `data` to the file specified by `fd`. If `data` is not a `Buffer` instance then
		the value will be coerced to a string.

		`position` refers to the offset from the beginning of the file where this data should be written.
		If omitted, the data will be written at the current position. See pwrite(2).

		`encoding` is the expected string encoding.

		The `callback` will receive the arguments (err, written, string) where written specifies how many bytes
		the passed string required to be written. Note that bytes written is not the same as string characters.
		See `Buffer.byteLength`.

		Unlike when writing `buffer`, the entire string must be written. No substring may be specified.
		This is because the byte offset of the resulting data may not be the same as the string offset.

		---

		Common notes:

		Note that it is unsafe to use `write` multiple times on the same file without waiting for the callback.
		For this scenario, `createWriteStream` is strongly recommended.

		On Linux, positional writes don't work when the file is opened in append mode. The kernel ignores the position
		argument and always appends the data to the end of the file.
	**/
	@:overload(function(fd:Int, data:String, position:Int, encoding:String, callback:(err:Error, written:Int, str:String) -> Void):Void {})
	@:overload(function(fd:Int, data:String, position:Int, callback:(err:Error, written:Int, str:String) -> Void):Void {})
	@:overload(function(fd:Int, data:String, callback:(err:Error, written:Int, str:String) -> Void):Void {})
	@:overload(function(fd:Int, buffer:Buffer, offset:Int, length:Int, callback:(err:Error, bytesWritten:Int, buffer:Buffer) -> Void):Void {})
	static function write(fd:Int, buffer:Buffer, offset:Int, length:Int, position:Int, callback:(err:Error, bytesWritten:Int, buffer:Buffer) -> Void):Void;

	/**
		Synchronous version of `write`. Returns the number of bytes written.
	**/
	@:overload(function(fd:Int, data:String, position:Int, encoding:String):Int {})
	@:overload(function(fd:Int, data:String, ?position:Int):Int {})
	static function writeSync(fd:Int, buffer:Buffer, offset:Int, length:Int, ?position:Int):Int;

	/**
		Write an array of buffers to the file specified by `fd` using writev().

		`position` is the offset from the beginning of the file where this data should be written.
		If `position` is not a number, the data will be written at the current position.

		The callback will be given three arguments: `(err, bytesWritten, buffers)`.
		`bytesWritten` is how many bytes were written from `buffers`.
	**/
	@:overload(function(fd:Int, buffers:Array<FsVectorBuffer>, callback:(err:Error, bytesWritten:Int, buffers:Array<FsVectorBuffer>) -> Void):Void {})
	static function writev(fd:Int, buffers:Array<FsVectorBuffer>, position:Int, callback:(err:Error, bytesWritten:Int, buffers:Array<FsVectorBuffer>) -> Void):Void;

	/**
		Synchronous version of `writev`. Returns the number of bytes written.
	**/
	static function writevSync(fd:Int, buffers:Array<FsVectorBuffer>, ?position:Int):Int;

	/**
		Read data from the file specified by `fd`.

		`buffer` is the buffer that the data will be written to.

		`offset` is the offset in the `buffer` to start writing at.

		`length` is an integer specifying the number of bytes to read.

		`position` is an integer specifying where to begin reading from in the file.
		If position is null, data will be read from the current file position.

		The `callback` is given the three arguments, (err, bytesRead, buffer).
	**/
	static function read(fd:Int, buffer:Buffer, offset:Int, length:Int, position:Null<Int>, callback:(err:Error, bytesWritten:Int, buffer:Buffer) -> Void):Void;

	/**
		Synchronous version of `read`. Returns the number of bytes read.
	**/
	static function readSync(fd:Int, buffer:Buffer, offset:Int, length:Int, position:Null<Int>):Int;

	/**
		Read from a file specified by `fd` and write to an array of buffers using readv().

		`position` is the offset from the beginning of the file from where data should be read.
		If `position` is not a number, the data will be read from the current position.

		The callback will be given three arguments: `(err, bytesRead, buffers)`.
		`bytesRead` is how many bytes were read from the file.
	**/
	@:overload(function(fd:Int, buffers:Array<FsVectorBuffer>, callback:(err:Error, bytesWritten:Int, buffers:Array<FsVectorBuffer>) -> Void):Void {})
	static function readv(fd:Int, buffers:Array<FsVectorBuffer>, position:Int, callback:(err:Error, bytesWritten:Int, buffers:Array<FsVectorBuffer>) -> Void):Void;

	/**
		Synchronous version of `readv`. Returns the number of bytes read.
	**/
	static function readvSync(fd:Int, buffers:Array<FsVectorBuffer>, ?position:Int):Int;

	/**
		Asynchronously reads the entire contents of a file.

		The `callback` is passed two arguments (err, data), where data is the contents of the file.
		If no `encoding` is specified, then the raw buffer is returned.

		If `options` is a string, then it specifies the encoding.
	**/
	@:overload(function(filename:FsPath, callback:(err:Error, data:Buffer) -> Void):Void {})
	@:overload(function(filename:FsPath, options:{flag:FsOpenFlag}, callback:(err:Error, data:Buffer) -> Void):Void {})
	@:overload(function(filename:FsPath, options:String, callback:(err:Error, result:String) -> Void):Void {})
	static function readFile(filename:FsPath, options:{encoding:String, ?flag:FsOpenFlag}, callback:(err:Error, result:String) -> Void):Void;

	/**
		Synchronous version of `readFile`. Returns the contents of the filename.
		If the `encoding` option is specified then this function returns a string. Otherwise it returns a buffer.
	**/
	@:overload(function(filename:FsPath):Buffer {})
	@:overload(function(filename:FsPath, options:{flag:FsOpenFlag}):Buffer {})
	@:overload(function(filename:FsPath, options:String):String {})
	static function readFileSync(filename:FsPath, options:{encoding:String, ?flag:FsOpenFlag}):String;

	/**
		Asynchronously writes data to a file, replacing the file if it already exists.

		`data` can be a string or a buffer.

		The encoding option is ignored if data is a buffer. It defaults to 'utf8'.
	**/
	@:overload(function(filename:FsPath, data:Buffer, callback:(err:Error) -> Void):Void {})
	@:overload(function(filename:FsPath, data:String, callback:(err:Error) -> Void):Void {})
	@:overload(function(filename:FsPath, data:Buffer, options:EitherType<String, FsWriteFileOptions>, callback:(err:Error) -> Void):Void {})
	static function writeFile(filename:FsPath, data:String, options:EitherType<String, FsWriteFileOptions>, callback:(err:Error) -> Void):Void;

	/**
		The synchronous version of `writeFile`.
	**/
	@:overload(function(filename:FsPath, data:Buffer):Void {})
	@:overload(function(filename:FsPath, data:String):Void {})
	@:overload(function(filename:FsPath, data:Buffer, options:EitherType<String, FsWriteFileOptions>):Void {})
	static function writeFileSync(filename:FsPath, data:String, options:EitherType<String, FsWriteFileOptions>):Void;

	/**
		Asynchronously append data to a file, creating the file if it not yet exists.
		`data` can be a string or a buffer.
	**/
	@:overload(function(filename:FsPath, data:Buffer, callback:(err:Error) -> Void):Void {})
	@:overload(function(filename:FsPath, data:String, callback:(err:Error) -> Void):Void {})
	@:overload(function(filename:FsPath, data:Buffer, options:EitherType<String, FsWriteFileOptions>, callback:(err:Error) -> Void):Void {})
	static function appendFile(filename:FsPath, data:String, options:EitherType<String, FsWriteFileOptions>, callback:(err:Error) -> Void):Void;

	/**
		The synchronous version of `appendFile`.
	**/
	@:overload(function(filename:FsPath, data:Buffer):Void {})
	@:overload(function(filename:FsPath, data:String):Void {})
	@:overload(function(filename:FsPath, data:Buffer, options:EitherType<String, FsWriteFileOptions>):Void {})
	static function appendFileSync(filename:FsPath, data:String, options:EitherType<String, FsWriteFileOptions>):Void;

	/**
		Unstable. Use `watch` instead, if possible.

		Watch for changes on `filename`.
		The callback `listener` will be called each time the file is accessed.

		The `options` if provided should be an object containing two members:
			- `persistent` indicates whether the process should continue to run as long as files are being watched.
			- `interval` indicates how often the target should be polled, in milliseconds.
		The default is { persistent: true, interval: 5007 }.

		The `listener` gets two arguments: the current stat object and the previous stat object.
	**/
	@:overload(function(filename:FsPath, listener:(curr:Stats, prev:Stats) -> Void):StatWatcher {})
	static function watchFile(filename:FsPath, options:FsWatchFileOptions, listener:(curr:Stats, prev:Stats) -> Void):StatWatcher;

	/**
		Unstable. Use `watch` instead, if possible.

		Stop watching for changes on filename.
		If `listener` is specified, only that particular listener is removed.
		Otherwise, all listeners are removed and you have effectively stopped watching filename.
		Calling `unwatchFile` with a `filename` that is not being watched is a no-op, not an error.
	**/
	static function unwatchFile(filename:FsPath, ?listener:(curr:Stats, prev:Stats) -> Void):Void;

	/**
		Watch for changes on `filename` (file or directory).

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fswatchfilename-options-listener
	**/
	@:overload(function(filename:FsPath):FSWatcher {})
	@:overload(function(filename:FsPath, options:EitherType<String, FsWatchOptions>):FSWatcher {})
	@:overload(function(filename:FsPath, options:EitherType<String, FsWatchOptions>, listener:(eventType:FSWatcherChangeType, filename:Null<EitherType<String, Buffer>>) -> Void):FSWatcher {})
	static function watch(filename:FsPath, listener:(eventType:FSWatcherChangeType, filename:Null<EitherType<String, Buffer>>) -> Void):FSWatcher;

	/**
		Test whether or not the given `path` exists by checking with the file system.
		Then call the `callback` argument with either `true` or `false`.

		`exists` is an anachronism and exists only for historical reasons.
		There should almost never be a reason to use it in your own code.

		In particular, checking if a file exists before opening it is an anti-pattern that leaves you vulnerable to race conditions:
		another process may remove the file between the calls to `exists` and `open`.

		Just open the file and handle the error when it's not there.
	**/
	@:deprecated("Use Fs.stat or Fs.access instead")
	static function exists(path:FsPath, callback:(exists:Bool) -> Void):Void;

	/**
		Synchronous version of `exists`.
	**/
	static function existsSync(path:FsPath):Bool;

	/**
		Tests a user's permissions for the file or directory specified by `path`.

		The `mode` argument is an optional integer that specifies the accessibility checks to be performed.
		The following constants define the possible values of `mode`. It is possible to create a mask consisting
		of the bitwise OR of two or more values.

		* `Fs.constants.F_OK` - path is visible to the calling process. This is useful for determining if a file exists,
		  but says nothing about `rwx` permissions. Default if no `mode` is specified.
		* `Fs.constants.R_OK` - path can be read by the calling process.
		* `Fs.constants.W_OK` - path can be written by the calling process.
		* `Fs.constants.X_OK` - path can be executed by the calling process.
		  This has no effect on Windows (will behave like `Fs.constants.F_OK`).

		The final argument, `callback`, is a callback function that is invoked with a possible error argument.
		If any of the accessibility checks fail, the error argument will be populated.
	**/
	@:overload(function(path:FsPath, callback:(err:Error) -> Void):Void {})
	static function access(path:FsPath, mode:Int, callback:(err:Error) -> Void):Void;

	/**
		A mode flag for `access` and `accessSync` methods:

		File is visible to the calling process.
		This is useful for determining if a file exists, but says nothing about rwx permissions.
	**/
	@:deprecated("Use Fs.constants.F_OK instead")
	static final F_OK:Int;

	/**
		A mode flag for `access` and `accessSync` methods:

		File can be read by the calling process.
	**/
	@:deprecated("Use Fs.constants.R_OK instead")
	static final R_OK:Int;

	/**
		A mode flag for `access` and `accessSync` methods:

		File can be written by the calling process.
	**/
	@:deprecated("Use Fs.constants.W_OK instead")
	static final W_OK:Int;

	/**
		A mode flag for `access` and `accessSync` methods:

		File can be executed by the calling process.
		This has no effect on Windows.
	**/
	@:deprecated("Use Fs.constants.X_OK instead")
	static final X_OK:Int;

	/**
		Synchronous version of `access`.
		This throws if any accessibility checks fail, and does nothing otherwise.
	**/
	static function accessSync(path:FsPath, ?mode:Int):Void;

	/**
		Returns a new `ReadStream` (see Readable Stream).

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fscreatereadstreampath-options
	**/
	static function createReadStream(path:FsPath, ?options:EitherType<String, FsCreateReadStreamOptions>):ReadStream;

	/**
		Returns a new `WriteStream` (see Writable Stream).

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fscreatewritestreampath-options
	**/
	static function createWriteStream(path:FsPath, ?options:FsCreateWriteStreamOptions):WriteStream;
}
