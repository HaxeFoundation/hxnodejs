import js.node.Fs;
import js.node.Tls;
import js.node.tls.TLSSocket;
import js.Node.process;

class TlsConnectPemExample {
    static function main() {
        var options = {
            // These are necessary only if using the client certificate authentication
            key: Fs.readFileSync('client-key.pem'),
            cert: Fs.readFileSync('client-cert.pem'),

            // This is necessary only if the server uses the self-signed certificate
            ca: [ Fs.readFileSync('server-cert.pem') ]
        };

        var socket:TLSSocket;
        socket = Tls.connect(8000, options, function() {
            trace('client connected', socket.authorized ? 'authorized' : 'unauthorized');
            process.stdin.pipe(socket);
            process.stdin.resume();
        });
        socket.setEncoding('utf8');
        socket.on('data', function(data) trace(data));
    }
}
