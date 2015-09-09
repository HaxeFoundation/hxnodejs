import js.node.Readline;
import js.node.readline.Interface;
import js.Node.process;
import js.Node.console;

using StringTools;

class ReadlineTinyCLI {
    static function main() {
        var rl = Readline.createInterface(process.stdin, process.stdout);
        rl.setPrompt('OHAI> ');
        rl.prompt();
        rl.on(InterfaceEvent.Line, function(line) {
            switch(line.trim()) {
                case 'hello':
                    console.log('world!');
                default:
                    console.log('Say what? I might have heard `' + line.trim() + '`');
            }
            rl.prompt();
        }).on(InterfaceEvent.Close, function() {
            console.log('Have a great day!');
            process.exit(0);
        });
    }
}
