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

/**
	The Buffer class is a global type for dealing with binary data directly. It can be constructed in a variety of ways.

	It supports array access syntax to get and set the octet at index. The values refer to individual bytes,
	so the legal range is between 0x00 and 0xFF hex or 0 and 255.
**/
@:jsRequire("buffer", "Buffer")
extern class Buffer extends Uint8Array {

	/**
		How many bytes will be returned when `buffer.inspect()` is called.
		This can be overridden by user modules.
		Default: 50
	**/
	public static var INSPECT_MAX_BYTES(get,set):Int;
	private inline static function get_INSPECT_MAX_BYTES():Int {
		return js.Lib.require("buffer").INSPECT_MAX_BYTES;
	}
	private inline static function set_INSPECT_MAX_BYTES(value:Int):Int {
		return js.Lib.require("buffer").INSPECT_MAX_BYTES = value;
	}

	/**
		Maximum length of a `Buffer`.
	**/
	public static var kMaxLength(get,never):Int;
	private inline static function get_kMaxLength():Int {
		return js.Lib.require("buffer").kMaxLength;
	}

	/**
		Returns `true` if the encoding is a valid encoding argument, or `false` otherwise.
	**/
	static function isEncoding(encoding:String):Bool;

	/**
		Tests if `obj` is a `Buffer`.
	**/
	static function isBuffer(obj:Dynamic):Bool;

	/**
		Gives the actual byte length of a string.

		`encoding` defaults to 'utf8'.

		This is not the same as `String.length` since that
		returns the number of characters in a string.
	**/
	#if (haxe_ver >= 3.3)
	static function byteLength(string:String, ?encoding:String):Int;
	#end

	/**
		Gives the actual byte length of a string.

		`encoding` defaults to 'utf8'.

		This is not the same as `String.length` since that
		returns the number of characters in a string.
	**/
	#if (haxe_ver >= 3.3) @:deprecated("In haxe 3.3+, use Buffer.byteLength instead!") #end
	inline static function _byteLength(string:String, ?encoding:String):Int return untyped Buffer['byteLength'](string, encoding);

	/**
		Returns a buffer which is the result of concatenating all the buffers in the `list` together.

		If the `list` has no items, or if the `totalLength` is 0, then it returns a zero-length buffer.
		If the `list` has exactly one item, then the first item of the `list` is returned.
		If the `list` has more than one item, then a new `Buffer` is created.

		If `totalLength` is not provided, it is read from the buffers in the `list`.
		However, this adds an additional loop to the function, so it is faster to provide the length explicitly.
	**/
	static function concat(list:Array<Buffer>, ?totalLength:Int):Buffer;

	/**
		The same as `buf1.compare(buf2)`. Useful for sorting an Array of Buffers.
	**/
	@:native("compare")
	static function compareBuffers(buf1:Buffer, buf2:Buffer):Int;

	/**
		Allocates a new buffer.
	**/
	@:overload(function(string:String, ?encoding:String):Void {})
	@:overload(function(buffer:Buffer):Void {})
	@:overload(function(arrayBuffer:ArrayBuffer, ?byteOffset:Int, ?length:Int):Void {})
	@:overload(function(array:Array<Int>):Void {})
	function new(size:Int):Void;

	/**
		Allocates a new `Buffer` of `size` bytes.

		If `fill` is undefined, the `Buffer` will be zero-filled.

		Calling `Buffer.alloc(size)` can be significantly slower than the alternative `Buffer.allocUnsafe(size)`
		but ensures that the newly created `Buffer` instance contents will never contain sensitive data.
	**/
	@:overload(function(size:Int, fill:String, ?encoding:String):Buffer {})
	static function alloc(size:Int, ?fill:Int):Buffer;

	/**
		Allocates a new non-zero-filled `Buffer` of `size` bytes.

		The underlying memory for `Buffer` instances created in this way is not initialized.
		The contents of the newly created `Buffer` are unknown and may contain sensitive data.
		Use `buf.fill(0)` to initialize such `Buffer` instances to zeroes.
	**/
	static function allocUnsafe(size:Int):Buffer;

	/**
		Allocates a new non-zero-filled and non-pooled `Buffer` of `size` bytes.

		The underlying memory for `Buffer` instances created in this way is not initialized.
		The contents of the newly created `Buffer` are unknown and may contain sensitive data.
		Use `buf.fill(0)` to initialize such `Buffer` instances to zeroes.
	**/
	static function allocUnsafeSlow(size:Int):Buffer;

	@:overload(function(buffer:Buffer):Buffer {})
	@:overload(function(str:String, ?encoding:String):Buffer {})
	static function from(arrayBuffer:ArrayBuffer, ?byteOffset:Int, ?length:Int):Buffer;

	/**
		Returns a JSON-representation of the `Buffer` instance.
	**/
	function toJSON():Dynamic;

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

	/**
		Decodes and returns a string from buffer data encoded with `encoding` (defaults to 'utf8')
		beginning at `start` (defaults to 0) and ending at `end` (defaults to `buffer.length`).
	**/
	@:overload(function(encoding:String, ?start:Int, ?end:Int):String {})
	function toString():String;

	/**
		Does copy between buffers.
		The source and target regions can be overlapped.
		`targetStart` and `sourceStart` default to 0. `sourceEnd` defaults to `buffer.length`.
	**/
	function copy(targetBuffer:Buffer, ?targetStart:Int, ?sourceStart:Int, ?sourceEnd:Int):Void;

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
		Reads an unsigned 8 bit integer from the buffer at the specified offset.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readUInt8(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads an unsigned 16 bit integer from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readUInt16LE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads an unsigned 16 bit integer from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readUInt16BE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads an unsigned 32 bit integer from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readUInt32LE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads an unsigned 32 bit integer from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readUInt32BE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads a signed 8 bit integer from the buffer at the specified `offset`.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.

		Works as `readUInt8`, except buffer contents are treated as two's complement signed values.
	**/
	function readInt8(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads a signed 16 bit integer from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.

		Works as `readUInt16LE`, except buffer contents are treated as two's complement signed values.
	**/
	function readInt16LE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads a signed 16 bit integer from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.

		Works as `readUInt16BE`, except buffer contents are treated as two's complement signed values.
	**/
	function readInt16BE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads a signed 32 bit integer from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.

		Works as `readUInt32LE`, except buffer contents are treated as two's complement signed values.
	**/
	function readInt32LE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads a signed 32 bit integer from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.

		Works as `readUInt32BE`, except buffer contents are treated as two's complement signed values.
	**/
	function readInt32BE(offset:Int, ?noAssert:Bool):Int;

	/**
		Reads a 32 bit float from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readFloatLE(offset:Int, ?noAssert:Bool):Float;

	/**
		Reads a 32 bit float from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readFloatBE(offset:Int, ?noAssert:Bool):Float;

	/**
		Reads a 64 bit double from the buffer at the specified `offset` with little-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readDoubleLE(offset:Int, ?noAssert:Bool):Float;

	/**
		Reads a 64 bit double from the buffer at the specified `offset` with big-endian format.

		Set `noAssert` to `true` to skip validation of `offset`.
		This means that `offset` may be beyond the end of the buffer. Defaults to `false`.
	**/
	function readDoubleBE(offset:Int, ?noAssert:Bool):Float;

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
		Note, `value` must be a valid unsigned 32 bit integer.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeUInt32LE(value:Int, offset:Int, ?noAssert:Bool):Void;

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
		Note, behavior is unspecified if `value` is not a 32 bit float.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeFloatLE(value:Float, offset:Int, ?noAssert:Bool):Void;

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
		Note, `value` must be a valid 64 bit double.

		Set `noAssert` to `true` to skip validation of `value` and `offset`.
		This means that `value` may be too large for the specific function
		and `offset` may be beyond the end of the buffer leading to the values
		being silently dropped. This should not be used unless you are certain
		of correctness. Defaults to `false`.
	**/
	function writeDoubleBE(value:Float, offset:Int, ?noAssert:Bool):Void;

	/**
		Fills the buffer with the specified `value`.
		If the `offset` (defaults to 0) and `end` (defaults to `buffer.length`)
		are not given it will fill the entire buffer.

		The method returns a reference to the `Buffer`, so calls can be chained.
	**/
	@:overload(function(value:String, encoding:String):Buffer {})
	@:overload(function(value:String, offset:Int, encoding:String):Buffer {})
	@:overload(function(value:String, offset:Int, end:Int, encoding:String):Buffer {})
	@:overload(function(value:String, ?offset:Int, ?end:Int):Buffer {})
	function fill(value:Int, ?offset:Int, ?end:Int):Buffer;

	/**
		Returns a boolean of whether `this` and `otherBuffer` have the same bytes.
	**/
	function equals(otherBuffer:Buffer):Bool;

	/**
		Returns a number indicating whether `this` comes before or after or is the same as the `otherBuffer` in sort order.

		The optional `targetStart`, `targetEnd`, `sourceStart`, and `sourceEnd` arguments can be used
		to limit the comparison to specific ranges within the two `Buffer` objects.
	**/
	function compare(otherBuffer:Buffer, ?targetStart:Int, ?targetEnd:Int, ?sourceStart:Int, ?sourceEnd:Int):Int;

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
		Identical to `indexOf`, but searches the `Buffer` from back to front instead of front to back.

		Returns the starting index position of value in `Buffer` or -1 if the `Buffer` does not contain value.
		The value can be a String, Buffer or Number. Strings are by default interpreted as UTF8.
		If `byteOffset` is provided, will return the last match that begins at or before `byteOffset`.
	**/
	@:overload(function(value:String, byteOffset:Int, ?encoding:String):Int {})
	@:overload(function(value:String, ?encoding:String):Int {})
	@:overload(function(value:Buffer, ?byteOffset:Int):Int {})
	function lastIndexOf(value:Int, ?byteOffset:Int):Int;

	// TODO: we don't have Array.includes in Haxe yet, so the doc would be lying
	@:overload(function(value:String, byteOffset:Int, ?encoding:String):Bool {})
	@:overload(function(value:String, ?encoding:String):Bool {})
	@:overload(function(value:Buffer, ?byteOffset:Int):Bool {})
	function includes(value:Int, ?byteOffset:Int):Bool;

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
