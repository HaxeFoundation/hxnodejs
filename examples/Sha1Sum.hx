import js.node.Crypto;
import js.node.Fs;
import js.Node.process;
import js.Node.console;

/**
    Sha1 hash example from the crypto page
**/
class Sha1Sum {
    static function main() {
        var filename = process.argv[2];

        var shasum = Crypto.createHash('sha1');

        var s = Fs.createReadStream(filename);
        s.on('data', function(d) {
          shasum.update(d);
        });

        s.on('end', function() {
          var d = shasum.digest('hex');
          console.log(d + '  ' + filename);
        });
    }
}