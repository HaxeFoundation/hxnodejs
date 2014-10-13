package js.node.crypto;

import js.node.Buffer;
import js.node.stream.Writable;

/**
	Class for generating signatures.

	Returned by `Crypto.createSign`.

	Sign objects are writable streams. The written data is used to generate the signature.
	Once all of the data has been written, the sign method will return the signature.

	The legacy `update` method is also supported.
**/
extern class Sign extends Writable {

	/**
		Updates the sign object with data.
		This can be called many times with new data as it is streamed.
	**/
	@:overload(function(data:Buffer):Void {})
	function update(data:String, ?encoding:String):Void;

	/**
		Calculates the signature on all the updated data passed through the sign.
		`private_key` is a string containing the PEM encoded private key for signing.
		Returns the signature in `output_format` which can be 'binary', 'hex' or 'base64'.
		If no encoding is provided, then a buffer is returned.

		Note: sign object can not be used after `sign` method has been called.
	**/
	@:overload(function(private_key:String):Buffer {})
	function sign(private_key:String, output_format:String):String;
}
