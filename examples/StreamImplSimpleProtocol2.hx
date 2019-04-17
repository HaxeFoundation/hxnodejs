import js.node.Buffer;
import js.node.stream.Transform;
#if haxe4
import js.lib.Error;
#else
import js.Error;
#end

@:keep
class SimpleProtocol extends Transform<SimpleProtocol> {
	var _inBody = false;
	var _sawFirstCr = false;
	var _rawHeader = [];
	var header:Buffer;

	override function _transform(chunk:Buffer, encoding, callback) {
		if (!this._inBody) {
			// check if the chunk has a \n\n
			var split = -1;
			for (i in 0...chunk.length) {
				if (chunk[i] == 10) { // '\n'
					if (this._sawFirstCr) {
						split = i;
						break;
					} else {
						this._sawFirstCr = true;
					}
				} else {
					this._sawFirstCr = false;
				}
			}

			if (split == -1) {
				// still waiting for the \n\n
				// stash the chunk, and try again.
				this._rawHeader.push(chunk);
			} else {
				this._inBody = true;
				var h = chunk.slice(0, split);
				this._rawHeader.push(h);
				var header = Buffer.concat(this._rawHeader).toString();
				try {
					this.header = haxe.Json.parse(header);
				} catch (_:Dynamic) {
					this.emit('error', new Error('invalid simple protocol data'));
					return;
				}
				// and let them know that we are done parsing the header.
				this.emit('header', this.header);

				// now, because we got some extra data, emit this first.
				this.push(chunk.slice(split));
			}
		} else {
			// from there on, just provide the data to our consumer as-is.
			this.push(chunk);
		}
		callback(null, null);
	}
}

class StreamImplSimpleProtocol2 {
	static function main() {}
}
