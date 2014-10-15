import js.node.ChildProcess.spawn;
import js.node.NodeJS.console;

/**
    child_process.spawn example from child process page
**/
class ChildProcessExample {
    static function main() {
        var ls = spawn('ls', ['-lh', '/usr']);

        ls.stdout.on('data', function (data) {
            console.log('stdout: ' + data);
        });

        ls.stderr.on('data', function (data) {
            console.log('stderr: ' + data);
        });

        ls.on('close', function (code) {
            console.log('child process exited with code ' + code);
        });
    }
}
