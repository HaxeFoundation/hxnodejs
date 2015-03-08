package js.node.stream;

import haxe.extern.EitherType;

/**
	Transform streams are `Duplex` streams where the output is in some way computed from the input.
	They implement both the `Readable` and `Writable` interfaces.

	Examples of Transform streams include:

		- zlib streams
		- crypto streams
**/
@:jsRequire("stream", "Transform")
extern class Transform<TSelf:Transform<TSelf>> extends Duplex<TSelf> {
    // --------- API for stream implementors - see node.js API documentation ---------
    private function new(?options:Duplex.DuplexNewOptions);
    @:overload(function(chunk:String, encoding:String, callback:js.Error->EitherType<String,Buffer>->Void):Void {})
    private function _transform(chunk:Buffer, encoding:String, callback:js.Error->EitherType<String,Buffer>->Void):Void;
    private function _flush(callback:js.Error->Void):Void;
}
