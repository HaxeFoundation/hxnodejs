package js.node.crypto;

import js.node.Buffer;

/**
	Class for creating cryptographic hmac content.

	It is a stream that is both readable and writable. The written data is used to compute the hmac.
	Once the writable side of the stream is ended, use the `read` method to get the computed digest.

	The legacy `update` and `digest` methods are also supported.

	Returned by `Crypto.createHmac`.
**/
extern class Hmac extends js.node.stream.Transform<Hmac> {
	/**
		Update the hmac content with the given data.

		This can be called many times with new data as it is streamed.
	**/
	@:overload(function(data:Buffer):Void {})
	function update(data:String, ?input_encoding:String):Void;

	/**
		Calculates the digest of all of the passed data to the hmac.
		The `encoding` can be 'hex', 'binary' or 'base64'.
		If no `encoding` is provided, then a buffer is returned.

		Note: hmac object can not be used after `digest` method has been called.
	**/
	@:overload(function():Buffer {})
	function digest(encoding:String):String;
}
