package js.node.fs;

import haxe.DynamicAccess;
import js.node.Fs.FsConstants;
import js.node.Fs.FsMode;
import js.node.Fs.FsOpenFlag;
import js.node.Fs.FsPath;
import js.node.Fs.FsRmOptions;
import js.node.Fs.FsRmdirOptions;
import js.node.Fs.SymlinkType;
#if haxe4
import Promise;
#else
import js.Promise;
#end

@:jsRequire("fs", "promises") @valueModuleOnly extern class Promises {
	/**
		Asynchronously tests a user's permissions for the file specified by path.
	**/
	static function access(path:FsPath, ?mode:FsConstant):Promise<Void>;

	/**
		Asynchronously copies `src` to `dest`. By default, `dest` is overwritten if it already exists.
		Node.js makes no guarantees about the atomicity of the copy operation.
		If an error occurs after the destination file has been opened for writing, Node.js will attempt
		to remove the destination.
	**/
	static function copyFile(src:FsPath, dest:FsPath, ?flags:FsConstants):Promise<Void>;

	/**
		* REVIEW i let those with FileHandle i have not think for it
				Asynchronous open(2) - open and possibly create a file.
	**/
	/*
		static function open(path:FsPath, flags:FsOpenFlag, ?mode:FsMode):Promise<node.fs.promises.FileHandle>;
	 */
	/**
		* REVIEW
				Asynchronously reads data from the file referenced by the supplied `FileHandle`.
	**/
	/*
		static function read<TBuffer>(handle:node.fs.promises.FileHandle, buffer:TBuffer, ?offset:Float, ?length:Float, ?position:Float):Promise<{
			var bytesRead:Float;
			var buffer:TBuffer;
		}>;
	 */
	/**
		* REVIEW
				Asynchronously writes `buffer` to the file referenced by the supplied `FileHandle`.
				It is unsafe to call `fsPromises.write()` multiple times on the same file without waiting for the `Promise`
				to be resolved (or rejected). For this scenario, `fs.createWriteStream` is strongly recommended.

				Asynchronously writes `string` to the file referenced by the supplied `FileHandle`.
				It is unsafe to call `fsPromises.write()` multiple times on the same file without waiting for the `Promise`
				to be resolved (or rejected). For this scenario, `fs.createWriteStream` is strongly recommended.
	**/
	/*
		@:overload(function(handle:node.fs.promises.FileHandle, string:String, ?position:Float, ?encoding:global.BufferEncoding):Promise<{
			var bytesWritten:Float;
			var buffer:String;
		}> {})
		static function write<TBuffer>(handle:node.fs.promises.FileHandle, buffer:TBuffer, ?offset:Float, ?length:Float, ?position:Float):Promise<{
			var bytesWritten:Float;
			var buffer:TBuffer;
		}>;
	 */
	/**
		Asynchronous rename(2) - Change the name or location of a file or directory.
	**/
	static function rename(oldPath:FsPath, newPath:FsPath):Promise<Void>;

	/**
		Asynchronous truncate(2) - Truncate a file to a specified length.
	**/
	static function truncate(path:FsPath, ?len:Int):Promise<Void>;

	/**
		* REVIEW i let those with FileHandle i have not think for it
		Asynchronous ftruncate(2) - Truncate a file to a specified length.
	**/
	/*
		static function ftruncate(handle:node.fs.promises.FileHandle, ?len:Float):Promise<Void>;
	 */
	/**
		Asynchronous rmdir(2) - delete a directory.
	**/
	static function rmdir(path:FsPath, ?options:FsRmdirOptions):Promise<Void>;

	/**
		REVIEW should add in non promise fs class too ( rm was added in v14 https://nodejs.org/api/fs.html#fs_fs_rm_path_options_callback)
		added FsRmOptions in Fs class
		Asynchronously removes files and directories (modeled on the standard POSIX `rm` utility).
	**/
	static function rm(path:FsPath, ?options:FsRmOptions):Promise<Void>;

	/**
		* REVIEW i let those with FileHandle i have not think for it
		Asynchronous fdatasync(2) - synchronize a file's in-core state with storage device.
	**/
	/*
		static function fdatasync(handle:node.fs.promises.FileHandle):Promise<Void>;
	 */
	/**
		* REVIEW i let those with FileHandle i have not think for it
		Asynchronous fsync(2) - synchronize a file's in-core state with the underlying storage device.
	**/
	/*
		static function fsync(handle:node.fs.promises.FileHandle):Promise<Void>;
	 */
	/**
		REVIEW change depend of pull request #175
		Asynchronous mkdir(2) - create a directory.
	**/
	@:overload(function(path:FsPath, ?options:ts.AnyOf3<String, Float, Dynamic>):Promise<Void> {})
	@:overload(function(path:FsPath, ?options:ts.AnyOf3<String, Float, MakeDirectoryOptions>):Promise<Null<String>> {})
	static function mkdir(path:FsPath, options:Dynamic):Promise<String>;

	/**
		Asynchronous readdir(3) - read a directory.
	**/
	static function readdir(path:FsPath, ?options:DynamicAccess<String>):Promise<Array<String>>;

	/**
		Asynchronous readlink(2) - read value of a symbolic link.
	**/
	static function readlink(path:FsPath, ?options:DynamicAccess<String>):Promise<String>;

	/**
		Asynchronous symlink(2) - Create a new symbolic link to an existing file.
	**/
	static function symlink(target:FsPath, path:FsPath, ?type:SymlinkType):Promise<Void>;

	/**
		* REVIEW i let those with FileHandle i have not think for it
		Asynchronous fstat(2) - Get file status.
	**/
	/*
		static function fstat(handle:node.fs.promises.FileHandle):Promise<Stats>;
	 */
	/**
		Asynchronous lstat(2) - Get file status. Does not dereference symbolic links.
	**/
	static function lstat(path:FsPath):Promise<Stats>;

	/**
		Asynchronous stat(2) - Get file status.
	**/
	static function stat(path:FsPath):Promise<Stats>;

	/**
		Asynchronous link(2) - Create a new link (also known as a hard link) to an existing file.
	**/
	static function link(existingPath:FsPath, newPath:FsPath):Promise<Void>;

	/**
		Asynchronous unlink(2) - delete a name and possibly the file it refers to.
	**/
	static function unlink(path:FsPath):Promise<Void>;

	/**
		* REVIEW i let those with FileHandle i have not think for it
		Asynchronous fchmod(2) - Change permissions of a file.
	**/
	/*
		static function fchmod(handle:node.fs.promises.FileHandle, mode:FsMode):Promise<Void>;
	 */
	/**
		Asynchronous chmod(2) - Change permissions of a file.
	**/
	static function chmod(path:FsPath, mode:FsMode):Promise<Void>;

	/**
		Asynchronous lchmod(2) - Change permissions of a file. Does not dereference symbolic links.
	**/
	static function lchmod(path:FsPath, mode:FsMode):Promise<Void>;

	/**
		Asynchronous lchown(2) - Change ownership of a file. Does not dereference symbolic links.
	**/
	static function lchown(path:FsPath, uid:Float, gid:Float):Promise<Void>;

	/**
		Changes the access and modification times of a file in the same way as `fsPromises.utimes()`,
		with the difference that if the path refers to a symbolic link, then the link is not
		dereferenced: instead, the timestamps of the symbolic link itself are changed.
	**/
	static function lutimes(path:FsPath, atime:Date, mtime:Date):Promise<Void>;

	/**
		* REVIEW i let those with FileHandle i have not think for it
		Asynchronous fchown(2) - Change ownership of a file.
	**/
	/*
		static function fchown(handle:node.fs.promises.FileHandle, uid:Float, gid:Float):Promise<Void>;
	 */
	/**
		Asynchronous chown(2) - Change ownership of a file.
	**/
	static function chown(path:FsPath, uid:Float, gid:Float):Promise<Void>;

	/**
		Asynchronously change file timestamps of the file referenced by the supplied path.
	**/
	static function utimes(path:FsPath, atime:Date, mtime:Date):Promise<Void>;

	/**
		* REVIEW i let those with FileHandle i have not think for it
		Asynchronously change file timestamps of the file referenced by the supplied `FileHandle`.
	**/
	/*
		static function futimes(handle:node.fs.promises.FileHandle, atime:Date, mtime:Date):Promise<Void>;
	 */
	/**
		Asynchronous realpath - return the canonicalized absolute pathname.
	**/
	static function realpath(path:FsPath, ?option:DynamicAccess<String>):Promise<String>;

	/**
		Asynchronously creates a unique temporary directory.
		Generates six random characters to be appended behind a required `prefix` to create a unique temporary directory.
	**/
	static function mkdtemp(prefix:String, ?option:DynamicAccess<String>):Promise<String>;

	/**
		Asynchronously writes data to a file, replacing the file if it already exists.
		It is unsafe to call `fsPromises.writeFile()` multiple times on the same file without waiting for the `Promise` to be resolved (or rejected).
	**/
	/*
		static function writeFile(path:ts.AnyOf4<String, global.Buffer, node.url.URL, node.fs.promises.FileHandle>, data:ts.AnyOf2<String, js.lib.Uint8Array>,
			?options:ts.AnyOf2<String, BaseEncodingOptions & {
				@:optional var mode:FsMode;
				@:optional var flag:ts.AnyOf2<String, Float>;
			}>):Promise<Void>;
	 */
	/**
		Asynchronously append data to a file, creating the file if it does not exist.
	**/
	/*
		static function appendFile(path:ts.AnyOf4<String, global.Buffer, node.url.URL, node.fs.promises.FileHandle>, data:ts.AnyOf2<String, js.lib.Uint8Array>,
			?options:ts.AnyOf2<String, BaseEncodingOptions & {
				@:optional var mode:FsMode;
				@:optional var flag:ts.AnyOf2<String, Float>;
			}>):Promise<Void>;
	 */
	/**
		Asynchronously reads the entire contents of a file.

		Asynchronously reads the entire contents of a file.

		Asynchronously reads the entire contents of a file.
	**/
	/*
		@:overload(function(path:ts.AnyOf4<String, global.Buffer, node.url.URL, node.fs.promises.FileHandle>,
			options:ts.AnyOf2<String, {var encoding:global.BufferEncoding; @:optional var flag:ts.AnyOf2<String, Float>;}>):Promise<String> {})
		@:overload(function(path:ts.AnyOf4<String, global.Buffer, node.url.URL, node.fs.promises.FileHandle>,
			?options:ts.AnyOf2<String, BaseEncodingOptions & {@:optional var flag:ts.AnyOf2<String, Float>;}>):Promise<ts.AnyOf2<String, global.Buffer>> {})
		static function readFile(path:ts.AnyOf4<String, global.Buffer, node.url.URL, node.fs.promises.FileHandle>,
			?options:{@:optional var encoding:Any; @:optional var flag:ts.AnyOf2<String, Float>;}):Promise<global.Buffer>;
	 */
	/*
		REVIEW this method is missing we should consider adding it
		static function opendir(path:String, ?options:OpenDirOptions):Promise<Dir>;
	 */
}
