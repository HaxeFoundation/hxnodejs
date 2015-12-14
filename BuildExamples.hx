import haxe.io.Path;
import sys.FileSystem;

class BuildExamples {
    static function main() {
        Sys.setCwd("examples");
        for (file in FileSystem.readDirectory(".")) {
            if (Path.extension(file) == "hx") {
                var main = Path.withoutExtension(file);
                var code = Sys.command("haxe", [
                    "-main", main,
                    "-js", '$main.js',
                    "-lib", "hxnodejs",
                    "-D", "js-es5",
                    "-D", "analyzer",
                    "-dce", "full",
                ]);
                if (code != 0)
                    Sys.exit(code);
            }
        }
    }
}