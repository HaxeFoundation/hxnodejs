/*
 * Copyright (C)2014-2019 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package js.node.buffer;

#if haxe4
import js.lib.ArrayBuffer;
import js.lib.Uint8Array;
import js.lib.Object;
#else
import js.html.ArrayBuffer;
import js.html.Uint8Array;
#end
import haxe.extern.EitherType;

/**
	The `Buffer` class is a global type for dealing with binary data directly. It can be constructed in a variety of ways.

	@see https://nodejs.org/api/buffer.html#buffer_class_buffer
**/
@:jsRequire("buffer", "Buffer")
extern class Buffer extends Uint8Array {
	/**
		Stability: 0 - Deprecated: Use Buffer.from(array) instead.
		Allocates a new `Buffer` using an `array` of octets.

		@see https://nodejs.org/api/buffer.html#buffer_new_buffer_array

		Stability: 0 - Deprecated: Use Buffer.from(arrayBuffer[, byteOffset[, length]]) instead.
		This creates a view of the ArrayBuffer or SharedArrayBuffer without copying the underlying memory.
		For example, when passed a reference to the `.buffer` property of a TypedArray instance,
		the newly created `Buffer` will share the same allocated memory as the TypedArray.

		@see https://nodejs.org/api/buffer.html#buffer_new_buffer_arraybuffer_byteoffset_length

		Stability: 0 - Deprecated: Use Buffer.from(buffer) instead.
		Copies the passed `buffer` data onto a new `Buffer` instance.

		@see https://nodejs.org/api/buffer.html#buffer_new_buffer_buffer

		Stability: 0 - Deprecated: Use Buffer.alloc() instead (also see Buffer.allocUnsafe()).
		Allocates a new `Buffer` of `size` bytes. If `size` is larger than buffer.constants.MAX_LENGTH or smaller than 0,
		ERR_INVALID_OPT_VALUE is thrown. A zero-length `Buffer` is created if `size` is 0.

		@see https://nodejs.org/api/buffer.html#buffer_new_buffer_size

		Stability: 0 - Deprecated: Use Buffer.from(string[, encoding]) instead.
		Creates a new `Buffer` containing `string`. The `encoding` parameter identifies the character encoding of `string`.

		@see https://nodejs.org/api/buffer.html#buffer_new_buffer_string_encoding
	**/
	@:overload(function(array:Array<Int>):Void {})
	@:overload(function(arrayBuffer:ArrayBuffer, ?byteOffset:Int, ?length:Int):Void {})
	@:overload(function(buffer:Buffer):Void {})
	@:overload(function(size:Int):Void {})
	function new(string:String, ?encoding:String):Void;

	/**
		Allocates a new `Buffer` of `size` bytes. If `fill` is `undefined`, the `Buffer` will be zero-filled.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_alloc_size_fill_encoding
	**/
	@:overload(function(size:Int, fill:EitherType<String, EitherType<Buffer, EitherType<Uint8Array, Int>>>, ?encoding:String):Buffer {})
	static function alloc(size:Int, ?fill:EitherType<String, EitherType<Buffer, EitherType<Uint8Array, Int>>>):Buffer;

	/**
		Allocates a new `Buffer` of `size` bytes. If `size` is larger than buffer.constants.MAX_LENGTH or smaller than 0,
		ERR_INVALID_OPT_VALUE is thrown. A zero-length `Buffer` is created if `size` is 0.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_allocunsafe_size
	**/
	static function allocUnsafe(size:Int):Buffer;

	/**
		Allocates a new `Buffer` of `size` bytes. If `size` is larger than buffer.constants.MAX_LENGTH or smaller than 0,
		ERR_INVALID_OPT_VALUE is thrown. A zero-length `Buffer` is created if `size` is 0.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_allocunsafeslow_size
	**/
	static function allocUnsafeSlow(size:Int):Buffer;

	/**
		Returns the actual byte length of a string.
		This is not the same as String.prototype.length since that returns the number of characters in a string.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_bytelength_string_encoding
	**/
	#if (haxe_ver >= 3.3)
	static function byteLength(string:EitherType<String, EitherType<Buffer, ArrayBuffer>>, ?encoding:String):Int;
	#end

	#if (haxe_ver >= 3.3)
	@:deprecated("In haxe 3.3+, use Buffer.byteLength instead!")
	#end
	inline static function _byteLength(string:String, ?encoding:String):Int
		return untyped Buffer['byteLength'](string, encoding);

	/**
		Compares `buf1` to `buf2` typically for the purpose of sorting arrays of `Buffer` instances. This is equivalent to calling buf1.compare(buf2).

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_compare_buf1_buf2
	**/
	@:native("compare")
	static function compareBuffers(buf1:Buffer, buf2:Buffer):Int;

	/**
		Returns a new `Buffer` which is the result of concatenating all the `Buffer` instances in the `list` together.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_concat_list_totallength
	**/
	static function concat(list:Array<Buffer>, ?totalLength:Int):Buffer;

	/**
		Allocates a new `Buffer` using an `array` of octets.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_from_array

		This creates a view of the ArrayBuffer without copying the underlying memory.
		For example, when passed a reference to the `.buffer` property of a TypedArray instance,
		the newly created `Buffer` will share the same allocated memory as the TypedArray.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_from_arraybuffer_byteoffset_length

		Copies the passed `buffer` data onto a new `Buffer` instance.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_from_buffer

		For objects whose `valueOf()` function returns a value not strictly equal to `object`,
		returns `Buffer.from(object.valueOf(), offsetOrEncoding, length)`.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_from_object_offsetorencoding_length

		Creates a new `Buffer` containing `string`. The `encoding` parameter identifies the character encoding of `string`.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_from_string_encoding
	**/
	@:overload(function(array:Array<Int>):Buffer {})
	@:overload(function(arrayBuffer:ArrayBuffer, ?byteOffset:Int, ?length:Int):Buffer {})
	@:overload(function(buffer:Buffer):Buffer {})
	@:overload(function(object:Object, ?offsetOrEncoding:EitherType<Int, String>):Buffer {})
	@:overload(function(object:Object, offsetOrEncoding:EitherType<Int, String>, ?length:Int):Buffer {})
	static function from(string:String, ?encoding:String):Buffer;

	/**
		Returns `true` if `obj` is a `Buffer`, `false` otherwise.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_isbuffer_obj
	**/
	static function isBuffer(obj:Dynamic):Bool;

	/**
		Returns `true` if `encoding` contains a supported character encoding, or `false` otherwise.

		@see https://nodejs.org/api/buffer.html#buffer_class_method_buffer_isencoding_encoding
	**/
	static function isEncoding(encoding:String):Bool;

	/**
		This is the size (in bytes) of pre-allocated internal `Buffer` instances used for pooling. This value may be modified.

		@see https://nodejs.org/api/buffer.html#buffer_class_property_buffer_poolsize
	**/
	static var poolSize:Int;

	/**
		The index operator [index] can be used to get and set the octet at position index in buf. The values refer to individual bytes, so the legal value range is between 0x00 and 0xFF (hex) or 0 and 255 (decimal).


	**/
	/**
		buf[index]

		The index operator `[index]` can be used to get and set the octet at position `index` in `buf`.
		The values refer to individual bytes, so the legal value range is between `0x00` and `0xFF` (hex) or `0` and `255` (decimal).

		@see https://nodejs.org/api/buffer.html#buffer_buf_index
	**/
	@:arrayAccess
	public inline function get(key:Int):Buffer {
		return this.get(key);
	}

	/**
		<ArrayBuffer> The underlying `ArrayBuffer` object based on which this Buffer object is created.

		@see https://nodejs.org/api/buffer.html#buffer_buf_buffer
		define on Uint8Array
	**/
	// var buffer:ArrayBuffer;

	/**
		Compares `buf` with `target` and returns a number indicating whether `buf` comes before, after,
		or is the same as `target` in sort order. Comparison is based on the actual sequence of bytes in each `Buffer`.

		@see https://nodejs.org/api/buffer.html#buffer_buf_compare_target_targetstart_targetend_sourcestart_sourceend
	**/
	@:overload(function(target:Buffer):Int {})
	@:overload(function(target:Buffer, targetStart:Int):Int {})
	@:overload(function(target:Buffer, targetStart:Int, targetEnd:Int):Int {})
	@:overload(function(target:Buffer, targetStart:Int, targetEnd:Int, sourceStart:Int):Int {})
	function compare(target:Buffer, targetStart:Int, targetEnd:Int, sourceStart:Int, sourceEnd:Int):Int;

	/**
		Copies data from a region of `buf` to a region in `target` even if the `target` memory region overlaps with `buf`.

		@see https://nodejs.org/api/buffer.html#buffer_buf_copy_target_targetstart_sourcestart_sourceend
	**/
	@:overload(function(targer:Buffer):Void {})
	@:overload(function(targer:Buffer, targetStart:Int):Void {})
	@:overload(function(targer:Buffer, targetStart:Int, sourceStart:Int):Void {})
	function copy(target:Buffer, targetStart:Int, sourceStart:Int, sourceEnd:Int):Void;

	/**
		Creates and returns an iterator of `[index, byte]` pairs from the contents of `buf`.

		@see https://nodejs.org/api/buffer.html#buffer_buf_entries
	**/
	function entries():Array<Dynamic>;

	/**
		Returns `true` if both `buf` and `otherBuffer` have exactly the same bytes, `false` otherwise.

		@see https://nodejs.org/api/buffer.html#buffer_buf_equals_otherbuffer
	**/
	function equals(otherBuffer:EitherType<Buffer, Uint8Array>):Bool;

	/**
		Fills `buf` with the specified `value`. If the `offset` and `end` are not given, the entire `buf` will be filled:

		@see https://nodejs.org/api/buffer.html#buffer_buf_fill_value_offset_end_encoding
	**/
	@:overlord(function(value:EitherType<String, EitherType<Buffer, EitherType<Uint8Array, Int>>>):Buffer {})
	@:overlord(function(value:EitherType<String, EitherType<Buffer, EitherType<Uint8Array, Int>>>, offset:Int):Buffer {})
	@:overlord(function(value:EitherType<String, EitherType<Buffer, EitherType<Uint8Array, Int>>>, offset:Int, end:Int):Buffer {})
	function fill(value:EitherType<String, EitherType<Buffer, EitherType<Uint8Array, Int>>>, offset:Int, end:Int, encoding:String):Buffer;

	/**
		Equivalent to buf.indexOf() !== -1.

		@see https://nodejs.org/api/buffer.html#buffer_buf_includes_value_byteoffset_encoding
	**/
	@:overlord(function(value:EitherType<String, EitherType<Buffer, EitherType<Uint8Array, Int>>>):Bool {})
	@:overlord(function(value:EitherType<String, EitherType<Buffer, EitherType<Uint8Array, Int>>>, byteOffset:Int):Bool {})
	@:overlord(function(value:EitherType<String, EitherType<Buffer, EitherType<Uint8Array, Int>>>, encoding:String):Bool {})
	function includes(value:EitherType<String, EitherType<Buffer, EitherType<Uint8Array, Int>>>, byteOffset:Int, encoding:String):Bool;

	/**
		Operates similar to `Array.indexOf` in that it returns either

		the starting index position of value in `Buffer` or -1 if the `Buffer` does not contain value.
		The value can be a String, Buffer or Number. Strings are by default interpreted as UTF8.
		Buffers will use the entire `Buffer` (to compare a partial `Buffer` use buf.slice()).
		Numbers can range from 0 to 255.
	**/
	@:overload(function(value:String, byteOffset:Int, ?encoding:String):Int {})
	@:overload(function(value:String, ?encoding:String):Int {})
	@:overload(function(value:Buffer, ?byteOffset:Int):Int {})
	function indexOf(value:Int, ?byteOffset:Int):Int;

	/**
		Creates and returns an iterator of `buf` keys (indices).

		@see https://nodejs.org/api/buffer.html#buffer_buf_keys
	**/
	function keys():Iterator<Int>;

	/**
		Identical to `indexOf`, but searches the `Buffer` from back to front instead of front to back.

		Returns the starting index position of value in `Buffer` or -1 if the `Buffer` does not contain value.
		The value can be a String, Buffer or Number. Strings are by default interpreted as UTF8.
		If `byteOffset` is provided, will return the last match that begins at or before `byteOffset`.
	**/
	@:overload(function(value:String, byteOffset:Int, ?encoding:String):Int {})
	@:overload(function(value:String, ?encoding:String):Int {})
	@:overload(function(value:Buffer, ?byteOffset:Int):Int {})
	function lastIndexOf(value:Int, ?byteOffset:Int):Int;

	/**
		Returns the amount of memory allocated for buf in bytes. This does not necessarily reflect the amount of "usable" data within buf.

		@see https://nodejs.org/api/buffer.html#buffer_buf_length
	**/
	// var length(default, null):Int;
	//
	//
	//
	//
	//
	// these functions need BigInt implementation.
	/**
		Reads a signed 64-bit integer from `buf` at the specified `offset` with the specified endian format
		(`readBigInt64BE()` returns big endian, `readBigInt64LE()` returns little endian).

		@see https://nodejs.org/api/buffer.html#buffer_buf_readbigint64be_offset
	**/
	// function readBigInt64BE(?offset:Int):Int;
	/**
		Reads a signed 64-bit integer from `buf` at the specified `offset` with the specified endian format
		(`readBigInt64BE()` returns big endian, `readBigInt64LE()` returns little endian).

		@see https://nodejs.org/api/buffer.html#buffer_buf_readbigint64le_offset
	**/
	//	function readBigInt64LE(?offset:Int):Int;
	/**
		Reads an unsigned 64-bit integer from `buf` at the specified `offset` with specified endian format
		(`readBigUInt64BE()` returns big endian, `readBigUInt64LE()` returns little endian).

		@see https://nodejs.org/api/buffer.html#buffer_buf_readbiguint64be_offset
	**/
	// function readBigUInt64BE(?offset:Int):Int;
	/**
		Reads an unsigned 64-bit integer from `buf` at the specified `offset` with specified endian format
		(`readBigUInt64BE()` returns big endian, `readBigUInt64LE()` returns little endian).

		@see https://nodejs.org/api/buffer.html#buffer_buf_readbiguint64le_offset
	**/
	// function readBigUInt64LE(?offset:Int):Int;

	/**
		Reads a 64 bit double from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readDoubleBE(offset:Int, ?noAssert:Bool):Float;

	/**
		Reads a 64 bit double from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readDoubleLE(offset:Int, ?noAssert:Bool):Float;

	/**
		Reads a 32 bit float from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readFloatBE(offset:Int, ?noAssert:Bool):Float;

	/**
		Reads a 32 bit float from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readFloatLE(offset:Int, ?noAssert:Bool):Float;

	/**
		Reads a signed 8 bit integer from the buffer at the specified `offset`.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.

		Works as `readUInt8`, except buffer contents are treated as two's complement signed values.
	**/
	function readInt8(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads a signed 16 bit integer from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.

		Works as `readUInt16BE`, except buffer contents are treated as two's complement signed values.
	**/
	function readInt16BE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads a signed 16 bit integer from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.

		Works as `readUInt16LE`, except buffer contents are treated as two's complement signed values.
	**/
	function readInt16LE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads a signed 32 bit integer from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.

		Works as `readUInt32BE`, except buffer contents are treated as two's complement signed values.
	**/
	function readInt32BE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads a signed 32 bit integer from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.

		Works as `readUInt32LE`, except buffer contents are treated as two's complement signed values.
	**/
	function readInt32LE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads an unsigned 8 bit integer from the buffer at the specified offset.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readUInt8(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads an unsigned 16 bit integer from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readUInt16BE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads an unsigned 16 bit integer from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readUInt16LE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads an unsigned 32 bit integer from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readUInt32BE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads an unsigned 32 bit integer from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readUInt32LE(offset:Int, ?noAssert:Bool):Int;

	/**
		Returns a new buffer which references the same memory as the old,
		but offset and cropped by the `start` (defaults to 0) and `end` (defaults to `buffer.length`) indexes.
		Negative indexes start from the end of the buffer.

		Modifying the new buffer slice will modify memory in the original buffer!
	**/
	function slice(?start:Int, ?end:Int):Buffer;

	/**
		Interprets the `Buffer` as an array of unsigned 16-bit integers and swaps the byte-order in-place.

		Throws a `RangeError` if the `Buffer` length is not a multiple of 16 bits.
		The method returns a reference to the `Buffer`, so calls can be chained.
	**/
	function swap16():Buffer;

	/**
		Interprets the `Buffer` as an array of unsigned 32-bit integers and swaps the byte-order in-place.

		Throws a `RangeError` if the `Buffer` length is not a multiple of 32 bits.
		The method returns a reference to the `Buffer`, so calls can be chained.
	**/
	function swap32():Buffer;

	/**
		Interprets the `Buffer` as an array of 64-bit numbers and swaps the byte-order in-place.

		Throws a `RangeError` if the `Buffer` length is not a multiple of 64 bits.
		The method returns a reference to the `Buffer`, so calls can be chained.
	**/
	function swap64():Buffer;

	/**
		Returns a JSON-representation of the `Buffer` instance.
	**/
	function toJSON():Dynamic;

	/**
		Decodes and returns a string from buffer data encoded with `encoding` (defaults to 'utf8')
		beginning at `start` (defaults to 0) and ending at `end` (defaults to `buffer.length`).
	**/
	@:overload(function(encoding:String, ?start:Int, ?end:Int):String {})
	function toString():String;

	/**
		Writes `string` to the buffer at `offset` using the given `encoding`.

		`offset` defaults to 0, encoding defaults to 'utf8'. `length` is the number of bytes to write.

		Returns number of octets written. If buffer did not contain enough space to fit the entire `string`,
		it will write a partial amount of the `string`. `length` defaults to `buffer.length - offset`.

		The method will not write partial characters.
	**/
	@:overload(function(string:String, offset:Int, length:Int, ?encoding:String):Int {})
	@:overload(function(string:String, offset:Int, ?encoding:String):Int {})
	function write(string:String, ?encoding:String):Int;

	// these functions need Bigint Implementation.
	/**
		Writes `value` to `buf` at the specified `offset` with specified endian format (`writeBigInt64BE()` writes big endian, `writeBigInt64LE()` writes little endian).

		@see https://nodejs.org/api/buffer.html#buffer_buf_writebigint64be_value_offset
	**/
	// function writeBigInt64BE(value:Int, ?offset:Int):Int;
	/**
		Writes `value` to `buf` at the specified `offset` with specified endian format (`writeBigInt64BE()` writes big endian, `writeBigInt64LE()` writes little endian).

		@see https://nodejs.org/api/buffer.html#buffer_buf_writebigint64le_value_offset
	**/
	// function writeBigInt64LE(value:Int, ?offset:Int):Int;

	/**
		Writes `value` to the buffer at the specified `offset` with big-endian format.
		Note, `value` must be a valid 64 bit double.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeDoubleBE(value:Float, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset` with little-endian format.
		Note, `value` must be a valid 64 bit double.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeDoubleLE(value:Float, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset` with big-endian format.
		Note, behavior is unspecified if `value` is not a 32 bit float.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeFloatBE(value:Float, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset` with little-endian format.
		Note, behavior is unspecified if `value` is not a 32 bit float.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeFloatLE(value:Float, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset`.
		Note, `value` must be a valid signed 8 bit integer.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.

		Works as `writeUInt8`, except `value` is written out as a two's complement signed integer into buffer.
	**/
	function writeInt8(value:Int, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset` with big-endian format.
		Note, value must be a valid signed 16 bit integer.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.

		Works as `writeUInt16BE`, except `value` is written out as a two's complement signed integer into buffer.
	**/
	function writeInt16BE(value:Int, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset` with little-endian format.
		Note, value must be a valid signed 16 bit integer.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.

		Works as `writeUInt16LE`, except `value` is written out as a two's complement signed integer into buffer.
	**/
	function writeInt16LE(value:Int, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset` with big-endian format.
		Note, value must be a valid signed 32 bit integer.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.

		Works as `writeUInt32BE`, except `value` is written out as a two's complement signed integer into buffer.
	**/
	function writeInt32BE(value:Int, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset` with little-endian format.
		Note, value must be a valid signed 32 bit integer.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.

		Works as `writeUInt32LE`, except `value` is written out as a two's complement signed integer into buffer.
	**/
	function writeInt32LE(value:Int, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset`.
		Note, `value` must be a valid unsigned 8 bit integer.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeUInt8(value:Int, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset` with big-endian format.
		Note, `value` must be a valid unsigned 16 bit integer.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeUInt16BE(value:Int, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset` with little-endian format.
		Note, `value` must be a valid unsigned 16 bit integer.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeUInt16LE(value:Int, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset` with big-endian format.
		Note, `value` must be a valid unsigned 32 bit integer.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeUInt32BE(value:Int, offset:Int, ?noAssert:Bool):Void;

	/**
		Writes `value` to the buffer at the specified `offset` with little-endian format.
		Note, `value` must be a valid unsigned 32 bit integer.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeUInt32LE(value:Int, offset:Int, ?noAssert:Bool):Void;

	/**
		How many bytes will be returned when `buffer.inspect()` is called.
		This can be overridden by user modules.
		Default: 50
	**/
	public static var INSPECT_MAX_BYTES(get, set):Int;

	private inline static function get_INSPECT_MAX_BYTES():Int {
		return js.Lib.require("buffer").INSPECT_MAX_BYTES;
	}
	private inline static function set_INSPECT_MAX_BYTES(value:Int):Int {
		return js.Lib.require("buffer").INSPECT_MAX_BYTES = value;
	}

	/**
		Maximum length of a `Buffer`.
	**/
	public static var kMaxLength(get, never):Int;

	private inline static function get_kMaxLength():Int {
		return js.Lib.require("buffer").kMaxLength;
	}

	/**
		Re-encodes the given `Buffer` or `Uint8Array` instance from one character encoding to another. Returns a new `Buffer` instance.

		@see https://nodejs.org/api/buffer.html#buffer_buffer_transcode_source_fromenc_toenc
	**/
	function transcode(source:haxe.extern.EitherType<Buffer, Uint8Array>, fromEnc:String, toEnc:String):Buffer;

	/**
		Create `haxe.io.Bytes` object that uses the same underlying data storage as `this` buffer.
		Any modifications done using the returned object will be reflected in the `this` buffer.
	**/
	inline function hxToBytes():haxe.io.Bytes {
		return Helper.bytesOfBuffer(this);
	}

	/**
		Create `Buffer` object from `haxe.io.Bytes` using the same underlying data storage.
		Any modifications done using the returned object will be reflected in given `haxe.io.Bytes` object.
	**/
	static inline function hxFromBytes(b:haxe.io.Bytes):Buffer {
		var data = @:privateAccess b.b;
		return Buffer.from(data.buffer, data.byteOffset, b.length);
	}
}

@:dce
private class Helper {
	public static function bytesOfBuffer(b:Buffer):haxe.io.Bytes untyped {
		var o = Object.create(haxe.io.Bytes.prototype);
		// the following is basically a haxe.io.Bytes constructor,
		// but using given buffer instead of creating new Uint8Array
		o.length = b.byteLength;
		o.b = b;
		b.bufferValue = b;
		b.hxBytes = o;
		b.bytes = b;
		return o;
	}
}
