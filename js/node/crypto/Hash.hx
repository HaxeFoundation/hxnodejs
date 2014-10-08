package js.node.crypto;

import js.node.Buffer;

/**
	The class for creating hash digests of data.

	It is a stream that is both readable and writable.
	The written data is used to compute the hash.
	Once the writable side of the stream is ended, use the `read` method to get the computed hash digest.

	The legacy `update` and `digest` methods are also supported.

	Returned by `Crypto.createHash`.
**/
extern class Hash extends js.node.stream.Transform {
	/**
		Updates the hash content with the given `data`,

		the `encoding` of which is given in `input_encoding` and can be 'utf8', 'ascii' or 'binary'.
		If no `encoding` is provided and the input is a string an encoding of 'binary' is enforced.
		If `data` is a `Buffer` then `input_encoding` is ignored.

		This can be called many times with new data as it is streamed.
	**/
	@:overload(function(data:Buffer):Void {})
	function update(data:String, ?input_encoding:String):Void;

	/**
		Calculates the digest of all of the passed data to be hashed.
		The `encoding` can be 'hex', 'binary' or 'base64'.
		If no `encoding` is provided, then a buffer is returned.

		Note: hash object can not be used after `digest` method has been called.
	**/
	@:overload(function():Buffer {})
	function digest(encoding:String):String;
}
