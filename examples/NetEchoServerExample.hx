import js.node.Net;
import js.node.net.Socket.SocketEvent;

class NetEchoServerExample {
    static function main() {
        var server = Net.createServer(function(c) { //'connection' listener
            trace('client connected');
            c.on(SocketEvent.End, function() trace('client disconnected'));
            c.write('hello\r\n');
            c.pipe(c);
        });
        server.listen(8124, function() trace('server bound')); //'listening' listener
    }
}
