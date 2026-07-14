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

import haxe.extern.EitherType;
import js.node.Fs;
import js.node.fs.Dir;
import js.node.fs.Dirent;
import js.node.fs.FileHandle;
import js.node.fs.Stats;
import js.node.fs.StatsFs;
import js.lib.Promise;

/**
	Minimal async iterator surface used by `glob` / `watch` (for `for await...of`).
**/
typedef FsPromisesAsyncIterator<T> = {
	function next():Promise<{done:Bool, ?value:T}>;
}

/**
	The `fs/promises` API provides asynchronous file system methods that return promises.

	Accessible via `require('fs/promises')` or `require('fs').promises`.

	@see https://nodejs.org/docs/latest-v24.x/api/fs.html#promises-api
**/
@:jsRequire("fs/promises")
extern class FsPromises {
	/**
		Commonly used constants for file system operations.
		Same as `Fs.constants`.
	**/
	static final constants:FsConstants;

	/**
		Tests a user's permissions for the file or directory specified by `path`.
	**/
	@:overload(function(path:FsPath):Promise<Void> {})
	static function access(path:FsPath, mode:Int):Promise<Void>;

	/**
		Asynchronously append data to a file, creating the file if it does not exist.
	**/
	@:overload(function(path:EitherType<FsPath, FileHandle>, data:EitherType<String, Buffer>):Promise<Void> {})
	static function appendFile(path:EitherType<FsPath, FileHandle>, data:EitherType<String, Buffer>,
		options:EitherType<String, FsWriteFileOptions>):Promise<Void>;

	/**
		Changes file permissions of `path`.
	**/
	static function chmod(path:FsPath, mode:FsMode):Promise<Void>;

	/**
		Changes file ownership of `path`.
	**/
	static function chown(path:FsPath, uid:Int, gid:Int):Promise<Void>;

	/**
		Asynchronously copies `src` to `dest`.
	**/
	@:overload(function(src:FsPath, dest:FsPath):Promise<Void> {})
	static function copyFile(src:FsPath, dest:FsPath, mode:Int):Promise<Void>;

	/**
		Asynchronously copies the entire directory structure from `src` to `dest`,
		including subdirectories and files.
	**/
	@:overload(function(src:FsPath, dest:FsPath):Promise<Void> {})
	static function cp(src:FsPath, dest:FsPath, options:FsCpOptions):Promise<Void>;

	/**
		Retrieves the files matching the specified pattern as an async iterator.
	**/
	@:overload(function(pattern:EitherType<String, Array<String>>):FsPromisesAsyncIterator<String> {})
	@:overload(function(pattern:EitherType<String, Array<String>>, options:FsGlobOptions):FsPromisesAsyncIterator<String> {})
	static function glob(pattern:EitherType<String, Array<String>>, options:{
		?cwd:haxe.extern.EitherType<String, js.node.url.URL>,
		?exclude:EitherType<(path:String) -> Bool, Array<String>>,
		?followSymlinks:Bool,
		withFileTypes:Bool
	}):FsPromisesAsyncIterator<Dirent>;

	/**
		Changes the permissions on a symbolic link.
		No-op on Windows.
	**/
	static function lchmod(path:FsPath, mode:FsMode):Promise<Void>;

	/**
		Changes the ownership on a symbolic link.
	**/
	static function lchown(path:FsPath, uid:Int, gid:Int):Promise<Void>;

	/**
		Changes the access and modification times of a file in the same way as `utimes`,
		without following symlinks.
	**/
	static function lutimes(path:FsPath, atime:EitherType<Date, EitherType<Float, String>>,
		mtime:EitherType<Date, EitherType<Float, String>>):Promise<Void>;

	/**
		Creates a new link from `existingPath` to `newPath`.
	**/
	static function link(existingPath:FsPath, newPath:FsPath):Promise<Void>;

	/**
		Retrieves the `fs.Stats` for the symbolic link referred to by `path`.

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fspromiseslstatpath-options
	**/
	@:overload(function(path:FsPath):Promise<Stats> {})
	static function lstat(path:FsPath, options:FsStatOptions):Promise<Stats>;

	/**
		Asynchronously creates a directory.
		When `recursive` is true, fulfills with the first directory path created, if any.
	**/
	@:overload(function(path:FsPath):Promise<Null<String>> {})
	@:overload(function(path:FsPath, mode:FsMode):Promise<Null<String>> {})
	static function mkdir(path:FsPath, options:{?recursive:Bool, ?mode:FsMode}):Promise<Null<String>>;

	/**
		Creates a unique temporary directory.
		Generates six random characters to be appended behind a required `prefix` to create a unique temporary directory.
	**/
	@:overload(function(prefix:String):Promise<String> {})
	static function mkdtemp(prefix:String, options:EitherType<String, {?encoding:String}>):Promise<String>;

	/**
		Asynchronously creates a unique temporary directory and returns an async-disposable object.

		When the object is disposed (or `remove` is awaited), the directory and its contents are removed
		if they still exist.

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fspromisesmkdtempdisposableprefix-options
	**/
	@:overload(function(prefix:String):Promise<FsPromisesMkdtempDisposable> {})
	static function mkdtempDisposable(prefix:String, options:EitherType<String, {?encoding:String}>):Promise<FsPromisesMkdtempDisposable>;

	/**
		Opens a `FileHandle`.
	**/
	@:overload(function(path:FsPath):Promise<FileHandle> {})
	@:overload(function(path:FsPath, flags:FsOpenFlag):Promise<FileHandle> {})
	static function open(path:FsPath, flags:FsOpenFlag, mode:FsMode):Promise<FileHandle>;

	/**
		Asynchronously open a directory for iterative scanning.
	**/
	@:overload(function(path:FsPath):Promise<Dir> {})
	static function opendir(path:FsPath, options:FsOpendirOptions):Promise<Dir>;

	/**
		Reads the contents of a directory.
	**/
	@:overload(function(path:FsPath):Promise<Array<String>> {})
	@:overload(function(path:FsPath, options:EitherType<String, {?encoding:String, ?withFileTypes:Bool, ?recursive:Bool}>):Promise<Array<String>> {})
	static function readdir(path:FsPath, options:{?encoding:String, withFileTypes:Bool, ?recursive:Bool}):Promise<Array<Dirent>>;

	/**
		Asynchronously reads the entire contents of a file.
		If no encoding is specified, the data is returned as a `Buffer`.
	**/
	@:overload(function(path:EitherType<FsPath, FileHandle>):Promise<Buffer> {})
	@:overload(function(path:EitherType<FsPath, FileHandle>, options:EitherType<String, {encoding:String, ?flag:FsOpenFlag, ?signal:js.node.web.AbortSignal}>):Promise<String> {})
	static function readFile(path:EitherType<FsPath, FileHandle>,
		?options:{?encoding:String, ?flag:FsOpenFlag, ?signal:js.node.web.AbortSignal}):Promise<EitherType<String, Buffer>>;

	/**
		Reads the contents of the symbolic link referred to by `path`.
	**/
	@:overload(function(path:FsPath):Promise<String> {})
	static function readlink(path:FsPath, options:EitherType<String, {?encoding:String}>):Promise<EitherType<String, Buffer>>;

	/**
		Determines the actual location of `path` using the same semantics as the `fs.realpath` algorithm.
	**/
	@:overload(function(path:FsPath):Promise<String> {})
	static function realpath(path:FsPath, options:EitherType<String, {?encoding:String}>):Promise<EitherType<String, Buffer>>;

	/**
		Renames `oldPath` to `newPath`.
	**/
	static function rename(oldPath:FsPath, newPath:FsPath):Promise<Void>;

	/**
		Removes files and directories (modeled on the standard POSIX `rm` utility).
	**/
	@:overload(function(path:FsPath):Promise<Void> {})
	static function rm(path:FsPath, options:FsRmOptions):Promise<Void>;

	/**
		Removes the directory identified by `path`.
	**/
	@:overload(function(path:FsPath):Promise<Void> {})
	static function rmdir(path:FsPath, options:FsRmdirOptions):Promise<Void>;

	/**
		Retrieves the `fs.Stats` for the file referred to by `path`.

		@see https://nodejs.org/docs/latest-v24.x/api/fs.html#fspromisesstatpath-options
	**/
	@:overload(function(path:FsPath):Promise<Stats> {})
	static function stat(path:FsPath, options:FsStatOptions):Promise<Stats>;

	/**
		Retrieves information about the file system containing the given `path`.
	**/
	@:overload(function(path:FsPath):Promise<StatsFs> {})
	static function statfs(path:FsPath, options:{?bigint:Bool}):Promise<StatsFs>;

	/**
		Creates a symbolic link.
	**/
	@:overload(function(target:FsPath, path:FsPath):Promise<Void> {})
	static function symlink(target:FsPath, path:FsPath, type:SymlinkType):Promise<Void>;

	/**
		Truncates (shortens or extends the length) of the content at `path` to be `len` bytes long.
	**/
	@:overload(function(path:FsPath):Promise<Void> {})
	static function truncate(path:FsPath, len:Int):Promise<Void>;

	/**
		Removes the link and deletes the file named by `path` if no other references exist.
	**/
	static function unlink(path:FsPath):Promise<Void>;

	/**
		Change the file system timestamps of the object referenced by `path`.
	**/
	static function utimes(path:FsPath, atime:EitherType<Date, EitherType<Float, String>>,
		mtime:EitherType<Date, EitherType<Float, String>>):Promise<Void>;

	/**
		Returns an async iterator that watches for changes on `filename`.
	**/
	@:overload(function(filename:FsPath):FsPromisesAsyncIterator<FsPromisesWatchEvent> {})
	static function watch(filename:FsPath, options:EitherType<String, FsPromisesWatchOptions>):FsPromisesAsyncIterator<FsPromisesWatchEvent>;

	/**
		Asynchronously writes data to a file, replacing the file if it already exists.
	**/
	@:overload(function(file:EitherType<FsPath, FileHandle>, data:EitherType<String, Buffer>):Promise<Void> {})
	static function writeFile(file:EitherType<FsPath, FileHandle>, data:EitherType<String, Buffer>,
		options:EitherType<String, FsWriteFileOptions>):Promise<Void>;
}

