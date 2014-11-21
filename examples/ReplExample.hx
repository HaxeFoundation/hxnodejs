import js.node.Net;
import js.node.Repl;
import js.Node.process;

/**
	Example from the REPL page
**/
class ReplExample {
    static function main() {
		var connections = 0;

		Repl.start({
			prompt: "node via stdin> ",
			input: process.stdin,
			output: process.stdout
		});

		Net.createServer(function (socket) {
			connections += 1;
			Repl.start({
				prompt: "node via Unix socket> ",
				input: socket,
				output: socket
			}).on('exit', function() {
				socket.end();
			});
		}).listen("/tmp/node-repl-sock");

		Net.createServer(function (socket) {
			connections += 1;
			Repl.start({
				prompt: "node via TCP socket> ",
				input: socket,
				output: socket
			}).on('exit', function() {
				socket.end();
			});
		}).listen(5001);
    }
}
