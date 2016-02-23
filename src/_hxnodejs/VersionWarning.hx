package _hxnodejs;

#if macro
class VersionWarning {
    static function include() {
        #if (!display && haxe_ver >= 3.3)
        if (!haxe.macro.Context.defined("hxnodejs_no_version_warning"))
            haxe.macro.Compiler.includeFile("_hxnodejs/version-warning.js");
        #end
    }
}
#end
