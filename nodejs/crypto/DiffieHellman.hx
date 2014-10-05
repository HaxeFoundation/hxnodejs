package nodejs.crypto;
import nodejs.Buffer;

/**
 * The class for creating Diffie-Hellman key exchanges.
 * Returned by crypto.createDiffieHellman.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class DiffieHellman
{
	/**
	 * Generates private and public Diffie-Hellman key values, and returns the public key in the specified encoding.
	 * This key should be transferred to the other party. 
	 * Encoding can be 'binary', 'hex', or 'base64'. 
	 * If no encoding is provided, then a buffer is returned.
	 * @param	encoding
	 * @return
	 */
	@:overload(function():Buffer{})
	function generateKeys(encoding:String):Dynamic;
	
	
	/**
	 * Computes the shared secret using other_public_key as the other party's public key and returns the computed shared secret. 
	 * Supplied key is interpreted using specified input_encoding, and secret is encoded using specified output_encoding.
	 * Encodings can be 'binary', 'hex', or 'base64'.
	 * If the input encoding is not provided, then a buffer is expected.
	 * @param	other_public_key
	 * @param	input_encoding
	 * @param	output_encoding
	 * @return
	 */
	@:overload(function (other_public_key : Dynamic) : Buffer{})
	@:overload(function (other_public_key : Dynamic, input_encoding : String) : Dynamic{})
	function computeSecret(other_public_key : Dynamic, input_encoding : String, output_encoding:String) : Dynamic;
	
	
	/**
	 * Returns the Diffie-Hellman prime in the specified encoding, which can be 'binary', 'hex', or 'base64'.
	 * If no encoding is provided, then a buffer is returned.
	 * @param	encoding
	 * @return
	 */
	@:overload(function():Buffer{})	
	function getPrime(encoding:String):Dynamic;
		
	/**
	 * Returns the Diffie-Hellman generator in the specified encoding, which can be 'binary', 'hex', or 'base64'.
	 * If no encoding is provided, then a buffer is returned.
	 * @param	encoding
	 * @return
	 */
	@:overload(function():Buffer{})	
	function getGenerator(encoding:String):Dynamic;
	
	/**
	 * Returns the Diffie-Hellman public key in the specified encoding, which can be 'binary', 'hex', or 'base64'.
	 * If no encoding is provided, then a buffer is returned.
	 * @param	encoding
	 * @return
	 */
	@:overload(function():Buffer{})	
	function getPublicKey(encoding:String):Dynamic;
	
	/**
	 * Returns the Diffie-Hellman private key in the specified encoding, which can be 'binary', 'hex', or 'base64'.
	 * If no encoding is provided, then a buffer is returned.
	 * @param	encoding
	 * @return
	 */
	@:overload(function():Buffer{})	
	function getPrivateKey(encoding:String):Dynamic;
	
	/**
	 * Sets the Diffie-Hellman public key. 
	 * Key encoding can be 'binary', 'hex' or 'base64'. 
	 * If no encoding is provided, then a buffer is expected.
	 * @param	private_key
	 * @param	encoding
	 * @return
	 */
	@:overload(function(public_key :Buffer):Void{})		
	function setPublicKey(public_key :Dynamic,encoding:String):Void;
	
	
	/**
	 * Sets the Diffie-Hellman private key. Key encoding can be 'binary', 'hex' or 'base64'.
	 * If no encoding is provided, then a buffer is expected.
	 * @param	private_key
	 * @param	encoding
	 * @return
	 */
	@:overload(function(private_key :Buffer):Void{})		
	function setPrivateKey(private_key :Dynamic,encoding:String):Void;
	
		
}