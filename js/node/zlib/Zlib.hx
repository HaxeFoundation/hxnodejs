package js.node.zlib;

/**
	Not exported by the zlib module.
	It is documented here because it is the base class of the compressor/decompressor classes.
**/
extern class Zlib extends js.node.stream.Transform {
	/**
		Flush pending data.
		Don't call this frivolously, premature flushes negatively impact the effectiveness of the compression algorithm.
	**/
	function flush(callback:Void->Void):Void;

	/**
		Reset the compressor/decompressor to factory defaults.
		Only applicable to the inflate and deflate algorithms.
	**/
	function reset():Void;
}
