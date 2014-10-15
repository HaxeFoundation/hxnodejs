package js.node.fs;

@:enum abstract WriteStreamEvent(String) to String {
	/**
        Emitted when the `WriteStream`'s file is opened.

        Listener arguments:
            * fd - Integer file descriptor used by the `WriteStream`.
    **/
	static public var Open : String = "open";
}

/**
    Writable file stream.
**/
extern class WriteStream extends js.node.stream.Writable<WriteStream> {
}
