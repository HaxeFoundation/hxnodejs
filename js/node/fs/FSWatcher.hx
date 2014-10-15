package js.node.fs;

import js.node.events.EventEmitter;

/**
	Enumeration of the events emitted by `FSWatcher`.
**/
@:enum abstract FSWatcherEvent(String) to String {
	/**
		Emitted when something changes in a watched directory or file. See more details in `Fs.watch`.

		Listener arguments:
			* event:String - The type of fs change
			* filename:String - The filename that changed (if relevant/available)
	**/
	var Change = "change";

	/**
		Emitted when something changes in a watched directory or file. See more details in `Fs.watch`.

		Listener arguments:
			* event:String - The type of fs change
			* filename:String - The filename that changed (if relevant/available)
	**/
	var Rename = "rename";

	/**
		Emitted when an error occurs.

		Listener arguments:
			* error - Error object
	**/
	var Error = "error";
}

/**
	Objects returned from `Fs.watch` are of this type.
**/
extern class FSWatcher extends EventEmitter<FSWatcher> {

	/**
		Stop watching for changes on the given `FSWatcher`.
	**/
	function close():Void;
}
