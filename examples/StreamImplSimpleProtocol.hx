import js.node.Buffer;
import js.node.stream.Readable;
#if haxe4
import js.lib.Error;
#else
import js.Error;
#end

// A parser for a simple data protocol.
// The "header" is a JSON object, followed by 2 \n characters, and
// then a message body.
//
// NOTE: This can be done more simply as a Transform stream!
// Using Readable directly for this is sub-optimal.  See the
// alternative example below under the Transform section.

@:keep
class SimpleProtocol extends Readable<SimpleProtocol> {

	var _inBody = false;
	var _sawFirstCr = false;
	var _rawHeader = [];
	var _source:IReadable;
	var header:Buffer;

	public function new(source, options) {
		super(options);
		// source is a readable stream, such as a socket or file
		_source = source;
		source.on('end', push.bind(null));

		// give it a kick whenever the source is readable
		// read(0) will not consume any bytes
		source.on('readable', read.bind(0));
	}

	override function _read(size:Int):Void {
		if (!_inBody) {
			var chunk:Buffer = _source.read();

			// if the source doesn't have data, we don't have data yet.
			if (chunk == null) {
				push('');
				return;
			}

			// check if the chunk has a \n\n
			var split = -1;
			for (i in 0...chunk.length) {
				if (chunk[i] == 10) { // '\n'
					if (_sawFirstCr) {
						split = i;
						break;
					} else {
						_sawFirstCr = true;
					}
				} else {
					_sawFirstCr = false;
				}
			}

			if (split == -1) {
				// still waiting for the \n\n
				// stash the chunk, and try again.
				_rawHeader.push(chunk);
				push('');
			} else {
				_inBody = true;
				_rawHeader.push(chunk.slice(0, split));
				var header = try {
						haxe.Json.parse(Buffer.concat(_rawHeader).toString());
					} catch (_:Dynamic) {
						emit('error', new Error('invalid simple protocol data'));
						return;
					}
				// now, because we got some extra data, unshift the rest
				// back into the read queue so that our consumer will see it.
				var b = chunk.slice(split);
				unshift(b);

				// and let them know that we are done parsing the header.
				emit('header', this.header);
			}
		} else {
			// from there on, just provide the data to our consumer.
			// careful not to push(null), since that would indicate EOF.
			var chunk = this._source.read();
			if (chunk != null) this.push(chunk);
		}
	}
}

class StreamImplSimpleProtocol {
	static function main() {}
}
