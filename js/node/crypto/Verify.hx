package js.node.crypto;

import js.node.Buffer;
import js.node.stream.Writable;

/**
	Class for verifying signatures.
	Returned by `Crypto.createVerify`.

	Verify objects are writable streams. The written data is used to validate against the supplied signature.
	Once all of the data has been written, the verify method will return true if the supplied signature is valid.

	The legacy `update` method is also supported.
**/
extern class Verify extends Writable<Sign> {

	/**
		Updates the verifier object with data. This can be called many times with new data as it is streamed.
	**/
	@:overload(function(data:Buffer):Void {})
	function update(data:String, ?encoding:String):Void;

	/**
		Verifies the signed data by using the object and signature.

		`object` is a string containing a PEM encoded object, which can be one of RSA public key,
		DSA public key, or X.509 certificate.

		`signature` is the previously calculated signature for the data,
		in the `signature_format` which can be 'binary', 'hex' or 'base64'.
		If no encoding is specified, then a buffer is expected.

		Returns true or false depending on the validity of the signature for the data and public key.

		Note: verifier object can not be used after `verify` method has been called.
	**/
	@:overload(function(object:String, signature:Buffer):Bool {})
	function verify(object:String, signature:String, signature_format:String):Bool;
}
