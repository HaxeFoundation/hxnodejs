package js.node.stream;

import js.node.Buffer;
import js.node.events.IEventEmitter;

/**
    Writable interface used for type parameter constraints.
    See `Writable` for actual class documentation.
**/
@:remove
extern interface IWritable extends IEventEmitter {
	@:overload(function(chunk:Buffer, ?callback:Void->Void):Bool {})
	@:overload(function(chunk:String, ?callback:Void->Void):Bool {})
	function write(chunk:String, encoding:String, ?callback:Void->Void):Bool;
	@:overload(function(?callback:Void->Void):Void {})
	@:overload(function(chunk:Buffer, ?callback:Void->Void):Void {})
	@:overload(function(chunk:String, ?callback:Void->Void):Void {})
	function end(chunk:String, encoding:String, ?callback:Void->Void):Void;
}
