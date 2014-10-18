package js.node.tty;

/**
	A net.Socket subclass that represents the readable portion of a tty.
	In normal circumstances, process.stdin will be the only tty.ReadStream instance
	in any node program (only when isatty(0) is true).
**/
@:jsRequire("tty", "ReadStream")
extern class ReadStream extends js.node.net.Socket {
	/**
		A boolean that is initialized to false.
		It represents the current "raw" state of the tty.ReadStream instance.
	**/
	var isRaw(default,null):Bool;

	/**
		`mode` should be true or false.
		This sets the properties of the tty.ReadStream to act either as a raw device or default.
		`isRaw` will be set to the resulting mode.
	**/
	function setRawMode(mode:Bool):Void;
}
