import js.node.Net;

/**
    Example tcp server from the node.js main page
**/
class TcpServer {
    static function main() {
        var server = Net.createServer(function (socket) {
            socket.write('Echo server\r\n');
            socket.pipe(socket);
        });
        server.listen(1337, '127.0.0.1');
    }
}