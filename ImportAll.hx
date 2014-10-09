import haxe.io.Path;
import haxe.macro.Context;
import sys.FileSystem;

class ImportAll {
    static function run(root:String):Void {
        function loop(acc:Array<String>):Void {
            var path = Path.join(acc);
            if (FileSystem.isDirectory(path)) {
                for (file in FileSystem.readDirectory(path))
                    loop(acc.concat([file]));
            } else if (Path.extension(path) == "hx") {
                var moduleName = Path.withoutExtension(acc[acc.length - 1]);
                var modulePath = acc.slice(0, acc.length - 1);
                Context.getModule(modulePath.join(".") + "." + moduleName);
            }
        }
        loop([root]);
    }
}