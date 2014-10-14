package js.node.zlib;

/**
	Compress data using deflate, and do not append a zlib header.
**/
@:jsRequire("zlib", "DeflateRaw")
extern class DeflateRaw extends Zlib {
}
