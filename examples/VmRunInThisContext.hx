import js.Node.console;
import js.node.Vm;
import js.node.Util;

class VmRunInThisContext {
    static function main() {
        var localVar = 'initial value';

        var vmResult = Vm.runInThisContext('localVar = "vm";');
        console.log('vmResult: ', vmResult);
        console.log('localVar: ', localVar);

        var evalResult = js.Lib.eval('localVar = "eval";');
        console.log('evalResult: ', evalResult);
        console.log('localVar: ', localVar);
    }
}
