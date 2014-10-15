package js.node.events;

import haxe.Constraints.Function;

/**
	Enumeration of events emitted by all `EventEmitter` instances.
**/
@:enum abstract EventEmitterEvent(String) to String {
	/**
		This event is emitted any time someone adds a new listener.

		Listener arguments:
			event : String - The event name
			listener : Function - The event handler function

		It is unspecified if listener is in the list returned by emitter.listeners(event).
	**/
	var NewListener = "newListener";

	/**
		This event is emitted any time someone removes a listener.

		Listener arguments:
			event:String - The event name
			listener:Function - The event handler function

		It is unspecified if listener is in the list returned by emitter.listeners(event).
	**/
	var RemoveListener = "removeListener";
}

/**
	All objects which emit events are instances of `EventEmitter`.

	Typically, event names are represented by a camel-cased string, however,
	there aren't any strict restrictions on that, as any string will be accepted.

	Functions can then be attached to objects, to be executed when an event is emitted.
	These functions are called listeners.

	When an `EventEmitter` instance experiences an error, the typical action is to emit an 'error' event.
	Error events are treated as a special case in node. If there is no listener for it, then the default action
	is to print a stack trace and exit the program.

	All `EventEmitter`s emit the event `newListener` when new listeners are added
	and `removeListener` when a listener is removed.
**/
@:jsRequire("events", "EventEmitter")
extern class EventEmitter<TSelf:EventEmitter<TSelf>> implements IEventEmitter {

	function new();

	/**
		Adds a `listener` to the end of the listeners array for the specified `event`.
	**/
	function addListener(event:String, listener:Function):TSelf;
	function on(event:String, listener:Function):TSelf;

	/**
		Adds a one time `listener` for the `event`.

		This listener is invoked only the next time the event is fired, after which it is removed.
	**/
	function once(event:String, listener:Function):TSelf;

	/**
		Remove a `listener` from the listener array for the specified `event`.

		Caution: changes array indices in the listener array behind the listener.
	**/
	function removeListener(event:String, listener:Function):TSelf;

	/**
		Removes all listeners, or those of the specified `event`.
	**/
	function removeAllListeners(?event:String):TSelf;

	/**
		By default `EventEmitter`s will print a warning if more than 10 listeners are added for a particular event.
		This is a useful default which helps finding memory leaks.

		Obviously not all Emitters should be limited to 10. This function allows that to be increased.
		Set to zero for unlimited.
	**/
	function setMaxListeners(n:Int):Void;

	/**
		Returns an array of listeners for the specified event.
	**/
	function listeners(event:String):Array<Function>;

	/**
		Execute each of the listeners in order with the supplied arguments.
		Returns true if event had listeners, false otherwise.
	**/
	function emit(event:String, args:haxe.Rest<Dynamic>):Bool;

	/**
		Return the number of listeners for a given event.
	**/
	static function listenerCount(emitter:IEventEmitter, event:String):Int;
}


/**
    `IEventEmitter` interface is used as "any EventEmitter".

    See `EventEmitter` for actual class documentation.
**/
@:remove
extern interface IEventEmitter {
    function addListener(event:String, listener:Function):IEventEmitter;
    function on(event:String, listener:Function):IEventEmitter;
    function once(event:String, listener:Function):IEventEmitter;
    function removeListener(event:String, listener:Function):IEventEmitter;
    function removeAllListeners(?event:String):IEventEmitter;
    function setMaxListeners(n:Int):Void;
    function listeners(event:String):Array<Function>;
    function emit(event:String, args:haxe.Rest<Dynamic>):Bool;
}
