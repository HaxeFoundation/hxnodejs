import js.node.Fs;
import js.node.Tls;

/**
	example from the tls.createServer documentation
**/
class TlsServerPfxExample {
	static function main() {
		var options = {
			pfx: Fs.readFileSync('server.pfx'),

			// This is necessary only if using the client certificate authentication.
			requestCert: true,
		};

		var server = Tls.createServer(options, function(socket) {
			trace('server connected', socket.authorized ? 'authorized' : 'unauthorized');
	  		socket.write("welcome!\n");
	  		socket.setEncoding('utf8');
	  		socket.pipe(socket);
		});
		server.listen(8000, function() trace('server bound'));
	}
}
