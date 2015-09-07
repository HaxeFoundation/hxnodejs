package sys.io;
import js.node.Fs;

class File {

	public static function getContent( path : String ) : String {
		return Fs.readFileSync(path, {encoding:"utf8"});
	}

	public static function getBytes( path : String ) : haxe.io.Bytes {
		var o = Fs.openSync(path, "r");
		var s = Fs.fstatSync(o);
		var len = s.size, pos = 0;
		var bytes = haxe.io.Bytes.alloc(s.size);
		var tmpBuf = new js.node.Buffer(s.size);
		while( len > 0 ) {
			var r = Fs.readSync(o, tmpBuf, pos, len, null);
			pos += r;
			len -= r;
		}
		Fs.closeSync(o);
		for( i in 0...s.size )
			bytes.set(i, tmpBuf[i]);
		return bytes;
	}

	public static function saveContent( path : String, content : String ) {
		Fs.writeFileSync(path, content);
	}

}