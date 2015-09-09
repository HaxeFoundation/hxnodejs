import haxe.io.Path;
import sys.FileSystem;

class BuildExamples {
    static function main() {
        Sys.setCwd("examples");
        for (file in FileSystem.readDirectory(".")) {
            if (Path.extension(file) == "hx") {
                var main = Path.withoutExtension(file);
                Sys.command("haxe", [
                    "-main", main,
                    "-cp", "../src",
                    "-js", '$main.js',
                    "-D", "js-es5",
                    "-D", "analyzer",
                    "-dce", "full",
                ]);
            }
        }
    }
}