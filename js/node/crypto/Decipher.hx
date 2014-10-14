package js.node.crypto;

import js.node.Buffer;

/**
	Class for decrypting data.

	Returned by `Crypto.createDecipher` and `Crypto.createDecipheriv`.

	Decipher objects are streams that are both readable and writable.
	The written enciphered data is used to produce the plain-text data on the the readable side.

	The legacy `update` and `final` methods are also supported.
**/
extern class Decipher extends js.node.stream.Transform {

	/**
		Updates the decipher with `data`, which is encoded in 'binary', 'base64' or 'hex'.
		If no encoding is provided, then a buffer is expected.

		The `output_decoding` specifies in what format to return the deciphered plaintext: 'binary', 'ascii' or 'utf8'.
		If no encoding is provided, then a buffer is returned.
	**/
	@:overload(function(data:Buffer):Buffer {})
	@:overload(function(data:String, input_encoding:String):Buffer {})
	function update(data:String, input_encoding:String, output_encoding:String):String;

	/**
		Returns any remaining plaintext which is deciphered,
		with `output_encoding` being one of: 'binary', 'ascii' or 'utf8'.
		If no encoding is provided, then a buffer is returned.

		Note: decipher object can not be used after `final` method has been called.
	**/
	@:overload(function():Buffer {})
	function final(output_encoding:String):String;

	/**
		You can disable auto padding if the data has been encrypted without standard block padding
		to prevent `final` from checking and removing it.

		Can only work if the input data's length is a multiple of the ciphers block size.

		You must call this before streaming data to `update`.
	**/
	@:overload(function():Void {})
	function setAutoPadding(auto_padding:Bool):Void;
}
