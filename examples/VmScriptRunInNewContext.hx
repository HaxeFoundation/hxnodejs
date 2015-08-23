import js.node.Util;
import js.node.vm.Script;

class VmScriptRunInNewContext {
    static function main() {
        var sandboxes = [{}, {}, {}];
        var script = new Script('globalVar = "set"');
        for (sandbox in sandboxes)
            script.runInNewContext(sandbox);
        trace(Util.inspect(sandboxes));
    }
}
