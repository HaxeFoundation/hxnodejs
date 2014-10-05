package nodejs.crypto;
import js.Error;
import nodejs.Buffer;


/**
 * Enumeration that describe a Crypto Algorithm to be used.
 */
class CryptoAlgorithm
{
	/**
	 * 
	 */
	static public var SHA1   : String = "sha1";
	
	/**
	 * 
	 */
	static public var MD5    : String = "md5";
	
	/**
	 * 
	 */
	static public var SHA256 : String = "sha256";
	
	/**
	 * 
	 */
	static public var SHA512 : String = "sha512";
	
}

/**
 * 
 */
extern class CredentialOption
{
	
	/**
	 *  A string or buffer holding the PFX or PKCS12 encoded private key, certificate and CA certificates
	 */
	var pfx : String;
	
	/**
	 *  A string holding the PEM encoded private key
	 */
	var key : String;
	
	/**
	 *  A string of passphrase for the private key or pfx
	 */
	var passphrase : String;
	
	/**
	 *  A string holding the PEM encoded certificate
	 */
	var cert : String;
	
	/**
	 * Either a string or list of strings of PEM encoded CA certificates to trust.
	 * If no 'ca' details are given, then node.js will use the default publicly trusted list of CAs as given in
	 * http://mxr.mozilla.org/mozilla/source/security/nss/lib/ckfw/builtins/certdata.txt.
	 */	
	var ca : Array<String>;
	
	/**
	 *  Either a string or list of strings of PEM encoded CRLs (Certificate Revocation List)
	 */
	var crl : Array<String>;
	
	/**
	 *  A string describing the ciphers to use or exclude. Consult http://www.openssl.org/docs/apps/ciphers.html#CIPHER_LIST_FORMAT for details on the format.
	 */
	var ciphers : String;
	
}

