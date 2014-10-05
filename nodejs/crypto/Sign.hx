package nodejs.crypto;
import nodejs.Buffer;

/**
 * Class for generating signatures.
 * Returned by crypto.createSign.
 * Sign objects are writable streams. 
 * The written data is used to generate the signature. 
 * Once all of the data has been written, the sign method will return the signature. 
 * The legacy update method is also supported.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class Sign
{
	/**
	 * Updates the sign object with data. This can be called many times with new data as it is streamed.
	 * @param	data
	 */
	function update(data : Dynamic) : Void;
	
	/**
	 * Calculates the signature on all the updated data passed through the sign. private_key is a string containing the PEM encoded private key for signing.
	 * Returns the signature in output_format which can be 'binary', 'hex' or 'base64'. If no encoding is provided, then a buffer is returned.
	 * Note: sign object can not be used after sign() method has been called.
	 * @param	private_key
	 * @param	output_format
	 * @return
	 */
	@:overload(function (private_key:String):Dynamic{})
	function sign(private_key:String, output_format:String):Dynamic;
	
}