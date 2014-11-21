import js.node.Fs;
import js.node.Tls;
import js.Node.console;

/**
	example from the tls.createServer documentation
**/
class TlsServerExample {
	static function main() {
		var options = {
			key: Fs.readFileSync('server-key.pem'),
			cert: Fs.readFileSync('server-cert.pem'),

			// This is necessary only if using the client certificate authentication.
			requestCert: true,

			// This is necessary only if the client uses the self-signed certificate.
			ca: [ Fs.readFileSync('client-cert.pem') ]
		};

		var server = Tls.createServer(options, function(cleartextStream) {
			console.log('server connected',
									cleartextStream.authorized ? 'authorized' : 'unauthorized');
			cleartextStream.write("welcome!\n");
			cleartextStream.setEncoding('utf8');
			cleartextStream.pipe(cleartextStream);
		});
		server.listen(8000, function() {
			console.log('server bound');
		});
	}
}
