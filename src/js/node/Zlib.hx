/*
 * Copyright (C)2014-2026 Haxe Foundation
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

package js.node;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.lib.ArrayBuffer;
import js.lib.ArrayBufferView;
import js.lib.Error;
import js.node.Buffer;
import js.node.zlib.*;

/**
	Input accepted by zlib convenience methods and `crc32`.

	@see https://nodejs.org/docs/latest-v24.x/api/zlib.html#convenience-methods
**/
typedef ZlibInput = EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>;

/**
	Binary dictionary for deflate/inflate and Zstd streams.

	@see https://nodejs.org/docs/latest-v24.x/api/zlib.html#class-options
**/
typedef ZlibDictionary = EitherType<ArrayBuffer, ArrayBufferView>;

/**
	Options for zlib-based streams (`Deflate`, `Inflate`, `Gzip`, etc.).

	@see https://nodejs.org/docs/latest-v24.x/api/zlib.html#class-options
**/
typedef ZlibOptions = {
	/**
		Default: `Zlib.constants.Z_NO_FLUSH`
	**/
	@:optional var flush:Int;

	/**
		Default: `Zlib.constants.Z_FINISH`
	**/
	@:optional var finishFlush:Int;

	/**
		Default: 16*1024
	**/
	@:optional var chunkSize:Int;

	@:optional var windowBits:Int;

	/**
		Compression only.
	**/
	@:optional var level:Int;

	/**
		Compression only.
	**/
	@:optional var memLevel:Int;

	/**
		Compression only.
	**/
	@:optional var strategy:Int;

	/**
		Deflate/inflate only; empty dictionary by default.
		Accepts `Buffer`, `TypedArray`, `DataView`, or `ArrayBuffer`.
	**/
	@:optional var dictionary:ZlibDictionary;

	/**
		Limits output size when using convenience methods.
		Default: `buffer.kMaxLength`
	**/
	@:optional var maxOutputLength:Int;

	/**
		If `true`, returns an object with `buffer` and `engine`.
		Default: `false`
	**/
	@:optional var info:Bool;
}

/**
	Options for Brotli compression and decompression.

	@see https://nodejs.org/docs/latest-v24.x/api/zlib.html#class-brotlioptions
**/
typedef BrotliOptions = {
	/**
		Default: `Zlib.constants.BROTLI_OPERATION_PROCESS`
	**/
	@:optional var flush:Int;

	/**
		Default: `Zlib.constants.BROTLI_OPERATION_FINISH`
	**/
	@:optional var finishFlush:Int;

	/**
		Default: 16*1024
	**/
	@:optional var chunkSize:Int;

	/**
		Key-value object containing indexed Brotli parameters
		(`BROTLI_PARAM_*` keys from `Zlib.constants`).
	**/
	@:optional var params:DynamicAccess<EitherType<Bool, Int>>;

	/**
		The maximum length of the output that can be produced by zlib streams.
		Default: `buffer.kMaxLength`
	**/
	@:optional var maxOutputLength:Int;

	/**
		If `true`, returns an object with `buffer` and `engine`.
		Default: `false`
	**/
	@:optional var info:Bool;
}

/**
	Options for Zstandard (zstd) compression and decompression.

	Stability: 1 - Experimental

	@see https://nodejs.org/docs/latest-v24.x/api/zlib.html#class-zstdoptions
**/
typedef ZstdOptions = {
	/**
		Default: `Zlib.constants.ZSTD_e_continue`
	**/
	@:optional var flush:Int;

	/**
		Default: `Zlib.constants.ZSTD_e_end`
	**/
	@:optional var finishFlush:Int;

	/**
		Default: 16*1024
	**/
	@:optional var chunkSize:Int;

	/**
		Key-value object containing indexed Zstd parameters
		(`ZSTD_c_*` / `ZSTD_d_*` keys from `Zlib.constants`).
	**/
	@:optional var params:DynamicAccess<EitherType<Bool, Int>>;

	/**
		The maximum length of the output that can be produced by zlib streams.
		Default: `buffer.kMaxLength`
	**/
	@:optional var maxOutputLength:Int;

	/**
		If `true`, returns an object with `buffer` and `engine`.
		Default: `false`
	**/
	@:optional var info:Bool;

	/**
		Optional dictionary used to improve compression efficiency.
	**/
	@:optional var dictionary:ZlibDictionary;

	/**
		Expected total size of the uncompressed input.
		If the size does not match, compression fails with `ZSTD_error_srcSize_wrong`.
	**/
	@:optional var pledgedSrcSize:Float;
}

