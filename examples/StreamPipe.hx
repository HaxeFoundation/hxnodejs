import js.node.Fs;
import js.node.Zlib;

class StreamPipe {
    static function main() {
        var r = Fs.createReadStream('file.txt');
        var z = Zlib.createGzip();
        var w = Fs.createWriteStream('file.txt.gz');
        r.pipe(z).pipe(w);
    }
}