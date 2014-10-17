package js.node.fs;

import js.node.events.EventEmitter.Event;

@:enum abstract WriteStreamEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
        Emitted when the `WriteStream`'s file is opened.

        Listener arguments:
            fd - file descriptor used by the `WriteStream`.
    **/
	var Open : WriteStreamEvent<Int->Void> = "open";
}

/**
    Writable file stream.
**/
extern class WriteStream extends js.node.stream.Writable<WriteStream> {
}
