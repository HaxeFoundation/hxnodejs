package haxe.zip;

class Uncompress {

	public static function run( src : haxe.io.Bytes, ?bufsize : Int ) : haxe.io.Bytes {		
		var buffer = js.node.Zlib.inflateSync(js.node.Buffer.hxFromBytes(src),bufsize == null ? {} : {chunkSize : bufsize});
		return buffer.hxToBytes();
	}

}
