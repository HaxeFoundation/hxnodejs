package nodejs.fs;
import js.Error;
import js.html.Event;
import nodejs.Buffer;


/**
 * The default is { persistent: true, interval: 5007 }
 */
extern class FileWatchOption
{
	/**
	 * Indicates whether the process should continue to run as long as files are being watched
	 */
	var persistent : Bool;
	
	/**
	 * How often the target should be polled, in milliseconds. 
	 */
	var interval : Int;
}

/**
 * 
 */
extern class FileIOOption
{
	/**
	 * String | Null default = null   [Read]
	 * String | Null default = 'utf8' [Write]
	 * String | Null default = 'utf8' [Append]
	 */
	var encoding : String;
	
	/**
	 * default = 'r' [Read]
	 * default = 'w' [Write]
	 * default = 'a' [ Append]
	 */
	var flag : String;
	
	/**
	 * Use only for Write/Append operations.
	 * default = 438 (aka 0666 in Octal) [Write]
	 * default = 438 (aka 0666 in Octal) [Append]
	 */
	var mode : Int;
	
	
	/**
	 * Use only in 'stream' methods
	 */
	var autoClose : Bool;
	
	/**
	 * Use only in 'stream' methods
	 * Read a range of bytes from the file instead of the entire file. Both start and end are inclusive and start at 0
	 */
	var start : Int;
	
	/**
	 * Use only in 'stream' methods
	 * Read a range of bytes from the file instead of the entire file. Both start and end are inclusive and start at 0
	 */
	var end : Int;
	
	/**
	 * Use only in 'stream' methods
	 */
	var fd : Int;
}

/**
 * 
 */
class FileLinkType
{
	/**
	 * 
	 */
	static public var Dir : String 		= "dir";
	
	/**
	 * 
	 */
	static public var File : String 	= "file";
	
	/**
	 * 
	 */
	static public var Junction : String = "junction";
}

/**
 * 
 */
class FileIOFlag
{
	/**
	 * Open file for reading. An exception occurs if the file does not exist.
	 */
	static public var Read : String = "r";
	
	/**
	 * Open file for reading and writing. An exception occurs if the file does not exist.
	 */
	static public var ReadWrite : String = "r+";
	
	/**
	 * Open file for reading in synchronous mode. Instructs the operating system to bypass the local file system cache.
	 * This is primarily useful for opening files on NFS mounts as it allows you to skip the potentially stale local cache. 
	 * It has a very real impact on I/O performance so don't use this flag unless you need it.
	 * Note that this doesn't turn fs.open() into a synchronous blocking call. If that's what you want then you should be using fs.openSync()
	 */
	static public var ReadSync : String = "rs";
	
	/**
	 * Open file for reading and writing, telling the OS to open it synchronously. See notes for 'rs' about using this with caution.
	 */
	static public var ReadWriteSync :String = "rs+";
	
	/**
	 * Open file for writing. The file is created (if it does not exist) or truncated (if it exists).
	 */
	static public var WriteCreate :String = "w"; 	
	
	/**
	 * Like 'w' but fails if path exists.
	 */
	static public var WriteCheck :String = "wx";	
	
	/**
	 * Open file for reading and writing. The file is created (if it does not exist) or truncated (if it exists).
	 */
	static public var WriteReadCreate :String = "w+";	
	
	/**
	 * Like 'w+' but fails if path exists.
	 */
	static public var WriteReadCheck :String = "wx+"; 
	
	/**
	 * Open file for appending. The file is created if it does not exist.
	 */
	static public var AppendCreate :String = "a";	
	
	/**
	 * Like 'a' but fails if path exists.
	 */
	static public var AppendCheck :String = "ax"; 	
	
	/**
	 * Open file for reading and appending. The file is created if it does not exist.
	 */
	static public var AppendReadCreate :String = "a+"; 	
	
	/**
	 * Like 'a+' but fails if path exists.
	 */
	static public var AppendReadCheck :String = "ax+"; 
	
}

