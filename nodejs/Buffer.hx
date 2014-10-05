package nodejs;
import js.html.ArrayBufferView;

/**
 * Work around for the INSPECT_MAX_BYTES attribute.
 */
@:native("(require('buffer'))")
extern class BufferConst
{
	/**
	 * Number, Default: 50
	 * How many bytes will be returned when buffer.inspect() is called. This can be overridden by user modules.
	 * Note that this is a property on the buffer module returned by require('buffer'),
	 * not on the Buffer global, or a buffer instance.
	 */
	static var INSPECT_MAX_BYTES : Int;
}

/**
 * The Buffer class is a global type for dealing with binary data directly. It can be constructed in a variety of ways.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("Buffer")
extern class Buffer implements ArrayAccess<Int>
{
	
	/**
	 * 
	 * @param	p_encoding
	 * @return
	 */
	static function isEncoding(p_encoding:String):Bool;
	
	/**
	 * 
	 * @param	p_obj
	 * @return
	 */
	static function isBuffer(p_obj:Dynamic):Bool;
	
	/**
	 * 
	 * @param	p_string
	 * @param	p_encoding
	 * @return
	 */
	@:overload(function (p_string:String):Int{})
	static function byteLength(p_string:String, p_encoding:String):Int;
	
	
	/**
	 * 
	 * @param	p_list
	 * @param	p_total_length
	 * @return
	 */
	@:overload(function (p_list:Array<Dynamic>):Int{})
	static function concat(p_list:Array<Dynamic>, p_total_length:Int):Dynamic;
	
	/**
	 * 
	 * @param	p_size
	 */
	@:overload(function(p_string:String):Void{})
	@:overload(function(p_string:String,p_encoding:String):Void{})
	@:overload(function(p_array:ArrayBufferView):Void{})
	function new(p_size:Int):Void;
	
	/**
	 * 
	 */
	var length : Int;
	
	/**
	 * 
	 * @return
	 */
	function toJSON():Dynamic;
	
	
	
	
	
	var write			: Dynamic;			//(string, [offset], [length], [encoding])
	var toString		: Dynamic;			//([encoding], [start], [end])	
	var copy			: Dynamic;			//(targetBuffer, [targetStart], [sourceStart], [sourceEnd])
	var slice			: Dynamic;			//([start], [end])
	var readUInt8		: Dynamic;			//(offset, [noAssert])
	var readUInt16LE	: Dynamic;			//(offset, [noAssert])
	var readUInt16BE	: Dynamic;			//(offset, [noAssert])
	var readUInt32LE	: Dynamic;			//(offset, [noAssert])
	var readUInt32BE	: Dynamic;			//(offset, [noAssert])
	var readInt8   		: Dynamic;			//(offset, [noAssert])
	var readInt16LE		: Dynamic;			//(offset, [noAssert])
	var readInt16BE		: Dynamic;			//(offset, [noAssert])
	var readInt32LE		: Dynamic;			//(offset, [noAssert])
	var readInt32BE		: Dynamic;			//(offset, [noAssert])
	var readFloatLE		: Dynamic;			//(offset, [noAssert])
	var readFloatBE		: Dynamic;			//(offset, [noAssert])
	var readDoubleLE	: Dynamic;			//(offset, [noAssert])
	var readDoubleBE	: Dynamic;			//(offset, [noAssert])
	var writeUInt8		: Dynamic;			//(value, offset, [noAssert])
	var writeUInt16LE	: Dynamic;			//(value, offset, [noAssert])
	var writeUInt16BE	: Dynamic;			//(value, offset, [noAssert])
	var writeUInt32LE	: Dynamic;			//(value, offset, [noAssert])
	var writeUInt32BE	: Dynamic;			//(value, offset, [noAssert])
	var writeInt8		: Dynamic;			//(value, offset, [noAssert])
	var writeInt16LE	: Dynamic;			//(value, offset, [noAssert])
	var writeInt16BE	: Dynamic;			//(value, offset, [noAssert])
	var writeInt32LE	: Dynamic;			//(value, offset, [noAssert])
	var writeInt32BE	: Dynamic;			//(value, offset, [noAssert])
	var writeFloatLE	: Dynamic;			//(value, offset, [noAssert])
	var writeFloatBE	: Dynamic;			//(value, offset, [noAssert])
	var writeDoubleLE	: Dynamic;			//(value, offset, [noAssert])
	var writeDoubleBE	: Dynamic;			//(value, offset, [noAssert])
	var fill			: Dynamic;			//(value, [offset], [end])
	

	
	
}