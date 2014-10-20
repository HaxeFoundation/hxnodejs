package js.node.stream;

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
    private function _transform(chunk:Dynamic, encoding:String, callback:js.Error->Dynamic->Void):Void;
    private function _flush(callback:js.Error->Void):Void;
}
