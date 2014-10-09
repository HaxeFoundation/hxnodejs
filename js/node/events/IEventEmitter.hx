package js.node.events;

import haxe.Constraints.Function;

/**
    EventEmitter interface used for type parameter constraints.
    See `EventEmitter` for actual class documentation.
**/
@:remove
extern interface IEventEmitter {
    function addListener(event:String, listener:Function):EventEmitter;
    function on(event:String, listener:Function):EventEmitter;
    function once(event:String, listener:Function):EventEmitter;
    function removeListener(event:String, listener:Function):EventEmitter;
    function removeAllListeners(?event:String):EventEmitter;
    function setMaxListeners(n:Int):EventEmitter;
    function listeners(event:String):Array<Function>;
    function emit(event:String, args:haxe.Rest<Dynamic>):Bool;
}
