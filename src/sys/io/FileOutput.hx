package sys.io;

import haxe.io.Bytes;
import haxe.io.Eof;
import haxe.io.Error;
import js.node.Buffer;
import js.node.Fs;

@:coreApi
class FileOutput extends haxe.io.Output {
	var fd:Int;
	var pos:Int;
	var isAppend:Bool;

	@:allow(sys.io.File)
	function new(fd:Int, isAppend:Bool = false) {
		this.fd = fd;
		pos = 0;
		this.isAppend = isAppend;
	}

	override public function writeByte(b:Int):Void {
		var buf = Buffer.alloc(1);
		buf[0] = b;
		Fs.writeSync(fd, buf, 0, 1, isAppend ? null : pos);
		pos++;
	}

	override public function writeBytes(s:Bytes, pos:Int, len:Int):Int {
		var buf = Buffer.hxFromBytes(s);
		var wrote = Fs.writeSync(fd, buf, pos, len, isAppend ? null : this.pos);
		this.pos += wrote;
		return wrote;
	}

	override public function close():Void {
		Fs.closeSync(fd);
	}

	public function seek(p:Int, pos:FileSeek):Void {
		switch (pos) {
			case SeekBegin:
				this.pos = p;
			case SeekEnd:
				this.pos = cast Fs.fstatSync(fd).size + p;
			case SeekCur:
				this.pos += p;
		}
	}

	public function tell():Int {
		return pos;
	}
}
