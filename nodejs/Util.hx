package nodejs;

/**
 * These functions are in the module 'util'. Use require('util') to access them.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('util'))")
extern class Util
{
	var format			: Dynamic;//		(format, [...])
	var debug			: Dynamic;//		(string)
	var error			: Dynamic;//		([...])
	var puts			: Dynamic;//		([...])
	var print			: Dynamic;//		([...])
	var log				: Dynamic;//		(string)
	var inspect			: Dynamic;//		(object, [options])	
	var isArray			: Dynamic;//		(object)
	var isRegExp		: Dynamic;//		(object)
	var isDate			: Dynamic;//		(object)
	var isError			: Dynamic;//		(object)
	var pump			: Dynamic;//		(readableStream, writableStream, [callback])
	var inherits		: Dynamic;//		(constructor, superConstructor)
	
}