/**
 * File I/O is provided by simple wrappers around standard POSIX functions. To use this module do require('fs'). All the methods have asynchronous and synchronous forms.
 * The asynchronous form always take a completion callback as its last argument. 
 * The arguments passed to the completion callback depend on the method, but the first argument is always reserved for an exception.
 * If the operation was completed successfully, then the first argument will be null or undefined.
 * When using the synchronous form any exceptions are immediately thrown. You can use try/catch to handle exceptions or allow them to bubble up.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('fs'))")
extern class File
{
	
	/**
	 * Asynchronous rename(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	oldPath
	 * @param	newPath
	 * @param	callback
	 */
	static function rename(oldPath : String, newPath : String, callback : Error -> Void):Void;
		
	
	/**
	 * Synchronous rename(2).
	 * @param	oldPath
	 * @param	newPath
	 */
	static function renameSync(oldPath : String, newPath : String) : Void;
	
	/**
	 * Asynchronous ftruncate(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	fd
	 * @param	len
	 * @param	callback
	 */
	static function ftruncate(fd : Dynamic, len : Int, callback : Error -> Void):Void;
	
	/**
	 * Synchronous ftruncate(2).
	 * @param	fd
	 * @param	len
	 */
	static function ftruncateSync(fd : Dynamic, len : Int) : Void;
	
	/**
	 * Asynchronous truncate(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	path
	 * @param	len
	 * @param	callback
	 * @return
	 */
	static function truncate(path : String, len : Int, callback : Error->Void):Void;

	/**
	 * Synchronous truncate(2).
	 */
	static function truncateSync(path:String, len:Int):Void;
	
	/**
	 * Asynchronous chown(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	path
	 * @param	uid
	 * @param	gid
	 * @param	callback
	 */
	static function chown(path:String, uid:Int, gid:Int, callback:Error->Void):Void;
	
	/**
	 * Synchronous chown(2).
	 * @param	path
	 * @param	uid
	 * @param	gid
	 */
	static function chownSync(path:String, uid:Int, gid:Int):Void;
	
	/**
	 * Asynchronous fchown(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	fd
	 * @param	uid
	 * @param	gid
	 * @param	callback
	 */
	static function fchown(fd:Int, uid:Int, gid:Int, callback:Error->Void):Void;
	
	/**
	 * Synchronous fchown(2).
	 * @param	fd
	 * @param	uid
	 * @param	gid
	 */
	static function fchownSync(fd:Int, uid:Int, gid:Int):Void;
	
	/**
	 * Asynchronous lchown(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	path
	 * @param	uid
	 * @param	gid
	 * @param	callback
	 */
	static function lchown(path:String, uid:Int, gid:Int, callback:Error->Void):Void;
	
	/**
	 * Synchronous lchown(2).
	 * @param	path
	 * @param	uid
	 * @param	gid
	 */
	static function lchownSync(path:String, uid:Int, gid:Int):Void;
	
	/**
	 * Asynchronous chmod(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	path
	 * @param	mode
	 * @param	callback
	 */
	static function chmod(path:String, mode:String, callback:Error->Void):Void;
	
	
	/**
	 * Synchronous chmod(2).
	 * @param	path
	 * @param	mode
	 */
	static function chmodSync(path:String, mode:String):Void;
	
	/**
	 * Asynchronous fchmod(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	fd
	 * @param	mode
	 * @param	callback
	 */
	static function fchmod(fd:Int, mode : String, callback:Error->Void):Void;
	
	/**
	 * Synchronous fchmod(2).
	 * @param	fd
	 * @param	mode
	 */
	static function fchmodSync(fd:Int, mode:String):Void;
	
	/**
	 * Asynchronous lchmod(2). No arguments other than a possible exception are given to the completion callback.
	 * Only available on Mac OS X.
	 * @param	path
	 * @param	mode
	 * @param	callback
	 */
	static function lchmod(path:String, mode:String, callback:Error->Void):Void;
	
	/**
	 * Synchronous lchmod(2).
	 * @param	path
	 * @param	mode
	 */
	static function lchmodSync(path:String, mode:String):Void;
	
	/**
	 * 
	 * @param	path
	 * @param	callback
	 */
	static function stat(path:String, callback:Error->Void):Void;
	
	/**
	 * Asynchronous stat(2). The callback gets two arguments (err, stats) where stats is a fs.Stats object. See the fs.Stats section below for more information.
	 * @param	path
	 * @param	callback
	 */
	static function lstat(path:String, callback:Error->FileStats->Void):Void;
	
	/**
	 * Asynchronous fstat(2). The callback gets two arguments (err, stats) where stats is a fs.Stats object. fstat() is identical to stat(), except that the file to be stat-ed is specified by the file descriptor fd.
	 * @param	fd
	 * @param	callback
	 */
	static function fstat(fd:Int, callback:Error->FileStats->Void):Void;
	
	/**
	 * Synchronous stat(2). Returns an instance of fs.Stats.
	 * @param	path
	 */
	static function statSync(path:String):FileStats;
	
	/**
	 * Synchronous lstat(2). Returns an instance of fs.Stats.
	 * @param	path
	 */
	static function lstatSync(path:String):FileStats;
	
	/**
	 * Synchronous fstat(2). Returns an instance of fs.Stats.
	 * @param	fd
	 */
	static function fstatSync(fd:Int):FileStats;
	
	/**
	 * Asynchronous link(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	srcpath
	 * @param	dstpath
	 * @param	callback
	 */
	static function link(srcpath:String, dstpath:String, callback:Error->Void):Void;
	
	/**
	 * Synchronous link(2).
	 * @param	srcpath
	 * @param	dstpath
	 */
	static function linkSync(srcpath:String, dstpath:String):Void;
	
	/**
	 * Asynchronous symlink(2). 
	 * No arguments other than a possible exception are given to the completion callback. 
	 * The type argument can be set to 'dir', 'file', or 'junction' (default is 'file')
	 * and is only available on Windows (ignored on other platforms).
	 * Note that Windows junction points require the destination path to be absolute. 
	 * When using 'junction', the destination argument will automatically be normalized to absolute path.
	 * @param	srcpath
	 * @param	dstpath
	 * @param	type
	 * @param	callback
	 */
	@:overload(function (srcpath:String, dstpath:String, callback:Error->Void):Void { } )
	static function symlink(srcpath:String, dstpath:String, type:String, callback:Error->Void):Void;
	
	/**
	 * Synchronous symlink(2).
	 * @param	srcpath
	 * @param	dstpath
	 * @param	type
	 */
	@:overload(function (srcpath:String, dstpath:String):Void{})
	static function symlinkSync(srcpath:String, dstpath:String, type:String):Void;
	
	/**
	 * Asynchronous readlink(2). The callback gets two arguments (err, linkString).
	 * @param	path
	 * @param	callback
	 */
	static function readlink(path:String, callback:Error->String->Void):Void;
	
	/**
	 * Synchronous readlink(2). Returns the symbolic link's string value.
	 * @param	path
	 */
	static function readlinkSync(path:String):String;
	
	/**
	 * Asynchronous realpath(2). 
	 * The callback gets two arguments (err, resolvedPath). 
	 * May use process.cwd to resolve relative paths. 
	 * cache is an object literal of mapped paths that can be used to force a specific path resolution or avoid additional fs.stat calls for known real paths.
	 * @param	path
	 * @param	cache
	 * @param	callback
	 */
	@:overload(function(path:String,callback:Error->String->Void):Void{})
	static function realpath(path:String, cache:Dynamic, callback:Error->String->Void):Void;
	
	/**
	 *Synchronous realpath(2). Returns the resolved path.
	 * @param	path
	 * @param	cache
	 */
	@:overloa(function realpathSync(path:String):String{})
	static function realpathSync(path:String, cache:Dynamic):String;
	
	/**
	 * Asynchronous unlink(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	path
	 * @param	callback
	 */
	static function unlink(path:String, callback:Error->Void):Void;
	
	/**
	 * Synchronous unlink(2).
	 * @param	path
	 */
	static function unlinkSync(path:String):Void;	
	
	/**
	 * Asynchronous rmdir(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	path
	 * @param	callback
	 */
	static function rmdir(path : String, callback : Error -> Void):Void;
		
	/**
	 * Synchronous rmdir(2).
	 * @param	path
	 */
	static function rmdirSync(path:String):Void;	
	
	/**
	 * Asynchronous mkdir(2). No arguments other than a possible exception are given to the completion callback. mode defaults to 0777.
	 * @param	path
	 * @param	mode
	 * @param	callback
	 */
	@:overload(function(path:String, callback: Error->Void):Void { } )
	static function mkdir(path : String, mode:String, callback : Error ->Void):Void;
	
	
	
	/**
	 * Synchronous mkdir(2).
	 * @param	path
	 * @param	mode
	 */
	static function mkdirSync(path:String, mode:String):Void;
	
	/**
	 * Asynchronous readdir(3). Reads the contents of a directory. 
	 * The callback gets two arguments (err, files) where files is an array of the names of the files in the directory excluding '.' and '..'.
	 * @param	path
	 * @param	callback
	 */
	static function readdir(path:String, callback:Error->Array<String>->Void):Void;
	
	/**
	 * Synchronous readdir(3). Returns an array of filenames excluding '.' and '..'.
	 * @param	path
	 */
	static function readdirSync(path:String):Array<String>;
	
	/**
	 * Asynchronous close(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	fd
	 * @param	callback
	 */
	static function close(fd:Int, callback:Error->Void):Void;
	
	/**
	 * Synchronous close(2).
	 * @param	fd
	 */
	static function closeSync(fd:Int):Void;
	
	/**
	 * Asynchronous file open.
	 * mode sets the file mode (permission and sticky bits), but only if the file was created. It defaults to 0666, readable and writeable.
	 * The callback gets two arguments (err, fd).
	 * The exclusive flag 'x' (O_EXCL flag in open(2)) ensures that path is newly created. On POSIX systems, path is considered to exist even if it is a symlink to a non-existent file. The exclusive flag may or may not work with network file systems.
	 * On Linux, positional writes don't work when the file is opened in append mode. The kernel ignores the position argument and always appends the data to the end of the file.
	 * @param	path
	 * @param	flags FileIOMode
	 * @param	mode 
	 * @param	callback
	 */
	@:overload(function (path:String, flags:String,  callback:Error->Dynamic->Void):Void{})
	static function open(path:String, flags:String, mode:String, callback:Error->Dynamic->Void):Void;
	
	/**
	 * Synchronous version of fs.open().
	 * @param	path
	 * @param	flags FileIOMode
	 * @param	mode
	 */
	@:overload(function (path:String, flags:String):Void{})
	static function openSync(path:String, flags:String, mode:String):Void;
	
	/**
	 * Change file timestamps of the file referenced by the supplied path.
	 * @param	path
	 * @param	atime
	 * @param	mtime
	 * @param	callback
	 */
	static function utimes(path:String, atime:Date, mtime:Date, callback:Error->Void):Void;
	
	/**
	 * Change file timestamps of the file referenced by the supplied path.
	 * @param	path
	 * @param	atime
	 * @param	mtime
	 */
	static function utimesSync(path:String, atime:Date, mtime:Date):Void;
	
	/**
	 * Change the file timestamps of a file referenced by the supplied file descriptor.
	 * @param	fd
	 * @param	atime
	 * @param	mtime
	 * @param	callback
	 */
	static function futimes(fd:Int, atime:Date, mtime:Date, callback:Error->Void):Void;
	
	/**
	 * Change the file timestamps of a file referenced by the supplied file descriptor.
	 * @param	fd
	 * @param	atime
	 * @param	mtime
	 */
	static function futimesSync(fd:Int, atime:Date, mtime:Date):Void;
	
	/**
	 * Asynchronous fsync(2). No arguments other than a possible exception are given to the completion callback.
	 * @param	fd
	 * @param	callback
	 */
	static function fsync(fd:Int, callback:Error->Void):Void;
	
	/**
	 * Synchronous fsync(2).
	 * @param	fd
	 */
	static function fsyncSync(fd:Int):Void;
	
	/**
	 * Write buffer to the file specified by fd.
	 * offset and length determine the part of the buffer to be written.
	 * position refers to the offset from the beginning of the file where this data should be written. If position is null, the data will be written at the current position. See pwrite(2).
	 * The callback will be given three arguments (err, written, buffer) where written specifies how many bytes were written from buffer.
	 * Note that it is unsafe to use fs.write multiple times on the same file without waiting for the callback. For this scenario, fs.createWriteStream is strongly recommended.
	 * On Linux, positional writes don't work when the file is opened in append mode. The kernel ignores the position argument and always appends the data to the end of the file.
	 * @param	fd
	 * @param	buffer
	 * @param	offset
	 * @param	length
	 * @param	position
	 * @param	callback
	 */
	static function write(fd:Int, buffer:Buffer, offset:Int, length:Int, position:Int, callback:Error->Int->Buffer->Void):Void;
	
	/**
	 * Synchronous version of fs.write(). Returns the number of bytes written.
	 * @param	fd
	 * @param	buffer
	 * @param	offset
	 * @param	length
	 * @param	position
	 */
	static function writeSync(fd:Int, buffer:Buffer, offset:Int, length:Int, position:Int):Int;
	
	/**
	 * Read data from the file specified by fd.
	 * buffer is the buffer that the data will be written to.
	 * offset is the offset in the buffer to start writing at.
	 * length is an integer specifying the number of bytes to read.
	 * position is an integer specifying where to begin reading from in the file. If position is null, data will be read from the current file position.
	 * The callback is given the three arguments, (err, bytesRead, buffer).
	 * @param	fd
	 * @param	buffer
	 * @param	offset
	 * @param	length
	 * @param	position
	 * @param	callback
	 */
	static function read(fd:Int, buffer:Buffer, offset:Int, length:Int, position:Int, callback:Error->Int->Buffer->Void):Void;
	
	/**
	 * Synchronous version of fs.read. Returns the number of bytesRead.
	 * @param	fd
	 * @param	buffer
	 * @param	offset
	 * @param	length
	 * @param	position
	 */
	static function readSync(fd:Int, buffer:Buffer, offset:Int, length:Int, position:Int):Int;
	
	/**
	 * Asynchronously reads the entire contents of a file.
	 * The callback is passed two arguments (err, data), where data is the contents of the file.
	 * If no encoding is specified, then the raw buffer is returned.
	 * @param	filename
	 * @param	options
	 * @param	callback
	 */
	@:overload(function (filename : String, callback:Error->Dynamic->Void):Void { })
	static function readFile(filename : String, options:FileIOOption, callback:Error->Dynamic->Void):Void;
	
	/**
	 * Synchronous version of fs.readFile. Returns the contents of the filename.
	 * If the encoding option is specified then this function returns a string. Otherwise it returns a buffer.
	 * @param	filename
	 * @param	options
	 */
	@:overload(function (filename : String):Dynamic { } )		
	static function readFileSync(filename : String, options:FileIOOption):Dynamic;
	
	/**
	 * Asynchronously writes data to a file, replacing the file if it already exists. data can be a string or a buffer.
	 * The encoding option is ignored if data is a buffer. It defaults to 'utf8'.
	 * @param	filename
	 * @param	data
	 * @param	options
	 * @param	callback
	 */
	@:overload(function (filename : String, data:Buffer, callback:Error->Void):Void { } )
	@:overload(function (filename : String, data:Dynamic, callback:Error->Void):Void { } )
	@:overload(function (filename : String, data:String, callback:Error->Void):Void { } )	
	static function writeFile(filename : String, data:Dynamic, options:FileIOOption, callback:Error->Void):Void;
	
	/**
	 * The synchronous version of fs.writeFile.
	 * @param	filename
	 * @param	data
	 * @param	options
	 */
	@:overload(function (filename : String, data:Buffer):Void { } )
	@:overload(function (filename : String, data:Dynamic):Void { } )
	@:overload(function (filename : String, data:String):Void{})
	static function writeFileSync(filename : String, data:Dynamic, options:FileIOOption):Void;
	
	/**
	 * Asynchronously append data to a file, creating the file if it not yet exists. data can be a string or a buffer.
	 * @param	filename
	 * @param	data
	 * @param	options
	 * @param	callback
	 */
	@:overload(function (filename : String, data:Buffer):Void { } )
	@:overload(function (filename : String, data:Dynamic):Void { } )
	@:overload(function (filename : String, data:String):Void{})
	static function appendFile(filename : String, data:Dynamic, options:FileIOOption, callback:Error->Void):Void;
	
	/**
	 * The synchronous version of fs.appendFile.
	 * @param	filename
	 * @param	data
	 * @param	options
	 */
	@:overload(function (filename : String, data:Buffer):Void { } )
	@:overload(function (filename : String, data:String):Void { } )
	@:overload(function (filename : String, data:Dynamic):Void{})
	static function appendFileSync(filename : String, data:Dynamic, options:FileIOOption):Void;
	
	/**
	 * Watch for changes on filename. The callback listener will be called each time the file is accessed.
	 * The second argument is optional. 
	 * The options if provided should be an object containing two members a boolean, persistent, and interval. 
	 * persistent indicates whether the process should continue to run as long as files are being watched. 
	 * interval indicates how often the target should be polled, in milliseconds. 
	 * The default is { persistent: true, interval: 5007 }.
	 * The listener gets two arguments the current stat object and the previous stat object:
	 * @param	filename
	 * @param	options
	 * @param	listener
	 */
	@:overload(function (filename : String, listener:FileStats->FileStats->Void):Void { } )
	static function watchFile(filename : String, options:FileWatchOption, listener:FileStats->FileStats->Void):Void;
	
	/**
	 * Stop watching for changes on filename. 
	 * If listener is specified, only that particular listener is removed. 
	 * Otherwise, all listeners are removed and you have effectively stopped watching filename.
	 * Calling fs.unwatchFile() with a filename that is not being watched is a no-op, not an error.
	 * @param	filename
	 * @param	listener
	 */
	@:overload(function (filename : String):Void{})
	static function unwatchFile(filename : String, listener:FileStats->FileStats->Void):Void;
	
	/**
	* Watch for changes on filename, where filename is either a file or a directory. The returned object is a fs.FSWatcher.
	* The second argument is optional. The options if provided should be an object containing a boolean member persistent, 
	* which indicates whether the process should continue to run as long as files are being watched. 
	* The default is { persistent: true }.
	* The listener callback gets two arguments (event, filename). event is either 'rename' or 'change', and filename is the name of the file which triggered the event.
	 * @param	filename
	 * @param	options
	 * @param	listener
	 */
	@:overload(function (filename : String):FSWatcher{})
	@:overload(function (filename : String, listener:FileStats->FileStats->Void):FSWatcher { } )
	static function watch(filename : String, options:FileWatchOption, listener:Event->String->Void):FSWatcher;
	
	/**
	 * Test whether or not the given path exists by checking with the file system.
	 * Then call the callback argument with either true or false. 
	 * fs.exists() is an anachronism and exists only for historical reasons. There should almost never be a reason to use it in your own code.
	 * In particular, checking if a file exists before opening it is an anti-pattern
	 * that leaves you vulnerable to race conditions: another process may remove the file between the calls to fs.exists() and fs.open(). 
	 * Just open the file and handle the error when it's not there.
	 * @param	path
	 * @param	callback
	 */
	static function exists(path:String, callback:Bool->Void):Void;
	
	/**
	 * Synchronous version of fs.exists.
	 * @param	path
	 */
	static function existsSync(path:String):Bool;

	
	/**
	 * Returns a new ReadStream object (See Readable Stream).
	 * options can include start and end values to read a range of bytes from the file instead of the entire file. Both start and end are inclusive and start at 0. The encoding can be 'utf8', 'ascii', or 'base64'.
	 * If autoClose is false, then the file descriptor won't be closed, even if there's an error. 
	 * It is your responsiblity to close it and make sure there's no file descriptor leak.
	 * If autoClose is set to true (default behavior), on error or end the file descriptor will be closed automatically.
	 * @param	path
	 * @param	options
	 * @return
	 */
	@:overload(function(path:String):ReadStream{})
	static function createReadStream(path:String, options:FileIOOption):ReadStream;
	
	/**
	 * Returns a new WriteStream object (See Writable Stream).
	 * options may also include a start option to allow writing data at some position past the beginning of the file.
	 * Modifying a file rather than replacing it may require a flags mode of r+ rather than the default mode w.
	 * @param	path
	 * @param	options
	 * @return
	 */
	@:overload(function(path:String):WriteStream{})
	static function createWriteStream(path:String, options:FileIOOption):WriteStream;
}