package js.node;

import js.node.Buffer;

typedef ZlibOptions = {
	/**
		default: `Zlib.Z_NO_FLUSH`
	**/
	@:optional var flush:Int;

	/**
		default: 16*1024
	**/
	@:optional var chunkSize:Int;

	@:optional var windowBits:Int;

	/**
		compression only
	**/
	@:optional var level:Int;

	/**
		compression only
	**/
	@:optional var memLevel:Int;

	/**
		compression only
	**/
	@:optional var strategy:Int;

	/**
		deflate/inflate only, empty dictionary by default
	**/
	@:optional var dictionary:Buffer;
}

/**
	This provides bindings to Gzip/Gunzip, Deflate/Inflate, and DeflateRaw/InflateRaw classes.
	Each class takes the same options, and is a readable/writable Stream.
**/
@:jsRequire("zlib")
extern class Zlib {

	/**
		Allowed `flush` values.
	**/
	static var Z_NO_FLUSH(default,null):Int;
	static var Z_PARTIAL_FLUSH(default,null):Int;
	static var Z_SYNC_FLUSH(default,null):Int;
	static var Z_FULL_FLUSH(default,null):Int;
	static var Z_FINISH(default,null):Int;
	static var Z_BLOCK(default,null):Int;
	static var Z_TREES(default,null):Int;

	/**
		Return codes for the compression/decompression functions.
		Negative values are errors, positive values are used for special but normal events.
	**/
	static var Z_OK(default,null):Int;
	static var Z_STREAM_END(default,null):Int;
	static var Z_NEED_DICT(default,null):Int;
	static var Z_ERRNO(default,null):Int;
	static var Z_STREAM_ERROR(default,null):Int;
	static var Z_DATA_ERROR(default,null):Int;
	static var Z_MEM_ERROR(default,null):Int;
	static var Z_BUF_ERROR(default,null):Int;
	static var Z_VERSION_ERROR(default,null):Int;

	/**
		Compression levels.
	**/
	static var Z_NO_COMPRESSION(default,null):Int;
	static var Z_BEST_SPEED(default,null):Int;
	static var Z_BEST_COMPRESSION(default,null):Int;
	static var Z_DEFAULT_COMPRESSION(default,null):Int;

	/**
		Compression strategy.
	**/
	static var Z_FILTERED(default,null):Int;
	static var Z_HUFFMAN_ONLY(default,null):Int;
	static var Z_RLE(default,null):Int;
	static var Z_FIXED(default,null):Int;
	static var Z_DEFAULT_STRATEGY(default,null):Int;

	/**
		Possible values of the data_type field.
	**/
	static var Z_BINARY(default,null):Int;
	static var Z_TEXT(default,null):Int;
	static var Z_ASCII(default,null):Int;
	static var Z_UNKNOWN(default,null):Int;

	/**
		The deflate compression method (the only one supported in this version).
	**/
	static var Z_DEFLATED(default,null):Int;

	/**
		For initializing zalloc, zfree, opaque.
	**/
	static var Z_NULL(default,null):Int;

	static var createGzip			: Dynamic;//	([options])
	static var createGunzip			: Dynamic;//	([options])
	static var createDeflate		: Dynamic;//	([options])
	static var createInflate		: Dynamic;//	([options])
	static var createDeflateRaw		: Dynamic;//	([options])
	static var createInflateRaw		: Dynamic;//	([options])
	static var createUnzip			: Dynamic;//	([options])


	static var deflate			: Dynamic;//	(buf, callback)
	static var deflateRaw		: Dynamic;//	(buf, callback)
	static var gzip				: Dynamic;//	(buf, callback)
	static var gunzip			: Dynamic;//	(buf, callback)
	static var inflate			: Dynamic;//	(buf, callback)
	static var inflateRaw		: Dynamic;//	(buf, callback)
	static var unzip			: Dynamic;//	(buf, callback)


}


/**
 * Not exported by the zlib module. It is documented here because it is the base class of the compressor/decompressor classes.
 */
extern class BaseZLib
{
	/**
	 * Flush pending data. Don't call this frivolously, premature flushes negatively impact the effectiveness of the compression algorithm.
	 * @param	callback
	 */
	function flush(callback:Dynamic):Void;

	/**
	 * Reset the compressor/decompressor to factory defaults. Only applicable to the inflate and deflate algorithms.
	 */
	function reset():Void;
}


@:native("(require('zlib')).GZip") 			extern class Gzip extends BaseZLib { }
@:native("(require('zlib')).Gunzip") 		extern class Gunzip extends BaseZLib { }
@:native("(require('zlib')).Deflate") 		extern class Deflate extends BaseZLib { }
@:native("(require('zlib')).Inflate") 		extern class Inflate extends BaseZLib { }
@:native("(require('zlib')).DeflateRaw") 	extern class DeflateRaw extends BaseZLib { }
@:native("(require('zlib')).InflateRaw") 	extern class InflateRaw extends BaseZLib { }
@:native("(require('zlib')).Unzip") 		extern class Unzip extends BaseZLib { }

