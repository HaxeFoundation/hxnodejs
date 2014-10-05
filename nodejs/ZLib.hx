package nodejs;

/**
 * This provides bindings to Gzip/Gunzip, Deflate/Inflate, and DeflateRaw/InflateRaw classes. Each class takes the same options, and is a readable/writable Stream.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('zlib'))")
extern class ZLib
{
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
	 * @param	p_callback
	 */
	function flush(p_callback:Dynamic):Void;

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

