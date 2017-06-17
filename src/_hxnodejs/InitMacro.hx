package _hxnodejs;

#if macro
class InitMacro {
    static function include() {
        #if (!display && haxe_ver >= 3.3)
        if (!haxe.macro.Context.defined("hxnodejs_no_version_warning"))
            haxe.macro.Compiler.includeFile("_hxnodejs/version-warning.js");
        #end

        // should behave like other target defines and not be defined in macro context
        haxe.macro.Compiler.define("nodejs");
    }
}
#end
