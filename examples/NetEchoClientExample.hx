import js.node.Buffer;
import js.node.Net;
import js.node.net.Socket;

class NetEchoClientExample {
    static function main() {
        var client:Socket;
        client = Net.connect({port: 8124}, function() { //'connect' listener
            trace('connected to server!');
            client.write('world!\r\n');
        });
        client.on(SocketEvent.Data, function(data:Buffer) {
            trace(data.toString());
            client.end();
        });
        client.on(SocketEvent.End, function() trace('disconnected from server'));
    }
}
