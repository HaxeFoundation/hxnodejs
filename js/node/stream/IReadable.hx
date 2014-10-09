package js.node.stream;

import js.node.events.IEventEmitter;

/**
    Readable interface used for type parameter constraints.
    See `Readable` for actual class documentation.
**/
@:remove
extern interface IReadable extends IEventEmitter {
    @:overload(function(?size:Int):Null<Buffer> {})
    function read(?size:Int):Null<String>;
    function setEncoding(encoding:String):Void;
    function resume():Void;
    function pause():Void;
    function pipe<T:IWritable>(destination:T, ?options:{end:Bool}):T;
    function unpipe(?destination:IWritable):Void;
    @:overload(function(chunk:Buffer):Void {})
    function unshift(chunk:String):Void;
    function wrap(stream:Dynamic):IReadable;
}
