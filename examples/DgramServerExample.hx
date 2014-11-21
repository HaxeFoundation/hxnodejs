import js.node.Dgram;
import js.Node.console;

class DgramServerExample {
	static function main() {
		var server = Dgram.createSocket("udp4");

		server.on("error", function (err) {
			console.log("server error:\n" + err.stack);
			server.close();
		});

		server.on("message", function (msg, rinfo) {
			console.log("server got: " + msg + " from " + rinfo.address + ":" + rinfo.port);
		});

		server.on("listening", function () {
			var address = server.address();
			console.log("server listening " + address.address + ":" + address.port);
		});

		server.bind(41234);
	}
}
