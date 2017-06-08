package sys.io;

@:dce
// @:coreApi
class File {

	public static inline function read( path : String, binary : Bool = true ) : FileInput {
		return new FileInput(Fs.openSync(path, Read));
	}

	public static inline function getContent( path : String ) : String {
		return js.node.Fs.readFileSync(path, {encoding: "utf8"});
	}

	public static inline function saveContent( path : String, content : String ) : Void {
		js.node.Fs.writeFileSync(path, content);
	}

	public static inline function getBytes( path : String ) : haxe.io.Bytes {
		return js.node.Fs.readFileSync(path).hxToBytes();
	}

	public static inline function saveBytes( path : String, bytes : haxe.io.Bytes ) : Void {
		js.node.Fs.writeFileSync(path, js.node.Buffer.hxFromBytes(bytes));
	}

	static inline var copyBufLen = 64 * 1024;
	static var copyBuf = new js.node.Buffer(copyBufLen);

	public static function copy( srcPath : String, dstPath : String ) : Void {
		var src = js.node.Fs.openSync(srcPath, Read);
		var stat = js.node.Fs.fstatSync(src);
		var dst = js.node.Fs.openSync(dstPath, WriteCreate, stat.mode);
		var bytesRead, pos = 0;
		while ((bytesRead = js.node.Fs.readSync(src, copyBuf, 0, copyBufLen, pos)) > 0) {
			js.node.Fs.writeSync(dst, copyBuf, 0, bytesRead);
			pos += bytesRead;
		}
		js.node.Fs.closeSync(src);
		js.node.Fs.closeSync(dst);
	}
}