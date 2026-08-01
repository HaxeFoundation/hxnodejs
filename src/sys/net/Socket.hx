package sys.net;
import haxe.io.Output;
import js.Node;
import haxe.io.Bytes;

class SocketOutput extends Output {
	
		var socket:Socket;

	public function new(socket:Socket) {
		this.socket = socket;
	}
	
	override function writeByte(c:Int):Void {
		var b = new js.node.Buffer([c]);
		socket._write(b);
	}

	/**
		Write `len` bytes from `s` starting by position specified by `pos`.

		Returns the actual length of written data that can differ from `len`.

		See `writeFullBytes` that tries to write the exact amount of specified bytes.
	**/
	override function writeBytes(s:Bytes, pos:Int, len:Int):Int {
		var b = js.node.Buffer.hxFromBytes(s);
		socket._write(b);
		return b.length;
	}

}

class SocketInput extends haxe.io.Input {
	var s:Socket;

	public function new(s:Socket) {
		this.s = s;
	}

	override function readByte():Int {
		s.waitData();
		var buf = s.inputData[0];
		var b = buf[s.inputPos++];
		if (s.inputPos == buf.length) {
			s.inputPos = 0;
			s.inputData.shift();
		}
		return b;
	}

	override function readBytes(buf:haxe.io.Bytes, pos:Int, len:Int):Int {
		s.waitData();
		var nbuf = js.node.Buffer.hxFromBytes(buf);
		var startPos = pos;
		while (len > 0) {
			var buf = s.inputData[0];
			if (buf == null)
				break;
			var avail = buf.length - s.inputPos;
			if (avail > len) {
				buf.copy(nbuf, pos, s.inputPos, s.inputPos + len);
				pos += len;
				s.inputPos += len;
				break;
			}
			buf.copy(nbuf, pos, s.inputPos, s.inputPos + avail);
			pos += avail;
			len -= avail;
			s.inputData.shift();
			s.inputPos = 0;
		}
		return pos - startPos;
	}
}

@:allow(sys.net.SocketInput)
class Socket {
	var s:js.node.net.Socket;
	var inputData:Array<js.node.Buffer> = [];
	var inputPos:Int = 0;

	public var input:haxe.io.Input;
	public var output:haxe.io.Output;

	public function new() {
		input = new SocketInput(this);
		output = new SocketOutput(this);
	}

	public function connect(host:Host, port:Int) {
		s = new js.node.net.Socket();
		s.on("data", function(buf:js.node.Buffer) inputData.push(buf));
		NodeSync.callVoid(function(callb) s.connect(port, host.host, callb));
	}

	function waitData() {
		if (inputData.length == 0)
			NodeSync.wait(function() return inputData.length > 0);
	}
	
	public function _write(buf){
		s.write(buf);
	}

	public function close() {
		if (s != null) {
			s.destroy();
			s = null;
		}
	}
	
	public function shutdown(a,b){
		close();
	}
	
	public function setTimeout(ms){
		
	}
}
