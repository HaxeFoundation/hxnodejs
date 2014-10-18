package js.node.tty;

import js.node.events.EventEmitter;

/**
	Enumeration of events emitted by `WriteStream` objects in addition to its parents.
**/
@:enum abstract WriteStreamEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted by refreshSize() when either of the columns or rows properties has changed.
	**/
	var Resize : WriteStreamEvent<Void->Void> = "resize";
}

/**
	A net.Socket subclass that represents the writable portion of a tty.
	In normal circumstances, process.stdout will be the only tty.WriteStream instance
	ever created (and only when isatty(1) is true).
**/
@:jsRequire("tty", "WriteStream")
extern class WriteStream extends js.node.net.Socket {
	/**
		The number of columns the TTY currently has.
		This property gets updated on "resize" events.
	**/
	var columns(default,null):Int;

	/**
		The number of rows the TTY currently has.
		This property gets updated on "resize" events.
	**/
	var rows(default,null):Int;
}
