package sys.io;

import haxe.io.Bytes;
import haxe.io.Eof;
import haxe.io.Error;
import js.node.Buffer;
import js.node.Fs;

@:coreApi
class FileInput extends haxe.io.Input {
	var fd:Int;
	var pos:Int;

	@:allow(sys.io.File)
	function new(fd:Int) {
		this.fd = fd;
		pos = 0;
	}

	override public function readByte() : Int {
		var buf = new Buffer(1);
		var bytesRead =
			try {
				Fs.readSync(fd, buf, 0, 1, pos);
			} catch (e:Dynamic) {
				if (e.code == "EOF")
					throw new Eof();
				else
					throw Error.Custom(e);
			}
		if (bytesRead == 0)
			throw new Eof();
		pos++;
		return buf[0];
	}

	override public function readBytes( s : Bytes, pos : Int, len : Int ) : Int {
		var buf = Buffer.hxFromBytes(s);
		var bytesRead =
			try {
				Fs.readSync(fd, buf, pos, len, this.pos);
			} catch (e:Dynamic) {
				if (e.code == "EOF")
					throw new Eof();
				else
					throw Error.Custom(e);
			}
		if (bytesRead == 0)
			throw new Eof();
		this.pos += bytesRead;
		return bytesRead;
	}

	override public function close() : Void {
		Fs.closeSync(fd);
	}

	public function seek( p : Int, pos : FileSeek ) : Void {
		switch (pos) {
			case SeekBegin:
				this.pos = p;
			case SeekEnd:
				this.pos = cast Fs.fstatSync(fd).size + p;
			case SeekCur:
				this.pos += p;
		}
	}

	public function tell() : Int {
		return pos;
	}

	public function eof() : Bool {
		return pos >= Fs.fstatSync(fd).size;
	}
}
