import js.node.Vm;
import js.node.Util;

class VmRunInNewContext {
    static function main() {
        var sandbox = {
            animal: 'cat',
            count: 2
        };
        Vm.runInNewContext('count += 1; name = "kitty"', sandbox);
        trace(Util.inspect(sandbox));
    }
}
