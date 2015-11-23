package _hxnodejs;

#if macro
class VersionWarning {
    static function include() {
        if (!haxe.macro.Context.defined("hxnodejs_no_version_warning")) {
            // we don't use Compiler.includeFile because of https://github.com/HaxeFoundation/haxe/issues/4660
            var includeFile = neko.Lib.load("macro", "include_file", 2);
            includeFile(untyped "_hxnodejs/version-warning.js".__s, untyped "top".__s);
        }
    }
}
#end
