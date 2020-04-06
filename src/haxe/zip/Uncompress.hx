package haxe.zip;

class Uncompress {
	public function new(?windowBits:Int) {
		throw "Not implemented for this platform";
	}

	public function execute(src:haxe.io.Bytes, srcPos:Int, dst:haxe.io.Bytes, dstPos:Int):{done:Bool, read:Int, write:Int} {
		return null;
	}

	public function setFlushMode(f:FlushMode) {}

	public function close() {}

	public static function run(src:haxe.io.Bytes, ?bufsize:Int):haxe.io.Bytes {
		var buffer = js.node.Zlib.inflateSync(js.node.Buffer.hxFromBytes(src), bufsize == null ? {} : {chunkSize: bufsize});
		return buffer.hxToBytes();
	}
}
