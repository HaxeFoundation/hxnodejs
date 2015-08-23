import js.node.Vm;
import js.node.Util;

class VmRunInContext {
    static function main() {
        var sandbox = { globalVar: 1 };
        Vm.createContext(sandbox);
        for (i in 0...10)
            Vm.runInContext('globalVar *= 2;', sandbox);
        trace(Util.inspect(sandbox));
    }
}
