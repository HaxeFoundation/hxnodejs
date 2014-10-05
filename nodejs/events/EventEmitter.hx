package nodejs.events;
import nodejs.NodeJS;
import js.html.ArrayBufferView;

/**
 * 
 */
class EventEmitterEventType
{
	/**
	 * event String The event name
	 * listener Function The event handler function
	 * This event is emitted any time someone adds a new listener. It is unspecified if listener is in the list returned by emitter.listeners(event).
	 */
	static public var NewListener : String = "newListener";
	
	/**
	 * event String The event name
	 * listener Function The event handler function
	 * This event is emitted any time someone removes a listener. It is unspecified if listener is in the list returned by emitter.listeners(event).
	 */
	static public var RemoveListener : String = "removeListener";
	
}

/**
 * To access the EventEmitter class, require('events').EventEmitter.
 * When an EventEmitter instance experiences an error, the typical action is to emit an 'error' event. Error events are treated as a special case in node.
 * If there is no listener for it, then the default action is to print a stack trace and exit the program.
 * All EventEmitters emit the event 'newListener' when new listeners are added and 'removeListener' when a listener is removed.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('events').EventEmitter)")
extern class EventEmitter
{	
	
	/**
	 * Return the number of listeners for a given event.
	 * @param	emitter
	 * @param	event
	 */
	static function listenerCount(emitter : EventEmitter, event : String) : Int;
	
	/**
	 * Adds a listener to the end of the listeners array for the specified event.
	 * @param	event
	 * @param	listener
	 */
	function on(event : String, listener : Dynamic):EventEmitter;
	
	/**
	 * Adds a one time listener for the event. This listener is invoked only the next time the event is fired, after which it is removed.
	 * @param	event
	 * @param	listener
	 */
	function once(event : String, listener : Dynamic) : EventEmitter;
	
	/**
	 * Returns an array of listeners for the specified event.
	 * @param	event
	 * @return
	 */
	function listeners(event:String):Array<Dynamic>;
	
	/**
	 * Removes all listeners, or those of the specified event.
	 * Returns emitter, so calls can be chained.
	 */
	@:overload(function():EventEmitter{})
	function removeAllListeners(event:String):EventEmitter;
}