import haxe.io.Path;
import haxe.macro.Compiler;
import haxe.macro.Context;
import sys.FileSystem;

class ImportAll {
    static function run(cp:String):Void {
        Compiler.addClassPath(cp);
        Compiler.allowPackage("sys");
        Compiler.define("nodejs");

        function loop(acc:Array<String>):Void {
            var path = Path.join([cp].concat(acc));
            if (FileSystem.isDirectory(path)) {
                if (acc.length > 0 && acc[acc.length - 1].charCodeAt(0) == "_".code) // skip hidden packages
                    return;
                for (file in FileSystem.readDirectory(path))
                    loop(acc.concat([file]));
            } else if (Path.extension(path) == "hx") {
                var moduleName = Path.withoutExtension(acc[acc.length - 1]);
                var modulePath = acc.slice(0, acc.length - 1);
                var typePath = if (modulePath.length == 0) moduleName else modulePath.join(".") + "." + moduleName;
                Context.getType(typePath);
            }
        }
        loop([]);
    }
}
