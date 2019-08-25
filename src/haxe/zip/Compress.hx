package haxe.zip;

class Compress {
	public static function run(s:haxe.io.Bytes, level:Int):haxe.io.Bytes {
		var buffer = js.node.Zlib.deflateSync(js.node.Buffer.hxFromBytes(s), {level: level});
		return buffer.hxToBytes();
	}
}
