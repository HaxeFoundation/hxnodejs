package js.node;

/**
	StringDecoder decodes a buffer to a string.
	It is a simple interface to buffer.toString() but provides additional support for utf8.
**/
@:jsRequire("string_decoder", "StringDecoder")
extern class StringDecoder {
	/**
		`encoding` defaults to `utf8`
	**/
	function new(?encoding:String);

	/**
		Returns a decoded string.
	**/
	function write(buffer:Buffer):String;

	/**
		Returns any trailing bytes that were left in the buffer.
	**/
	function end():String;
}
