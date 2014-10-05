package nodejs;

/**
 * This module contains utilities for handling and transforming file paths. 
 * Almost all these methods perform only string transformations. 
 * The file system is not consulted to check whether paths are valid.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('path'))")
extern class Path
{
	
	var normalize		: Dynamic;//		(p)
	var join			: Dynamic;//		([path1], [path2], [...])
	var resolve			: Dynamic;//		([from ...], to)
	var relative		: Dynamic;//		(from, to)
	var dirname			: Dynamic;//		(p)
	var basename		: Dynamic;//		(p, [ext])
	var extname			: Dynamic;//		(p)
	
	/**
	 * The platform-specific file separator. '\\' or '/'.
	 */
	var sep             : String;
	
	/**
	 * The platform-specific path delimiter, ; or ':'.
	 */
	var delimiter       : String;

	
	
}