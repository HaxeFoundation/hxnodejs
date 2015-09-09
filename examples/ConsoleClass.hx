import js.node.Fs;
import js.node.console.Console;

/**
    Example of the Console class usage.
**/
class ConsoleClass {
    static function main() {
        var output = Fs.createWriteStream('./stdout.log');
        var errorOutput = Fs.createWriteStream('./stderr.log');
        // custom simple logger
        var logger = new Console(output, errorOutput);
        // use it like console
        var count = 5;
        logger.log('count: %d', count);
    }
}
