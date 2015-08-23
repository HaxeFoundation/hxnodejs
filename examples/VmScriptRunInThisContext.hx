import js.Node.global;
import js.node.vm.Script;

class VmScriptRunInThisContext {
    static function main() {
        global.globalVar = 0;
        var script = new Script('globalVar += 1', { filename: 'myfile.vm' });
        for (i in 0...1000)
            script.runInThisContext();
        trace(global.globalVar);
    }
}
