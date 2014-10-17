import js.node.Dgram;
import js.node.Buffer;

/**
	A `socket.send` example from the dgram API page.
**/
class DgramSendExample {
	static function main() {
		var message = new Buffer("Some bytes");
		var client = Dgram.createSocket("udp4");
		client.send(message, 0, message.length, 41234, "localhost", function(err, bytes) {
			client.close();
		});
	}
}
