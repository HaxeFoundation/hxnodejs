
import js.node.Fs;
import js.node.Tls;
import js.node.tls.TLSSocket;
import js.Node.process;

class TlsConnectPfxExample {
    static function main() {
        var options = {
            pfx: Fs.readFileSync('client.pfx')
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