/**
	Options for `FsPromises.watch`.
**/
typedef FsPromisesWatchOptions = {
	/**
		Specifies the character encoding to be used for the filename passed to the listener.
		Default: `'utf8'`.
	**/
	@:optional var encoding:String;

	/**
		Indicates whether the process should continue to run as long as files are being watched.
		Default: `true`.
	**/
	@:optional var persistent:Bool;

	/**
		Indicates whether all files should be watched, or only the current directory.
		Default: `false`.
	**/
	@:optional var recursive:Bool;

	/**
		Allows aborting an in-progress watch with an AbortSignal.
	**/
	@:optional var signal:js.node.web.AbortSignal;
}

/**
	Event yielded by `FsPromises.watch`.
**/
typedef FsPromisesWatchEvent = {
	/**
		The type of change: `'rename'` or `'change'`.
	**/
	var eventType:String;

	/**
		The name of the file that changed.
	**/
	var filename:Null<EitherType<String, Buffer>>;
}

/**
	Async-disposable temporary directory returned by `FsPromises.mkdtempDisposable`.
**/
typedef FsPromisesMkdtempDisposable = {
	/**
		The path of the created directory.
	**/
	var path:String;

	/**
		Asynchronously removes the created directory and its contents.
		Same as the `[Symbol.asyncDispose]` method on the returned object.
	**/
	function remove():Promise<Void>;
}