/**
	All zlib constants available on `require("zlib").constants`.

	Prefer these over the deprecated top-level `Z_*` fields on `Zlib`.

	@see https://nodejs.org/docs/latest-v24.x/api/zlib.html#constants
**/
typedef ZlibConstants = {
	/**
		Zlib (deflate/inflate) constants from zlib.h.
	**/
	var Z_BEST_COMPRESSION:Int;
	var Z_BEST_SPEED:Int;
	var Z_BLOCK:Int;
	var Z_BUF_ERROR:Int;
	var Z_DATA_ERROR:Int;
	var Z_DEFAULT_CHUNK:Int;
	var Z_DEFAULT_COMPRESSION:Int;
	var Z_DEFAULT_LEVEL:Int;
	var Z_DEFAULT_MEMLEVEL:Int;
	var Z_DEFAULT_STRATEGY:Int;
	var Z_DEFAULT_WINDOWBITS:Int;
	var Z_ERRNO:Int;
	var Z_FILTERED:Int;
	var Z_FINISH:Int;
	var Z_FIXED:Int;
	var Z_FULL_FLUSH:Int;
	var Z_HUFFMAN_ONLY:Int;
	var Z_MAX_CHUNK:Int;
	var Z_MAX_LEVEL:Int;
	var Z_MAX_MEMLEVEL:Int;
	var Z_MAX_WINDOWBITS:Int;
	var Z_MEM_ERROR:Int;
	var Z_MIN_CHUNK:Int;
	var Z_MIN_LEVEL:Int;
	var Z_MIN_MEMLEVEL:Int;
	var Z_MIN_WINDOWBITS:Int;
	var Z_NEED_DICT:Int;
	var Z_NO_COMPRESSION:Int;
	var Z_NO_FLUSH:Int;
	var Z_OK:Int;
	var Z_PARTIAL_FLUSH:Int;
	var Z_RLE:Int;
	var Z_STREAM_END:Int;
	var Z_STREAM_ERROR:Int;
	var Z_SYNC_FLUSH:Int;
	var Z_VERSION_ERROR:Int;
	var ZLIB_VERNUM:Int;

	/**
		Brotli constants.
	**/
	var BROTLI_DECODE:Int;
	var BROTLI_DECODER_ERROR_ALLOC_BLOCK_TYPE_TREES:Int;
	var BROTLI_DECODER_ERROR_ALLOC_CONTEXT_MAP:Int;
	var BROTLI_DECODER_ERROR_ALLOC_CONTEXT_MODES:Int;
	var BROTLI_DECODER_ERROR_ALLOC_RING_BUFFER_1:Int;
	var BROTLI_DECODER_ERROR_ALLOC_RING_BUFFER_2:Int;
	var BROTLI_DECODER_ERROR_ALLOC_TREE_GROUPS:Int;
	var BROTLI_DECODER_ERROR_DICTIONARY_NOT_SET:Int;
	var BROTLI_DECODER_ERROR_FORMAT_BLOCK_LENGTH_1:Int;
	var BROTLI_DECODER_ERROR_FORMAT_BLOCK_LENGTH_2:Int;
	var BROTLI_DECODER_ERROR_FORMAT_CL_SPACE:Int;
	var BROTLI_DECODER_ERROR_FORMAT_CONTEXT_MAP_REPEAT:Int;
	var BROTLI_DECODER_ERROR_FORMAT_DICTIONARY:Int;
	var BROTLI_DECODER_ERROR_FORMAT_DISTANCE:Int;
	var BROTLI_DECODER_ERROR_FORMAT_EXUBERANT_META_NIBBLE:Int;
	var BROTLI_DECODER_ERROR_FORMAT_EXUBERANT_NIBBLE:Int;
	var BROTLI_DECODER_ERROR_FORMAT_HUFFMAN_SPACE:Int;
	var BROTLI_DECODER_ERROR_FORMAT_PADDING_1:Int;
	var BROTLI_DECODER_ERROR_FORMAT_PADDING_2:Int;
	var BROTLI_DECODER_ERROR_FORMAT_RESERVED:Int;
	var BROTLI_DECODER_ERROR_FORMAT_SIMPLE_HUFFMAN_ALPHABET:Int;
	var BROTLI_DECODER_ERROR_FORMAT_SIMPLE_HUFFMAN_SAME:Int;
	var BROTLI_DECODER_ERROR_FORMAT_TRANSFORM:Int;
	var BROTLI_DECODER_ERROR_FORMAT_WINDOW_BITS:Int;
	var BROTLI_DECODER_ERROR_INVALID_ARGUMENTS:Int;
	var BROTLI_DECODER_ERROR_UNREACHABLE:Int;
	var BROTLI_DECODER_NEEDS_MORE_INPUT:Int;
	var BROTLI_DECODER_NEEDS_MORE_OUTPUT:Int;
	var BROTLI_DECODER_NO_ERROR:Int;
	var BROTLI_DECODER_PARAM_DISABLE_RING_BUFFER_REALLOCATION:Int;
	var BROTLI_DECODER_PARAM_LARGE_WINDOW:Int;
	var BROTLI_DECODER_RESULT_ERROR:Int;
	var BROTLI_DECODER_RESULT_NEEDS_MORE_INPUT:Int;
	var BROTLI_DECODER_RESULT_NEEDS_MORE_OUTPUT:Int;
	var BROTLI_DECODER_RESULT_SUCCESS:Int;
	var BROTLI_DECODER_SUCCESS:Int;
	var BROTLI_DEFAULT_MODE:Int;
	var BROTLI_DEFAULT_QUALITY:Int;
	var BROTLI_DEFAULT_WINDOW:Int;
	var BROTLI_ENCODE:Int;
	var BROTLI_LARGE_MAX_WINDOW_BITS:Int;
	var BROTLI_MAX_INPUT_BLOCK_BITS:Int;
	var BROTLI_MAX_QUALITY:Int;
	var BROTLI_MAX_WINDOW_BITS:Int;
	var BROTLI_MIN_INPUT_BLOCK_BITS:Int;
	var BROTLI_MIN_QUALITY:Int;
	var BROTLI_MIN_WINDOW_BITS:Int;
	var BROTLI_MODE_FONT:Int;
	var BROTLI_MODE_GENERIC:Int;
	var BROTLI_MODE_TEXT:Int;
	var BROTLI_OPERATION_EMIT_METADATA:Int;
	var BROTLI_OPERATION_FINISH:Int;
	var BROTLI_OPERATION_FLUSH:Int;
	var BROTLI_OPERATION_PROCESS:Int;
	var BROTLI_PARAM_DISABLE_LITERAL_CONTEXT_MODELING:Int;
	var BROTLI_PARAM_LARGE_WINDOW:Int;
	var BROTLI_PARAM_LGBLOCK:Int;
	var BROTLI_PARAM_LGWIN:Int;
	var BROTLI_PARAM_MODE:Int;
	var BROTLI_PARAM_NDIRECT:Int;
	var BROTLI_PARAM_NPOSTFIX:Int;
	var BROTLI_PARAM_QUALITY:Int;
	var BROTLI_PARAM_SIZE_HINT:Int;

	/**
		Zstd constants (experimental).
	**/
	var ZSTD_btlazy2:Int;
	var ZSTD_btopt:Int;
	var ZSTD_btultra:Int;
	var ZSTD_btultra2:Int;
	var ZSTD_c_chainLog:Int;
	var ZSTD_c_checksumFlag:Int;
	var ZSTD_c_compressionLevel:Int;
	var ZSTD_c_contentSizeFlag:Int;
	var ZSTD_c_dictIDFlag:Int;
	var ZSTD_c_enableLongDistanceMatching:Int;
	var ZSTD_c_hashLog:Int;
	var ZSTD_c_jobSize:Int;
	var ZSTD_c_ldmBucketSizeLog:Int;
	var ZSTD_c_ldmHashLog:Int;
	var ZSTD_c_ldmHashRateLog:Int;
	var ZSTD_c_ldmMinMatch:Int;
	var ZSTD_c_minMatch:Int;
	var ZSTD_c_nbWorkers:Int;
	var ZSTD_c_overlapLog:Int;
	var ZSTD_c_searchLog:Int;
	var ZSTD_c_strategy:Int;
	var ZSTD_c_targetLength:Int;
	var ZSTD_c_windowLog:Int;
	var ZSTD_CLEVEL_DEFAULT:Int;
	var ZSTD_COMPRESS:Int;
	var ZSTD_d_windowLogMax:Int;
	var ZSTD_DECOMPRESS:Int;
	var ZSTD_dfast:Int;
	var ZSTD_e_continue:Int;
	var ZSTD_e_end:Int;
	var ZSTD_e_flush:Int;
	var ZSTD_error_checksum_wrong:Int;
	var ZSTD_error_corruption_detected:Int;
	var ZSTD_error_dictionary_corrupted:Int;
	var ZSTD_error_dictionary_wrong:Int;
	var ZSTD_error_dictionaryCreation_failed:Int;
	var ZSTD_error_dstBuffer_null:Int;
	var ZSTD_error_dstSize_tooSmall:Int;
	var ZSTD_error_frameParameter_unsupported:Int;
	var ZSTD_error_frameParameter_windowTooLarge:Int;
	var ZSTD_error_GENERIC:Int;
	var ZSTD_error_init_missing:Int;
	var ZSTD_error_literals_headerWrong:Int;
	var ZSTD_error_maxSymbolValue_tooLarge:Int;
	var ZSTD_error_maxSymbolValue_tooSmall:Int;
	var ZSTD_error_memory_allocation:Int;
	var ZSTD_error_no_error:Int;
	var ZSTD_error_noForwardProgress_destFull:Int;
	var ZSTD_error_noForwardProgress_inputEmpty:Int;
	var ZSTD_error_parameter_combination_unsupported:Int;
	var ZSTD_error_parameter_outOfBound:Int;
	var ZSTD_error_parameter_unsupported:Int;
	var ZSTD_error_prefix_unknown:Int;
	var ZSTD_error_srcSize_wrong:Int;
	var ZSTD_error_stabilityCondition_notRespected:Int;
	var ZSTD_error_stage_wrong:Int;
	var ZSTD_error_tableLog_tooLarge:Int;
	var ZSTD_error_version_unsupported:Int;
	var ZSTD_error_workSpace_tooSmall:Int;
	var ZSTD_fast:Int;
	var ZSTD_greedy:Int;
	var ZSTD_lazy:Int;
	var ZSTD_lazy2:Int;

	/**
		Internal compression mode identifiers.
	**/
	var DEFLATE:Int;
	var DEFLATERAW:Int;
	var GUNZIP:Int;
	var GZIP:Int;
	var INFLATE:Int;
	var INFLATERAW:Int;
	var UNZIP:Int;

}


