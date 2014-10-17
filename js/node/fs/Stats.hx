package js.node.fs;

/**
	Objects returned from `Fs.stat`, `Fs.lstat` and `Fs.fstat` and their synchronous counterparts are of this type.
**/
extern class Stats {
	var dev:Int;
	var ino:Int;
	var mode:Int;
	var nlink:Int;
	var uid:Int;
	var gid:Int;
	var rdev:Int;
	var size:Int;
	var blksize:Int;
	var blocks:Int;
	var atime:Date;
	var mtime:Date;
	var ctime:Date;
	function isFile():Bool;
	function isDirectory():Bool;
	function isBlockDevice():Bool;
	function isCharacterDevice():Bool;
	function isSymbolicLink():Bool;
	function isFIFO():Bool;
	function isSocket():Bool;
}
