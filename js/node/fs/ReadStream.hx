package js.node.fs;

import js.node.events.EventEmitter.Event;

@:enum abstract ReadStreamEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when the `ReadStream`'s file is opened.

		Listener arguments:
			fd - file descriptor used by the `ReadStream`.
	**/
	var Open : ReadStreamEvent<Int->Void> = "open";
}

/**
	Readable file stream.
**/
extern class ReadStream extends js.node.stream.Readable<ReadStream> {
}
