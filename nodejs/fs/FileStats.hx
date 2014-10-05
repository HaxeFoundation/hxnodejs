package nodejs.fs;

/**
 * Objects returned from fs.stat(), fs.lstat() and fs.fstat() and their synchronous counterparts are of this type.
 * Please note that atime, mtime and ctime are instances of Date object and to compare the values of these objects you should use appropriate methods. 
 * For most general uses getTime() will return the number of milliseconds elapsed since 1 January 1970 00:00:00 UTC 
 * and this integer should be sufficient for any comparison, however there additional methods which can be used for displaying fuzzy information.
 * More details can be found in the MDN JavaScript Reference page.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class FileStats
{
	
	/**
	 * 
	 */
	var dev:Int;
	
	/**
	 * 
	 */
	var ino:Int;
	
	/**
	 * 
	 */
	var mode:Int;
	
	/**
	 * 
	 */
	var nlink:Int;
	
	/**
	 * 
	 */
	var uid:Int;
	
	/**
	 * 
	 */
	var gid:Int; 
	
	/**
	 * 
	 */
	var rdev:Int;
	
	/**
	 * 
	 */
	var size:Int;
	
	/**
	 * 
	 */
	var blksize:Int;
	
	/**
	 * 
	 */
	var blocks:Int;
	
	/**
	 * 
	 */
	var atime:Date;
	
	/**
	 * 
	 */
	var mtime:Date;
	
	/**
	 * 
	 */
	var ctime:Date;
  

	/**
	 * 
	 * @return
	 */
	function isFile():Bool;
	
	/**
	 * 
	 * @return
	 */
	function isDirectory():Bool;
	
	/**
	 * 
	 * @return
	 */
	function isBlockDevice():Bool;
	
	/**
	 * 
	 * @return
	 */
	function isCharacterDevice():Bool;
	
	/**
	 * (only valid with fs.lstat())
	 * @return
	 */
	function isSymbolicLink():Bool; 
	
	/**
	 * 
	 * @return
	 */
	function isFIFO():Bool;
	
	/**
	 * 
	 * @return
	 */
	function isSocket():Bool;
	
		
	
}