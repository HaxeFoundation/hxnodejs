package nodejs.crypto;
import nodejs.Buffer;

/**
 * Class for encrypting data.
 * Returned by crypto.createCipher and crypto.createCipheriv.
 * Cipher objects are streams that are both readable and writable. 
 * The written plain text data is used to produce the encrypted data on the readable side. 
 * The legacy update and final methods are also supported.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class Cipher
{
	/**
	 * Updates the cipher with data, the encoding of which is given in input_encoding and can be 'utf8', 'ascii' or 'binary'. 
	 * If no encoding is provided, then a buffer is expected. 
	 * If data is a Buffer then input_encoding is ignored.
	 * The output_encoding specifies the output format of the enciphered data, and can be 'binary', 'base64' or 'hex'. 
	 * If no encoding is provided, then a buffer is returned.
	 * Returns the enciphered contents, and can be called many times with new data as it is streamed.
	 * @param	data
	 * @param	input_encoding
	 * @param	output_encoding
	 */
	@:overload(function(data:Buffer):Dynamic{})
	@:overload(function(data:String):Dynamic { } )
	@:overload(function(data:String, input_encoding:String):Dynamic{})
	function update(data : String, input_encoding:String,output_encoding:String) : Dynamic;
	
	/**
	 * Returns any remaining enciphered contents, with output_encoding being one of: 'binary', 'base64' or 'hex'. 
	 * If no encoding is provided, then a buffer is returned.
	 * Note: cipher object can not be used after final() method has been called.
	 * @param	output_encoding
	 */
	@:overload(function():Buffer{})
	function final(output_encoding:String):Void;
	
	/**
	 * You can disable automatic padding of the input data to block size. 
	 * If auto_padding is false, the length of the entire input data must be a multiple of the cipher's block size or final will fail. 
	 * Useful for non-standard padding, e.g. using 0x0 instead of PKCS padding. 
	 * You must call this before cipher.final.
	 * @param	auto_padding
	 */
	@:overload(function():Void { } )	
	function setAutoPadding(auto_padding : Bool):Void;
	
}