import js.node.Fs;
import js.node.Tls;

/**
	example from the tls.createServer documentation
**/
class TlsServerPemExample {
	static function main() {
		var options = {
			key: Fs.readFileSync('server-key.pem'),
			cert: Fs.readFileSync('server-cert.pem'),

			// This is necessary only if using the client certificate authentication.
			requestCert: true,

			// This is necessary only if the client uses the self-signed certificate.
			ca: [ Fs.readFileSync('client-cert.pem') ]
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