/**
	Bindings to Gzip/Gunzip, Deflate/Inflate, DeflateRaw/InflateRaw,
	BrotliCompress/BrotliDecompress, and ZstdCompress/ZstdDecompress.
	Each class takes options and is a readable/writable Stream.

	@see https://nodejs.org/docs/latest-v24.x/api/zlib.html
**/
@:jsRequire("zlib")
extern class Zlib {
	/**
		Object containing zlib, Brotli, and Zstd constants.
		Prefer this over the deprecated top-level `Z_*` fields.
	**/
	static var constants(default, null):ZlibConstants;

	/**
		Allowed `flush` values.
	**/
	@:deprecated("Use Zlib.constants.Z_NO_FLUSH instead")
	static var Z_NO_FLUSH(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_PARTIAL_FLUSH instead")
	static var Z_PARTIAL_FLUSH(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_SYNC_FLUSH instead")
	static var Z_SYNC_FLUSH(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_FULL_FLUSH instead")
	static var Z_FULL_FLUSH(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_FINISH instead")
	static var Z_FINISH(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_BLOCK instead")
	static var Z_BLOCK(default, null):Int;

	/**
		Return codes for the compression/decompression functions.
		Negative values are errors; positive values are used for special but normal events.
	**/
	@:deprecated("Use Zlib.constants.Z_OK instead")
	static var Z_OK(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_STREAM_END instead")
	static var Z_STREAM_END(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_NEED_DICT instead")
	static var Z_NEED_DICT(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_ERRNO instead")
	static var Z_ERRNO(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_STREAM_ERROR instead")
	static var Z_STREAM_ERROR(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_DATA_ERROR instead")
	static var Z_DATA_ERROR(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_MEM_ERROR instead")
	static var Z_MEM_ERROR(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_BUF_ERROR instead")
	static var Z_BUF_ERROR(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_VERSION_ERROR instead")
	static var Z_VERSION_ERROR(default, null):Int;

	/**
		Compression levels.
	**/
	@:deprecated("Use Zlib.constants.Z_NO_COMPRESSION instead")
	static var Z_NO_COMPRESSION(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_BEST_SPEED instead")
	static var Z_BEST_SPEED(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_BEST_COMPRESSION instead")
	static var Z_BEST_COMPRESSION(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_DEFAULT_COMPRESSION instead")
	static var Z_DEFAULT_COMPRESSION(default, null):Int;

	/**
		Compression strategy.
	**/
	@:deprecated("Use Zlib.constants.Z_FILTERED instead")
	static var Z_FILTERED(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_HUFFMAN_ONLY instead")
	static var Z_HUFFMAN_ONLY(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_RLE instead")
	static var Z_RLE(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_FIXED instead")
	static var Z_FIXED(default, null):Int;

	@:deprecated("Use Zlib.constants.Z_DEFAULT_STRATEGY instead")
	static var Z_DEFAULT_STRATEGY(default, null):Int;


	/**
		Returns a new `Gzip` object with an `options`.
	**/
	static function createGzip(?options:ZlibOptions):Gzip;

	/**
		Returns a new `Gunzip` object with an `options`.
	**/
	static function createGunzip(?options:ZlibOptions):Gunzip;

	/**
		Returns a new `Deflate` object with an `options`.
	**/
	static function createDeflate(?options:ZlibOptions):Deflate;

	/**
		Returns a new `Inflate` object with an `options`.
	**/
	static function createInflate(?options:ZlibOptions):Inflate;

	/**
		Returns a new `DeflateRaw` object with an `options`.
	**/
	static function createDeflateRaw(?options:ZlibOptions):DeflateRaw;

	/**
		Returns a new `InflateRaw` object with an `options`.
	**/
	static function createInflateRaw(?options:ZlibOptions):InflateRaw;

	/**
		Returns a new `Unzip` object with an `options`.
	**/
	static function createUnzip(?options:ZlibOptions):Unzip;

	/**
		Returns a new `BrotliCompress` object with an `options`.
	**/
	static function createBrotliCompress(?options:BrotliOptions):BrotliCompress;

	/**
		Returns a new `BrotliDecompress` object with an `options`.
	**/
	static function createBrotliDecompress(?options:BrotliOptions):BrotliDecompress;

	/**
		Returns a new `ZstdCompress` object with an `options`.

		Stability: 1 - Experimental
	**/
	static function createZstdCompress(?options:ZstdOptions):ZstdCompress;

	/**
		Returns a new `ZstdDecompress` object with an `options`.

		Stability: 1 - Experimental
	**/
	static function createZstdDecompress(?options:ZstdOptions):ZstdDecompress;

	/**
		Computes a 32-bit Cyclic Redundancy Check checksum of `data`.
		If `value` is given, it is used as the starting value of the checksum.
		When `data` is a string, it is encoded as UTF-8 before computation.
	**/
	static function crc32(data:ZlibInput, ?value:Int):Int;

	/**
		Compress a chunk of data with `Deflate`.
	**/
	@:overload(function(buf:ZlibInput, options:ZlibOptions, callback:Error->Buffer->Void):Void {})
	static function deflate(buf:ZlibInput, callback:Error->Buffer->Void):Void;

	/**
		Compress a chunk of data with `Deflate` (synchronous version).
	**/
	static function deflateSync(buf:ZlibInput, ?options:ZlibOptions):Buffer;

	/**
		Compress a chunk of data with `DeflateRaw`.
	**/
	@:overload(function(buf:ZlibInput, options:ZlibOptions, callback:Error->Buffer->Void):Void {})
	static function deflateRaw(buf:ZlibInput, callback:Error->Buffer->Void):Void;

	/**
		Compress a chunk of data with `DeflateRaw` (synchronous version).
	**/
	static function deflateRawSync(buf:ZlibInput, ?options:ZlibOptions):Buffer;

	/**
		Compress a chunk of data with `Gzip`.
	**/
	@:overload(function(buf:ZlibInput, options:ZlibOptions, callback:Error->Buffer->Void):Void {})
	static function gzip(buf:ZlibInput, callback:Error->Buffer->Void):Void;

	/**
		Compress a chunk of data with `Gzip` (synchronous version).
	**/
	static function gzipSync(buf:ZlibInput, ?options:ZlibOptions):Buffer;

	/**
		Decompress a chunk of data with `Gunzip`.
	**/
	@:overload(function(buf:ZlibInput, options:ZlibOptions, callback:Error->Buffer->Void):Void {})
	static function gunzip(buf:ZlibInput, callback:Error->Buffer->Void):Void;

	/**
		Decompress a chunk of data with `Gunzip` (synchronous version).
	**/
	static function gunzipSync(buf:ZlibInput, ?options:ZlibOptions):Buffer;

	/**
		Decompress a chunk of data with `Inflate`.
	**/
	@:overload(function(buf:ZlibInput, options:ZlibOptions, callback:Error->Buffer->Void):Void {})
	static function inflate(buf:ZlibInput, callback:Error->Buffer->Void):Void;

	/**
		Decompress a chunk of data with `Inflate` (synchronous version).
	**/
	static function inflateSync(buf:ZlibInput, ?options:ZlibOptions):Buffer;

	/**
		Decompress a chunk of data with `InflateRaw`.
	**/
	@:overload(function(buf:ZlibInput, options:ZlibOptions, callback:Error->Buffer->Void):Void {})
	static function inflateRaw(buf:ZlibInput, callback:Error->Buffer->Void):Void;

	/**
		Decompress a chunk of data with `InflateRaw` (synchronous version).
	**/
	static function inflateRawSync(buf:ZlibInput, ?options:ZlibOptions):Buffer;

	/**
		Decompress a chunk of data with `Unzip`.
	**/
	@:overload(function(buf:ZlibInput, options:ZlibOptions, callback:Error->Buffer->Void):Void {})
	static function unzip(buf:ZlibInput, callback:Error->Buffer->Void):Void;

	/**
		Decompress a chunk of data with `Unzip` (synchronous version).
	**/
	static function unzipSync(buf:ZlibInput, ?options:ZlibOptions):Buffer;

	/**
		Compress a chunk of data with `BrotliCompress`.
	**/
	@:overload(function(buf:ZlibInput, options:BrotliOptions, callback:Error->Buffer->Void):Void {})
	static function brotliCompress(buf:ZlibInput, callback:Error->Buffer->Void):Void;

	/**
		Compress a chunk of data with `BrotliCompress` (synchronous version).
	**/
	static function brotliCompressSync(buf:ZlibInput, ?options:BrotliOptions):Buffer;

	/**
		Decompress a chunk of data with `BrotliDecompress`.
	**/
	@:overload(function(buf:ZlibInput, options:BrotliOptions, callback:Error->Buffer->Void):Void {})
	static function brotliDecompress(buf:ZlibInput, callback:Error->Buffer->Void):Void;

	/**
		Decompress a chunk of data with `BrotliDecompress` (synchronous version).
	**/
	static function brotliDecompressSync(buf:ZlibInput, ?options:BrotliOptions):Buffer;

	/**
		Compress a chunk of data with `ZstdCompress`.

		Stability: 1 - Experimental
	**/
	@:overload(function(buf:ZlibInput, options:ZstdOptions, callback:Error->Buffer->Void):Void {})
	static function zstdCompress(buf:ZlibInput, callback:Error->Buffer->Void):Void;

	/**
		Compress a chunk of data with `ZstdCompress` (synchronous version).

		Stability: 1 - Experimental
	**/
	static function zstdCompressSync(buf:ZlibInput, ?options:ZstdOptions):Buffer;

	/**
		Decompress a chunk of data with `ZstdDecompress`.

		Stability: 1 - Experimental
	**/
	@:overload(function(buf:ZlibInput, options:ZstdOptions, callback:Error->Buffer->Void):Void {})
	static function zstdDecompress(buf:ZlibInput, callback:Error->Buffer->Void):Void;

	/**
		Decompress a chunk of data with `ZstdDecompress` (synchronous version).

		Stability: 1 - Experimental
	**/
	static function zstdDecompressSync(buf:ZlibInput, ?options:ZstdOptions):Buffer;
}
