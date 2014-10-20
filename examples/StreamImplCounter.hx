import js.node.Buffer;
import js.node.stream.Readable;

/**
	A Counting Stream
**/
@:keep
class Counter extends Readable<Counter> {
	var _max = 1000000;
	var _index = 1;

	override function _read(_) {
		var i = _index++;
		if (i > _max)
			push(null);
		else {
			var str = '' + i;
			var buf = new Buffer(str, 'ascii');
			push(buf);
		}
	}
}

class StreamImplCounter {
	static function main() {}
}
