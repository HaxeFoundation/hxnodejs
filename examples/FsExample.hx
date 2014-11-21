import js.node.Fs;
import js.Node.console;

/**
	Example from fs API page.
**/
class FsExample {
	static function main() {
		Fs.rename('/tmp/hello', '/tmp/world', function (err) {
			if (err != null) throw err;
			Fs.stat('/tmp/world', function (err, stats) {
				if (err != null) throw err;
				console.log('stats: ' + haxe.Json.stringify(stats));
			});
		});
	}
}
