package nodejs.crypto;
import nodejs.Buffer;
import nodejs.fs.ReadStream;
import nodejs.fs.WriteStream;

/**
 * Class for creating cryptographic hmac content.
 * Returned by crypto.createHmac.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class Hmac
{
	/**
	 * Update the hmac content with the given data. This can be called many times with new data as it is streamed.
	 * @param	data
	 */	
	function update(data : Dynamic) : Void;
	
	/**
	 * Calculates the digest of all of the passed data to the hmac. The encoding can be 'hex', 'binary' or 'base64'. If no encoding is provided, then a buffer is returned.
	 * Note: hmac object can not be used after digest() method has been called.
	 * @param	encoding
	 */
	@:overload(function():Buffer{})
	function digest(encoding:String):Void;
	
}