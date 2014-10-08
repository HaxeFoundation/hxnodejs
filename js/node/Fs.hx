package js.node;

import js.Error;
import js.node.Buffer;
import js.node.fs.Stats;
import js.node.fs.FSWatcher;
import js.node.fs.ReadStream;
import js.node.fs.WriteStream;

typedef WatchFileOptions = {
	persistent:Bool,
	interval:Int,
}

typedef WriteFileOptions = {
	?encoding:String,
	?mode:Int,
	?flag:FileOpenFlag
}

/**
	Defaults:
	{ flags: 'r',
	  encoding: null,
	  fd: null,
	  mode: 0666,
	  autoClose: true
	}
**/
typedef CreateReadStreamOptions = {
	?flags:FileOpenFlag,
	?encoding:String,
	?fd:Int,
	?mode:Int,
	?autoClose:Bool,
	?start:Int,
	?end:Int
}

/**
	Defaults:
	{ flags: 'w',
	  encoding: null,
	  mode: 0666 }
**/
typedef CreateWriteStreamOptions = {
	>WriteFileOptions,
	?start:Int
}

@:enum abstract SymlinkType(String) from String to String {
	var Dir = "dir";
	var File = "file";
	var Junction = "junction";
}

@:enum abstract FileOpenFlag(String) from String to String {
	/**
		Open file for reading. An exception occurs if the file does not exist.
	**/
	var Read = "r";

	/**
		Open file for reading and writing. An exception occurs if the file does not exist.
	**/
	var ReadWrite = "r+";

	/**
		Open file for reading in synchronous mode. Instructs the operating system to bypass the local file system cache.

		This is primarily useful for opening files on NFS mounts as it allows you to skip the potentially stale local cache.
		It has a very real impact on I/O performance so don't use this flag unless you need it.

		Note that this doesn't turn `Fs.open` into a synchronous blocking call.
		If that's what you want then you should be using `Fs.openSync`
	 */
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
 * File I/O is provided by simple wrappers around standard POSIX functions. To use this module do require('fs'). All the methods have asynchronous and synchronous forms.
 * The asynchronous form always take a completion callback as its last argument.
 * The arguments passed to the completion callback depend on the method, but the first argument is always reserved for an exception.
 * If the operation was completed successfully, then the first argument will be null or undefined.
 * When using the synchronous form any exceptions are immediately thrown. You can use try/catch to handle exceptions or allow them to bubble up.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:jsRequire("fs")
extern class Fs
{
	/**
		Asynchronous rename(2).
	**/
	static function rename(oldPath:String, newPath:String, callback:Error->Void):Void;


	/**
		Synchronous rename(2).
	**/
	static function renameSync(oldPath:String, newPath:String):Void;

	/**
		Asynchronous ftruncate(2).
	**/
	static function ftruncate(fd:Int, len:Int, callback:Error->Void):Void;

	/**
		Synchronous ftruncate(2).
	**/
	static function ftruncateSync(fd:Int, len:Int):Void;

	/**
		Asynchronous truncate(2).
	**/
	static function truncate(path:String, len:Int, callback:Error->Void):Void;

	/**
		Synchronous truncate(2).
	**/
	static function truncateSync(path:String, len:Int):Void;

	/**
		Asynchronous chown(2).
	**/
	static function chown(path:String, uid:Int, gid:Int, callback:Error->Void):Void;

	/**
		Synchronous chown(2).
	**/
	static function chownSync(path:String, uid:Int, gid:Int):Void;

	/**
		Asynchronous fchown(2).
	**/
	static function fchown(fd:Int, uid:Int, gid:Int, callback:Error->Void):Void;

	/**
		Synchronous fchown(2).
	**/
	static function fchownSync(fd:Int, uid:Int, gid:Int):Void;

	/**
		Asynchronous lchown(2).
	**/
	static function lchown(path:String, uid:Int, gid:Int, callback:Error->Void):Void;

	/**
		Synchronous lchown(2).
	**/
	static function lchownSync(path:String, uid:Int, gid:Int):Void;

	/**
		Asynchronous chmod(2).
	**/
	static function chmod(path:String, mode:String, callback:Error->Void):Void;

	/**
		Synchronous chmod(2).
	**/
	static function chmodSync(path:String, mode:String):Void;

	/**
		Asynchronous fchmod(2).
	**/
	static function fchmod(fd:Int, mode : String, callback:Error->Void):Void;

	/**
		Synchronous fchmod(2).
	**/
	static function fchmodSync(fd:Int, mode:String):Void;

	/**
		Asynchronous lchmod(2).
		Only available on Mac OS X.
	**/
	static function lchmod(path:String, mode:String, callback:Error->Void):Void;

	/**
		Synchronous lchmod(2).
	**/
	static function lchmodSync(path:String, mode:String):Void;

	/**
		Asynchronous stat(2).
	 */
	static function stat(path:String, callback:Error->Stats->Void):Void;

	/**
		Asynchronous lstat(2).

		lstat() is identical to stat(), except that if path is a symbolic link,
		then the link itself is stat-ed, not the file that it refers to.
	**/
	static function lstat(path:String, callback:Error->Stats->Void):Void;

	/**
		Asynchronous fstat(2).

		fstat() is identical to stat(), except that the file to be stat-ed
		is specified by the file descriptor fd.
	**/
	static function fstat(fd:Int, callback:Error->Stats->Void):Void;

	/**
		Synchronous stat(2).
	**/
	static function statSync(path:String):Stats;

	/**
		Synchronous lstat(2).
	**/
	static function lstatSync(path:String):Stats;

	/**
		Synchronous fstat(2).
	**/
	static function fstatSync(fd:Int):Stats;

	/**
		Asynchronous link(2).
	**/
	static function link(srcpath:String, dstpath:String, callback:Error->Void):Void;

	/**
		Synchronous link(2).
	**/
	static function linkSync(srcpath:String, dstpath:String):Void;

	/**
		Asynchronous symlink(2).

		The `type` argument can be set to 'dir', 'file', or 'junction' (default is 'file')
		and is only available on Windows (ignored on other platforms). Note that Windows junction
		points require the destination path to be absolute. When using 'junction', the destination
		argument will automatically be normalized to absolute path.
	**/
	@:overload(function(srcpath:String, dstpath:String, callback:Error->Void):Void {})
	static function symlink(srcpath:String, dstpath:String, type:SymlinkType, callback:Error->Void):Void;

	/**
		Synchronous symlink(2).
	**/
	@:overload(function(srcpath:String, dstpath:String):Void {})
	static function symlinkSync(srcpath:String, dstpath:String, type:SymlinkType):Void;

	/**
		Asynchronous readlink(2).
	**/
	static function readlink(path:String, callback:Error->String->Void):Void;

	/**
		Synchronous readlink(2).
		Returns the symbolic link's string value.
	**/
	static function readlinkSync(path:String):String;

	/**
		Asynchronous realpath(2).
		The callback gets two arguments (err, resolvedPath).
		May use process.cwd to resolve relative paths.
		`cache` is an object literal of mapped paths that can be used to force
		a specific path resolution or avoid additional `stat` calls for known real paths.
	**/
	@:overload(function(path:String, callback:Error->String->Void):Void {})
	static function realpath(path:String, cache:Dynamic<String>, callback:Error->String->Void):Void;

	/**
		Synchronous realpath(2).
		Returns the resolved path.
	**/
	@:overload(function realpathSync(path:String):String {})
	static function realpathSync(path:String, cache:Dynamic<String>):String;

	/**
		Asynchronous unlink(2).
	**/
	static function unlink(path:String, callback:Error->Void):Void;

	/**
		Synchronous unlink(2).
	**/
	static function unlinkSync(path:String):Void;

	/**
		Asynchronous rmdir(2).
	**/
	static function rmdir(path : String, callback : Error -> Void):Void;

	/**
		Synchronous rmdir(2).
	**/
	static function rmdirSync(path:String):Void;

	/**
		Asynchronous mkdir(2).
		`mode` defaults to 0777.
	**/
	@:overload(function(path:String, callback: Error->Void):Void {})
	static function mkdir(path : String, mode:String, callback : Error->Void):Void;

	/**
		Synchronous mkdir(2).
	**/
	static function mkdirSync(path:String, ?mode:String):Void;

	/**
		Asynchronous readdir(3).
		Reads the contents of a directory.
		The callback gets two arguments (err, files) where files is an array of the
		names of the files in the directory excluding '.' and '..'.
	**/
	static function readdir(path:String, callback:Error->Array<String>->Void):Void;

	/**
		Synchronous readdir(3).
		Returns an array of filenames excluding '.' and '..'.
	**/
	static function readdirSync(path:String):Array<String>;

	/**
		Asynchronous close(2).
	**/
	static function close(fd:Int, callback:Error->Void):Void;

	/**
		Synchronous close(2).
	**/
	static function closeSync(fd:Int):Void;

	/**
		Asynchronous file open. See open(2).

		`mode` sets the file mode (permission and sticky bits), but only if the file was created.
		It defaults to 0666, readable and writeable.

		The `callback` gets two arguments (err, fd).

		The exclusive flag `x` (O_EXCL flag in open(2)) ensures that path is newly created.
		On POSIX systems, path is considered to exist even if it is a symlink to a non-existent file.
		The exclusive flag may or may not work with network file systems.

		On Linux, positional writes don't work when the file is opened in append mode.
		The kernel ignores the position argument and always appends the data to the end of the file.
	**/
	@:overload(function(path:String, flags:FileOpenFlag, callback:Error->Int->Void):Void {})
	static function open(path:String, flags:FileOpenFlag, mode:String, callback:Error->Int->Void):Void;

	/**
		Synchronous version of open().
	**/
	@:overload(function(path:String, flags:FileOpenFlag):Void {})
	static function openSync(path:String, flags:FileOpenFlag, mode:String):Void;

	/**
		Change file timestamps of the file referenced by the supplied path.
	**/
	static function utimes(path:String, atime:Date, mtime:Date, callback:Error->Void):Void;

	/**
		Change file timestamps of the file referenced by the supplied path.
	**/
	static function utimesSync(path:String, atime:Date, mtime:Date):Void;

	/**
		Change the file timestamps of a file referenced by the supplied file descriptor.
	**/
	static function futimes(fd:Int, atime:Date, mtime:Date, callback:Error->Void):Void;

	/**
		Change the file timestamps of a file referenced by the supplied file descriptor.
	**/
	static function futimesSync(fd:Int, atime:Date, mtime:Date):Void;

	/**
		Asynchronous fsync(2).
	**/
	static function fsync(fd:Int, callback:Error->Void):Void;

	/**
		Synchronous fsync(2).
	**/
	static function fsyncSync(fd:Int):Void;

	/**
		Write `buffer` to the file specified by `fd`.

		`offset` and `length` determine the part of the `buffer` to be written.

		`position` refers to the offset from the beginning of the file where this data should be written.
		If position is null, the data will be written at the current position. See pwrite(2).

		The `callback` will be given three arguments (err, written, buffer) where `written` specifies how many bytes were written from `buffer`.

		Note that it is unsafe to use `write` multiple times on the same file without waiting for the callback.
		For this scenario, `createWriteStream` is strongly recommended.

		On Linux, positional writes don't work when the file is opened in append mode. The kernel ignores the position
		argument and always appends the data to the end of the file.
	**/
	static function write(fd:Int, buffer:Buffer, offset:Int, length:Int, position:Null<Int>, callback:Error->Int->Buffer->Void):Void;

	/**
		Synchronous version of `write`. Returns the number of bytes written.
	**/
	static function writeSync(fd:Int, buffer:Buffer, offset:Int, length:Int, position:Null<Int>):Int;

	/**
		Read data from the file specified by `fd`.

		`buffer` is the buffer that the data will be written to.

		`offset` is the offset in the `buffer` to start writing at.

		`length` is an integer specifying the number of bytes to read.

		`position` is an integer specifying where to begin reading from in the file.
		If position is null, data will be read from the current file position.

		The `callback` is given the three arguments, (err, bytesRead, buffer).
	**/
	static function read(fd:Int, buffer:Buffer, offset:Int, length:Int, position:Null<Int>, callback:Error->Int->Buffer->Void):Void;

	/**
		Synchronous version of `read`. Returns the number of bytes read.
	**/
	static function readSync(fd:Int, buffer:Buffer, offset:Int, length:Int, position:Null<Int>):Int;

	/**
		Asynchronously reads the entire contents of a file.

		The `callback` is passed two arguments (err, data), where data is the contents of the file.
		If no `encoding` is specified, then the raw buffer is returned.
	**/
	@:overload(function(filename:String, callback:Error->Buffer->Void):Void {})
	@:overload(function(filename:String, options:{flag:FileOpenFlag}, callback:Error->Buffer->Void):Void {})
	static function readFile(filename:String, options:{encoding:String, ?flag:FileOpenFlag}, callback:Error->String->Void):Void;

	/**
		Synchronous version of `readFile`. Returns the contents of the filename.
		If the `encoding` option is specified then this function returns a string. Otherwise it returns a buffer.
	**/
	@:overload(function(filename:String):Buffer {})
	@:overload(function(filename:String, options:{flag:FileOpenFlag}):Buffer {})
	static function readFileSync(filename:String, options:{encoding:String, ?flag:FileOpenFlag}):String;

	/**
		Asynchronously writes data to a file, replacing the file if it already exists.

		`data` can be a string or a buffer.

		The encoding option is ignored if data is a buffer. It defaults to 'utf8'.
	**/
	@:overload(function(filename:String, data:Buffer, callback:Error->Void):Void {})
	@:overload(function(filename:String, data:String, callback:Error->Void):Void {})
	@:overload(function(filename:String, data:Buffer, options:WriteFileOptions, callback:Error->Void):Void {})
	static function writeFile(filename:String, data:String, options:WriteFileOptions, callback:Error->Void):Void;

	/**
		The synchronous version of `writeFile`.
	**/
	@:overload(function(filename:String, data:Buffer):Void {})
	@:overload(function(filename:String, data:String):Void {})
	@:overload(function(filename:String, data:Buffer, options:WriteFileOptions):Void {})
	static function writeFileSync(filename:String, data:String, options:WriteFileOptions):Void;

	/**
		Asynchronously append data to a file, creating the file if it not yet exists.
		`data` can be a string or a buffer.
	**/
	@:overload(function(filename:String, data:Buffer, callback:Error->Void):Void {})
	@:overload(function(filename:String, data:String, callback:Error->Void):Void {})
	@:overload(function(filename:String, data:Buffer, options:WriteFileOptions, callback:Error->Void):Void {})
	static function appendFile(filename:String, data:String, options:WriteFileOptions, callback:Error->Void):Void;

	/**
		The synchronous version of `appendFile`.
	**/
	@:overload(function(filename:String, data:Buffer):Void {})
	@:overload(function(filename:String, data:String):Void {})
	@:overload(function(filename:String, data:Buffer, options:WriteFileOptions):Void {})
	static function appendFileSync(filename:String, data:String, options:WriteFileOptions):Void;

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
	@:overload(function(filename:String, listener:Stats->Stats->Void):Void {})
	static function watchFile(filename:String, options:WatchFileOptions, listener:Stats->Stats->Void):Void;

	/**
		Unstable. Use `watch` instead, if possible.

		Stop watching for changes on filename.
		If `listener` is specified, only that particular listener is removed.
		Otherwise, all listeners are removed and you have effectively stopped watching filename.
		Calling `unwatchFile` with a `filename` that is not being watched is a no-op, not an error.
	**/
	@:overload(function(filename:String):Void {})
	static function unwatchFile(filename:String, listener:Stats->Stats->Void):Void;

	/**
		Watch for changes on `filename`, where filename is either a file or a directory.

		`persistent` indicates whether the process should continue to run as long as files are being watched. Default is `true`.

		The `listener` callback gets two arguments (event, filename). event is either 'rename' or 'change', and filename
		is the name of the file which triggered the event.
	**/
	@:overload(function(filename:String):FSWatcher {})
	@:overload(function(filename:String, listener:FSWatcherEvent->String->Void):FSWatcher {})
	static function watch(filename:String, options:{persistent:Bool}, listener:FSWatcherEvent->String->Void):FSWatcher;

	/**
		Test whether or not the given `path` exists by checking with the file system.
		Then call the `callback` argument with either `true` or `false`.

		`exists` is an anachronism and exists only for historical reasons.
		There should almost never be a reason to use it in your own code.

		In particular, checking if a file exists before opening it is an anti-pattern that leaves you vulnerable to race conditions:
		another process may remove the file between the calls to `exists` and `open`.

		Just open the file and handle the error when it's not there.
	**/
	static function exists(path:String, callback:Bool->Void):Void;

	/**
		Synchronous version of `exists`.
	**/
	static function existsSync(path:String):Bool;


	/**
		Returns a new ReadStream object (See Readable Stream).

		`options` can include `start` and `end` values to read a range of bytes from the file instead of the entire file.
		Both `start` and `end` are inclusive and start at 0.

		The encoding can be 'utf8', 'ascii', or 'base64'.

		If `autoClose` is `false`, then the file descriptor won't be closed, even if there's an error.
		It is your responsiblity to close it and make sure there's no file descriptor leak.
		If `autoClose` is set to true (default behavior), on error or end the file descriptor will be closed automatically.
	**/
	static function createReadStream(path:String, ?options:WriteFileOptions):ReadStream;

	/**
		Returns a new WriteStream object (See Writable Stream).

		`options` may also include a `start` option to allow writing data at some position past the beginning of the file.

		Modifying a file rather than replacing it may require a flags mode of r+ rather than the default mode w.
	**/
	static function createWriteStream(path:String, ?options:WriteFileOptions):WriteStream;
}