/**
 * Use require('crypto') to access this module.
 * The crypto module offers a way of encapsulating secure credentials to be used as part of a secure HTTPS net or http connection.
 * It also offers a set of wrappers for OpenSSL's hash, hmac, cipher, decipher, sign and verify methods.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('crypto'))")
extern class Crypto
{
	/**
	 * The default encoding to use for functions that can take either strings or buffers.
	 * The default value is 'buffer', which makes it default to using Buffer objects.
	 * This is here to make the crypto module more easily compatible with legacy programs that expected 'binary' to be the default encoding.
	 * Note that new programs will probably expect buffers, so only use this as a temporary measure.
	 */
	static var DEFAULT_ENCODING : String;

	/**
	 * Returns an array with the names of the supported ciphers.
	 * @return
	 */
	static function getCiphers() : Array<String>;
	
	/**
	 * Returns an array with the names of the supported hash algorithms.
	 * @return
	 */
	static function getHashes() : Array<String>;
	
	/**
	 * Creates a credentials object, with the optional details being a dictionary with keys:
	 * @param	details
	 * @return
	 */
	static function createCredentials(details : CredentialOption):Dynamic;
	
	/**
	 * Creates and returns a hash object, a cryptographic hash with the given algorithm which can be used to generate hash digests.
	 * algorithm is dependent on the available algorithms supported by the version of OpenSSL on the platform.
	 * Examples are 'sha1', 'md5', 'sha256', 'sha512', etc. 
	 * On recent releases, openssl list-message-digest-algorithms will display the available digest algorithms.
	 * @param	algorithm
	 * @return
	 */
	static function createHash(algorithm : String) : Dynamic;
	
	
	/**
	 * Creates and returns a hmac object, a cryptographic hmac with the given algorithm and key.
	 * It is a stream that is both readable and writable. The written data is used to compute the hmac. 
	 * Once the writable side of the stream is ended, use the read() method to get the computed digest. The legacy update and digest methods are also supported.
	 * algorithm is dependent on the available algorithms supported by OpenSSL - see createHash above. 
	 * key is the hmac key to be used.
	 * @param	algorithm
	 * @param	key
	 * @return
	 */
	static function createHmac(algorithm : String, key : Dynamic) : Hmac;
	
	
	/**
	 * Creates and returns a cipher object, with the given algorithm and password.
	 * algorithm is dependent on OpenSSL, examples are 'aes192', etc. On recent releases, openssl list-cipher-algorithms will display the available cipher algorithms.
	 * password is used to derive key and IV, which must be a 'binary' encoded string or a buffer.
	 * It is a stream that is both readable and writable. The written data is used to compute the hash. Once the writable side of the stream is ended, use the read() method to get the computed hash digest. The legacy update and digest methods are also supported.
	 * @param	algorithm
	 * @param	password
	 * @return
	 */
	static function createCipher(algorithm : String, password : String) : Cipher;
	
	
	/**
	 * Creates and returns a cipher object, with the given algorithm, key and iv.
	 * algorithm is the same as the argument to createCipher(). 
	 * key is the raw key used by the algorithm. 
	 * iv is an initialization vector.
	 * key and iv must be 'binary' encoded strings or buffers.
	 * @param	algorithm
	 * @param	key
	 * @param	iv
	 * @return
	 */
	static function createCipheriv(algorithm : String, key : Dynamic, iv:Dynamic) : Cipher;
	
	/**
	 * Creates and returns a decipher object, with the given algorithm and key. This is the mirror of the createCipher() above.
	 * @param	algorithm
	 * @param	password
	 * @return
	 */
	static function createDecipher(algorithm : String, password : String) : Decipher;
	
	/**
	 * Creates and returns a decipher object, with the given algorithm, key and iv. This is the mirror of the createCipheriv() above.
	 * @param	algorithm
	 * @param	key
	 * @param	iv
	 * @return
	 */
	static function createDecipheriv(algorithm : String, key : Dynamic, iv : Dynamic) : Decipher;
	
	
	/**
	 * Creates and returns a signing object, with the given algorithm. 
	 * On recent OpenSSL releases, openssl list-public-key-algorithms will display the available signing algorithms. 
	 * Examples are 'RSA-SHA256'.
	 * @param	algorithm
	 * @return
	 */
	static function createSign(algorithm : String) : Sign;
	
	/**
	 * Creates and returns a verification object, with the given algorithm. This is the mirror of the signing object above.
	 * @param	algorithm
	 * @return
	 */
	static function createVerify(algorithm : String) : Verify;
	
	
	/**
	 * Creates a Diffie-Hellman key exchange object using the supplied prime. The generator used is 2. Encoding can be 'binary', 'hex', or 'base64'. If no encoding is specified, then a buffer is expected.
	 * @param	prime_length
	 * @return
	 */
	@:overload(function (prime_length : Int,p_encoding:String) : Dynamic {})
	static function createDiffieHellman(prime_length : Int) : Dynamic;
	
	/**
	 * Creates a predefined Diffie-Hellman key exchange object. 
	 * The supported groups are: 'modp1', 'modp2', 'modp5' (defined in RFC 2412) and 'modp14', 'modp15', 'modp16', 'modp17', 'modp18' (defined in RFC 3526). 
	 * The returned object mimics the interface of objects created by crypto.createDiffieHellman() above, 
	 * but will not allow to change the keys (with diffieHellman.setPublicKey() for example). 
	 * The advantage of using this routine is that the parties don't have to generate nor exchange group modulus beforehand, saving both processor and communication time.
	 * @param	group_name
	 * @return
	 */
	static function getDiffieHellman(group_name : String) : DiffieHellman;
	
	
	/**
	 * Asynchronous PBKDF2 applies pseudorandom function HMAC-SHA1 to derive a key of given length from the given password, salt and iterations. 
	 * The callback gets two arguments (err, derivedKey).
	 * @param	password
	 * @param	salt
	 * @param	iterations
	 * @param	keylen
	 * @param	callback
	 * @return
	 */
	static function pbkdf2(password : String, salt : Dynamic, iterations : Int, keylen : Int, callback : String -> Dynamic -> Void) : Void;
	
	/**
	 * Synchronous PBKDF2 function. Returns derivedKey or throws error.
	 * @param	password
	 * @param	salt
	 * @param	iterations
	 * @param	keylen
	 * @return
	 */
	static function pbkdf2Sync(password : String, salt : Dynamic, iterations : Int, keylen : Int) : Dynamic;
	
	
	/**
	 * Generates cryptographically strong pseudo-random data. 
	 * @param	size
	 * @param	[callback]
	 * @return
	 */
	@:overload(function(size:Int,callback : Error -> Buffer -> Void):Void{})
	static function randomBytes(size : Int) : Buffer;
	
	/**
	 * Generates non-cryptographically strong pseudo-random data. 
	 * The data returned will be unique if it is sufficiently long, but is not necessarily unpredictable.
	 * For this reason, the output of this function should never be used where unpredictability is important, such as in the generation of encryption keys.
	 * @param	size
	 * @param	[callback]
	 * @return
	 */
	@:overload(function(size:Int,callback : Error -> Buffer -> Void):Void{})
	static function pseudoRandomBytes(size : Int) : Buffer;
	
}