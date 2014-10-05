package nodejs.fs;
import nodejs.events.EventEmitter;

/**
 * Class that enumerates the events emitted by FSWatcher.
 */
class FSWatcherEventType
{
	/**
	 * event String The type of fs change
	 * filename String The filename that changed (if relevant/available)
	 * Emitted when something changes in a watched directory or file. See more details in fs.watch.
	 */
	static public var Change : String = "change";
	
	/**
	 * error Error object
	 * Emitted when an error occurs.
	 */
	static public var Error : String = "error";
}

/**
 * Objects returned from fs.watch() are of this type.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class FSWatcher extends EventEmitter
{

	/**
	 * Stop watching for changes on the given fs.FSWatcher.
	 */
	function close():Void;
	
}