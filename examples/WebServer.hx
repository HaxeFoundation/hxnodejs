import js.node.Http;
import js.Node.console;

/**
    Example web server from the node.js main page
**/
class WebServer {
    static function main() {
        Http.createServer(function (req, res) {
          res.writeHead(200, {'Content-Type': 'text/plain'});
          res.end('Hello World\n');
        }).listen(1337, '127.0.0.1');
        console.log('Server running at http://127.0.0.1:1337/');
    }
}