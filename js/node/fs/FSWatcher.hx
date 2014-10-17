package js.node.fs;

import js.node.events.EventEmitter;

/**
	Enumeration of possible types of changes for 'change' event.
**/
@:enum abstract FSWatcherChangeType(String) to String {
	var Change = "change";
	var Rename = "rename";
}

/**
	Enumeration of the events emitted by `FSWatcher`.
**/
@:enum abstract FSWatcherEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when something changes in a watched directory or file. See more details in `Fs.watch`.

		Listener arguments:
			event - The type of fs change
			filename - The filename that changed (if relevant/available)
	**/
	var Change : FSWatcherEvent<FSWatcherChangeType->String->Void> = "change";

	/**
		Emitted when an error occurs.
	**/
	var Error : FSWatcherEvent<js.Error->Void> = "error";
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
