package js.node.fs;

@:enum abstract ReadStreamEvent(String) to String {
    /**
        Emitted when the `ReadStream`'s file is opened.

        Listener arguments:
            * fd - Integer file descriptor used by the `ReadStream`.
    **/
	static public var Open : String = "open";
}

/**
    Readable file stream.
**/
extern class ReadStream extends js.node.stream.Readable {
}
