import js.node.Http;

#if haxe4
import js.lib.Error;
#else
import js.Error;
#end

/**
    An example from the stream page
**/
class StreamExample {
    static function main() {
        var server = Http.createServer(function (req, res) {
            // req is an http.IncomingMessage, which is a Readable Stream
            // res is an http.ServerResponse, which is a Writable Stream

            var body = '';
            // we want to get the data as utf8 strings
            // If you don't set an encoding, then you'll get Buffer objects
            req.setEncoding('utf8');

            // Readable streams emit 'data' events once a listener is added
            req.on('data', function (chunk) {
                body += chunk;
            });

            // the end event tells you that you have entire body
            req.on('end', function () {
                var data = try {
                    haxe.Json.parse(body);
                } catch (er:Error) {
                    // uh oh!  bad json!
                    res.statusCode = 400;
                    return res.end('error: ' + er.message);
                }

                // write back something interesting to the user:
                res.write(Std.string(Type.typeof(data)));
                res.end();
            });
        });

        server.listen(1337);
    }
}
