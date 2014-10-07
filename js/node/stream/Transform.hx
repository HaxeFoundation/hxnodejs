package js.node.stream;

/**
	Transform streams are `Duplex` streams where the output is in some way computed from the input.
	They implement both the `Readable` and `Writable` interfaces.

	Examples of Transform streams include:

		- zlib streams
		- crypto streams
**/
@:jsRequire("stream", "Transform")
extern class Transform extends Duplex {}
