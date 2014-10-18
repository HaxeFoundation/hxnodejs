package js.node;

/**
    The tty module houses the tty.ReadStream and tty.WriteStream classes.
    In most cases, you will not need to use this module directly.

    When node detects that it is being run inside a TTY context, then process.stdin will be a tty.ReadStream
    instance and process.stdout will be a tty.WriteStream instance. The preferred way to check if node is being
    run in a TTY context is to check process.stdout.isTTY.
**/
@:jsRequire("tty")
extern class Tty {
    /**
        Returns true or false depending on if the `fd` is associated with a terminal.
    **/
    static function isatty(fd:Int):Bool;

    @:deprecated("Use tty.ReadStream#setRawMode() instead.")
    static function setRawMode(mode:Bool):Void;
}
