import js.node.Util;
import js.node.Vm;
import js.node.vm.Script;

class VmScriptRunInContext {
    static function main() {
        var sandbox = Vm.createContext({
            animal: 'cat',
            count: 2
        });
        var script = new Script('count += 1; name = "kitty"');
        for (i in 0...10)
            script.runInContext(sandbox);
        trace(Util.inspect(sandbox));
    }
}
