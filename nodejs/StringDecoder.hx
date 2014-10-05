package nodejs;

/**
 * To use this module, do require('string_decoder'). StringDecoder decodes a buffer to a string. It is a simple interface to buffer.toString() but provides additional support for utf8.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('string_decoder'))")
extern class StringDecoder
{
	
	/**
	 * Accepts a single argument, encoding which defaults to utf8.
	 * @param	p_encoding
	 */
	@:overload(function():Void { } )	
	function new(p_encoding:String):Void;

	/**
	 * Returns a decoded string.
	 * @param	p_buffer
	 * @return
	 */
	function write(p_buffer:Buffer):String;
	
	/**
	 * Returns any trailing bytes that were left in the buffer.
	 * @return
	 */
	function end():Buffer;
	
}