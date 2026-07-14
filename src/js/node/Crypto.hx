/*
 * Copyright (C)2014-2020 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package js.node;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.html.SubtleCrypto;
import js.lib.ArrayBuffer;
import js.lib.ArrayBufferView;
import js.lib.Error;
import js.node.Buffer;
import js.node.crypto.*;
import js.node.crypto.DiffieHellman.IDiffieHellman;
import js.node.tls.SecureContext;

/**
	Enumerations of crypto algorighms to be used.
**/
enum abstract CryptoAlgorithm(String) from String to String {
	var SHA1 = "sha1";
	var MD5 = "md5";
	var SHA256 = "sha256";
	var SHA512 = "sha512";
}

/**
	Enumeration of supported group names for `Crypto.getDiffieHellman`.
**/
enum abstract DiffieHellmanGroupName(String) from String to String {
	var Modp1 = "modp1";
	var Modp2 = "modp2";
	var Modp5 = "modp5";
	var Modp14 = "modp14";
	var Modp15 = "modp15";
	var Modp16 = "modp16";
	var Modp17 = "modp17";
	var Modp18 = "modp18";
}

/**
	The crypto module offers a way of encapsulating secure credentials
	to be used as part of a secure HTTPS net or http connection.

	It also offers a set of wrappers for OpenSSL's hash, hmac, cipher, decipher, sign and verify methods.
**/
@:jsRequire("crypto")
extern class Crypto {
	/**
		Load and set engine for some/all OpenSSL functions (selected by `flags`).

		`engine` could be either an id or a path to the to the engine's shared library.

		`flags` is optional and has `Constants.ENGINE_METHOD_ALL` value by default.
		It could take one of or mix of flags prefixed with `ENGINE_METHOD_` defined in `Constants` module.
	**/
	static function setEngine(engine:String, ?flags:Int):Void;

	/**
		The default encoding to use for functions that can take either strings or buffers.
		The default value is 'buffer', which makes it default to using `Buffer` objects.
		This is here to make the crypto module more easily compatible with legacy programs
		that expected 'binary' to be the default encoding.

		Note that new programs will probably expect buffers, so only use this as a temporary measure.
	**/
	@:deprecated
	static var DEFAULT_ENCODING:String;

	/**
		Property for checking and controlling whether a FIPS compliant crypto provider is currently in use.
		Setting to true requires a FIPS build of Node.js.

		Deprecated since Node.js v10.0.0. Use `getFips` / `setFips` instead.
	**/
	@:deprecated
	static var fips:Bool;

	/**
		OpenSSL crypto constants (padding modes, DH check codes, engine methods, etc.).
	**/
	static var constants(default, never):DynamicAccess<Int>;

	/**
		A convenient alias for `Crypto.webcrypto.subtle`.
	**/
	static var subtle(default, never):SubtleCrypto;

	/**
		Node.js Web Crypto API implementation (`crypto.webcrypto`).

		Typed as the Haxe std `js.html.Crypto` surface. Node-specific Web Crypto
		extensions beyond that DOM typedef are not duplicated here — no separate
		`js.node.webcrypto` package.

		// TODO(section-4): audit Node-only Web Crypto additions vs `js.html.Crypto`
	**/
	static var webcrypto(default, never):js.html.Crypto;

	/**
		Returns `1` if and only if a FIPS compliant crypto provider is currently in use, `0` otherwise.
	**/
	static function getFips():Int;

	/**
		Enables the FIPS compliant crypto provider in a FIPS-enabled Node.js build.
		Throws an error if FIPS mode is not available.
	**/
	static function setFips(bool:Bool):Void;

	/**
		Returns an array with the names of the supported ciphers.
	**/
	static function getCiphers():Array<String>;

	/**
		Returns information about a given cipher.

		Some ciphers accept variable length keys and initialization vectors.
		By default, the method will return the default values for these ciphers.
		To test if a given key length or IV length is acceptable for a given cipher,
		use the `keyLength` and `ivLength` options.
		If the given values are unacceptable, `null`/`undefined` will be returned.
	**/
	static function getCipherInfo(nameOrNid:EitherType<String, Int>, ?options:CipherInfoOptions):Null<CipherInfo>;

	/**
		Returns an array with the names of the supported hash algorithms.
	**/
	static function getHashes():Array<String>;

	/**
		Returns an array with the names of the supported elliptic curves.
	**/
	static function getCurves():Array<String>;

	/**
		Creates a credentials object
	**/
	@:deprecated("Use js.node.Tls.createSecureContext instead.")
	static function createCredentials(?details:SecureContextOptions):SecureContext;

	/**
		Creates and returns a hash object, a cryptographic hash with the given algorithm which can be used to generate hash digests.
		`algorithm` is dependent on the available algorithms supported by the version of OpenSSL on the platform.
		Examples are 'sha1', 'md5', 'sha256', 'sha512', etc.
		On recent releases, openssl list-message-digest-algorithms will display the available digest algorithms.
	**/
	static function createHash(algorithm:CryptoAlgorithm):Hash;

	/**
		Creates and returns a hmac object, a cryptographic hmac with the given algorithm and key.
		`algorithm` is dependent on the available algorithms supported by OpenSSL - see `createHash` above.
		`key` is the hmac key to be used.
	**/
	static function createHmac(algorithm:CryptoAlgorithm, key:EitherType<String, Buffer>):Hmac;

	/**
		Creates and returns a cipher object, with the given algorithm and password.

		`algorithm` is dependent on OpenSSL, examples are 'aes192', etc.
		On recent releases, openssl list-cipher-algorithms will display the available cipher algorithms.

		`password` is used to derive key and IV, which must be a 'binary' encoded string or a buffer.

		It is a stream that is both readable and writable. The written data is used to compute the hash.
		Once the writable side of the stream is ended, use the `read` method to get the computed hash digest.
		The legacy `update` and `digest` methods are also supported.
	**/
	static function createCipher(algorithm:String, password:EitherType<String, Buffer>):Cipher;

	/**
		Creates and returns a cipher object, with the given algorithm, key and iv.

		`algorithm` is the same as the argument to `createCipher`.

		`key` is the raw key used by the algorithm.

		`iv` is an initialization vector.

		`key` and `iv` must be 'binary' encoded strings or buffers.
	**/
	@:overload(function(algorithm:String, key:EitherType<EitherType<String, Buffer>, KeyObject>, iv:Null<EitherType<String, Buffer>>):Cipher {})
	static function createCipheriv(algorithm:String, key:EitherType<String, Buffer>, iv:EitherType<String, Buffer>):Cipher;

	/**
		Creates and returns a decipher object, with the given algorithm and key.
		This is the mirror of the `createCipher` above.
	**/
	static function createDecipher(algorithm:String, password:EitherType<String, Buffer>):Decipher;

	/**
		Creates and returns a decipher object, with the given algorithm, key and iv.
		This is the mirror of the `createCipheriv` above.
	**/
	@:overload(function(algorithm:String, key:EitherType<EitherType<String, Buffer>, KeyObject>, iv:Null<EitherType<String, Buffer>>):Decipher {})
	static function createDecipheriv(algorithm:String, key:EitherType<String, Buffer>, iv:EitherType<String, Buffer>):Decipher;

	/**
		Creates and returns a signing object, with the given algorithm.
		On recent OpenSSL releases, openssl list-public-key-algorithms will display the available signing algorithms.
		Example: 'RSA-SHA256'.
	**/
	static function createSign(algorithm:String):Sign;

	/**
		Creates and returns a verification object, with the given algorithm.
		This is the mirror of the signing object above.
	**/
	static function createVerify(algorithm:String):Verify;

	/**
		Creates a Diffie-Hellman key exchange object using the supplied `prime` or generated prime of given bit `prime_length`.
		The generator used is 2. `encoding` can be 'binary', 'hex', or 'base64'.

		Creates a Diffie-Hellman key exchange object and generates a prime of the given bit length. The generator used is 2.
	**/
	@:overload(function(prime_length:Int):DiffieHellman {})
	@:overload(function(prime:Buffer):DiffieHellman {})
	static function createDiffieHellman(prime:String, encoding:String):DiffieHellman;

	/**
		Creates a predefined Diffie-Hellman key exchange object.
		The supported groups are: 'modp1', 'modp2', 'modp5' (defined in RFC 2412) and 'modp14', 'modp15', 'modp16', 'modp17', 'modp18' (defined in RFC 3526).
		The returned object mimics the interface of objects created by `createDiffieHellman` above,
		but will not allow to change the keys (with setPublicKey() for example).
		The advantage of using this routine is that the parties don't have to generate nor exchange group modulus beforehand,
		saving both processor and communication time.
	**/
	static function getDiffieHellman(group_name:DiffieHellmanGroupName):IDiffieHellman;

	/**
		An alias for `getDiffieHellman`.
	**/
	static function createDiffieHellmanGroup(name:DiffieHellmanGroupName):DiffieHellmanGroup;

	/**
		Creates an Elliptic Curve (EC) Diffie-Hellman key exchange object using a predefined curve
		specified by the `curve_name` string. Use `getCurves` to obtain a list of available curve names.
		On recent releases, openssl ecparam -list_curves will also display the name
		and description of each available elliptic curve.
	**/
	static function createECDH(curve_name:String):ECDH;

	/**
		Creates and returns a new key object containing a private key.
	**/
	static function createPrivateKey(key:EitherType<String, EitherType<Buffer, CryptoKeyInput>>):KeyObject;

	/**
		Creates and returns a new key object containing a public key.
	**/
	static function createPublicKey(key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>):KeyObject;

	/**
		Creates and returns a new key object containing a secret key for symmetric encryption or `Hmac`.
	**/
	@:overload(function(key:String, encoding:String):KeyObject {})
	static function createSecretKey(key:EitherType<String, EitherType<Buffer, ArrayBufferView>>):KeyObject;

	/**
		Asynchronous PBKDF2 applies pseudorandom function HMAC-SHA1 to derive a key of given length
		from the given password, salt and iterations.
	**/
	@:overload(function(password:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, iterations:Int, keylen:Int, digest:String,
		callback:Error->Buffer->Void):Void {})
	static function pbkdf2(password:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, iterations:Int, keylen:Int,
		callback:Error->Buffer->Void):Void;

	/**
		Synchronous PBKDF2 function. Returns derivedKey or throws error.
	**/
	static function pbkdf2Sync(password:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, iterations:Int, keylen:Int, ?digest:String):Buffer;

	/**
		Provides an asynchronous scrypt implementation.
		Scrypt is a password-based key derivation function that is designed to be expensive
		computationally and memory-wise in order to make brute-force attacks unrewarding.
	**/
	@:overload(function(password:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, keylen:Int, options:ScryptOptions,
		callback:Error->Buffer->Void):Void {})
	static function scrypt(password:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, keylen:Int, callback:Error->Buffer->Void):Void;

	/**
		Provides a synchronous scrypt implementation.
	**/
	static function scryptSync(password:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, keylen:Int, ?options:ScryptOptions):Buffer;

	/**
		HKDF is a simple key derivation function defined in RFC 5869.
		The given `ikm`, `salt` and `info` are used with the `digest` to derive a key of `keylen` bytes.

		The successfully generated derived key is passed to the callback as an `ArrayBuffer`.
	**/
	static function hkdf(digest:String, ikm:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, info:EitherType<String, Buffer>, keylen:Int,
		callback:Error->ArrayBuffer->Void):Void;

	/**
		Provides a synchronous HKDF key derivation function as defined in RFC 5869.

		Returns the derived key as an `ArrayBuffer`.
	**/
	static function hkdfSync(digest:String, ikm:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, info:EitherType<String, Buffer>,
		keylen:Int):ArrayBuffer;

	/**
		Generates cryptographically strong pseudo-random data.

		If `callback` is specified, the function runs asynchronously, otherwise it will block and synchronously
		return random bytes.

		NOTE: Will throw error or invoke callback with error, if there is not enough accumulated entropy
		to generate cryptographically strong data. In other words, `randomBytes` without callback will not
		block even if all entropy sources are drained.
	**/
	@:overload(function(size:Int, callback:Error->Buffer->Void):Void {})
	static function randomBytes(size:Int):Buffer;

	/**
		This function is similar to `randomBytes` but requires the first argument to be a `Buffer` or `TypedArray`
		that will be filled. It also requires that a callback is passed in.

		The supplied callback is invoked with two arguments: `err` and `buf`.
		The `buf` argument is a reference to the `buffer` filled with random data.
	**/
	@:overload(function<T>(buffer:T, offset:Int, callback:Error->T->Void):Void {})
	@:overload(function<T>(buffer:T, offset:Int, size:Int, callback:Error->T->Void):Void {})
	static function randomFill<T>(buffer:T, callback:Error->T->Void):Void;

	/**
		Synchronous version of `randomFill`. Returns the filled buffer.
	**/
	@:overload(function<T>(buffer:T, offset:Int):T {})
	@:overload(function<T>(buffer:T, offset:Int, size:Int):T {})
	static function randomFillSync<T>(buffer:T):T;

	/**
		Return a random integer `n` such that `min <= n < max`.
		This implementation avoids modulo bias.

		The range (`max - min`) must be less than 2^48. `min` and `max` must be safe integers.

		If the callback function is not provided, the random integer is generated synchronously.
	**/
	@:overload(function(max:Int, callback:Error->Int->Void):Void {})
	@:overload(function(min:Int, max:Int):Int {})
	@:overload(function(min:Int, max:Int, callback:Error->Int->Void):Void {})
	static function randomInt(max:Int):Int;

	/**
		Generates a random RFC 4122 version 4 UUID.
		The UUID is generated using a cryptographic pseudorandom number generator.
	**/
	static function randomUUID(?options:RandomUUIDOptions):String;

	/**
		Generates a random RFC 9562 version 7 UUID.
		The UUID contains a millisecond precision Unix timestamp in the most significant 48 bits,
		followed by cryptographically secure random bits for the remaining fields.
		Added in Node.js v24.16.0 (Active LTS).
	**/
	static function randomUUIDv7(?options:RandomUUIDOptions):String;

	/**
		Compares the underlying bytes that represent the given `ArrayBuffer`, `Buffer`,
		or `ArrayBufferView` instances using a constant-time algorithm.
		`a` and `b` must have the same byte length.
	**/
	static function timingSafeEqual(a:CryptoArrayBufferLike, b:CryptoArrayBufferLike):Bool;

	/**
		Checks the primality of the `candidate`.
	**/
	@:overload(function(candidate:CryptoArrayBufferLike, options:CheckPrimeOptions, callback:Error->Bool->Void):Void {})
	static function checkPrime(candidate:CryptoArrayBufferLike, callback:Error->Bool->Void):Void;

	/**
		Checks the primality of the `candidate` (synchronous version).
	**/
	static function checkPrimeSync(candidate:CryptoArrayBufferLike, ?options:CheckPrimeOptions):Bool;

	/**
		Decrypts `buffer` with `private_key`.

		`private_key` can be an object or a string.
		If `private_key` is a string, it is treated as the key with no passphrase
		and will use `RSA_PKCS1_OAEP_PADDING`.
	**/
	@:overload(function(private_key:CryptoKeyOptions, buffer:Buffer):Buffer {})
	static function privateDecrypt(private_key:String, buffer:Buffer):Buffer;

	/**
		Encrypts `buffer` with `private_key`.

		`private_key` can be an object or a string.
		If `private_key` is a string, it is treated as the key with no passphrase
		and will use `RSA_PKCS1_PADDING`.
	**/
	@:overload(function(private_key:CryptoKeyOptions, buffer:Buffer):Buffer {})
	static function privateEncrypt(private_key:String, buffer:Buffer):Buffer;

	/**
		Decrypts `buffer` with `public_key`.

		`public_key` can be an object or a string.
		If `public_key` is a string, it is treated as the key with no passphrase
		and will use `RSA_PKCS1_PADDING`.

		Because RSA public keys can be derived from private keys,
		a private key may be passed instead of a public key.
	**/
	@:overload(function(public_key:CryptoKeyOptions, buffer:Buffer):Buffer {})
	static function publicDecrypt(public_key:String, buffer:Buffer):Buffer;

	/**
		Encrypts `buffer` with `public_key`.

		`public_key` can be an object or a string.
		If `public_key` is a string, it is treated as the key with no passphrase
		and will use `RSA_PKCS1_OAEP_PADDING`.

		Because RSA public keys can be derived from private keys,
		a private key may be passed instead of a public key.
	**/
	@:overload(function(public_key:CryptoKeyOptions, buffer:Buffer):Buffer {})
	static function publicEncrypt(public_key:String, buffer:Buffer):Buffer;

	/**
		Asynchronously generates a new random secret key of the given `length`.
		`type` is currently `'hmac'` or `'aes'`.
	**/
	static function generateKey(type:String, options:GenerateKeyOptions, callback:Error->KeyObject->Void):Void;

	/**
		Synchronously generates a new random secret key of the given `length`.
		`type` is currently `'hmac'` or `'aes'`.
	**/
	static function generateKeySync(type:String, options:GenerateKeyOptions):KeyObject;

	/**
		Generates a new asymmetric key pair of the given `type`.

		// TODO(section-4): finer-grained overloads per key type / encoding (RSA, EC, Ed25519, …)
	**/
	@:overload(function(type:String, options:Any, callback:Error->EitherType<String, KeyObject>->EitherType<String, KeyObject>->Void):Void {})
	@:overload(function(type:String, callback:Error->KeyObject->KeyObject->Void):Void {})
	static function generateKeyPair(type:String, options:Any, callback:Error->KeyObject->KeyObject->Void):Void;

	/**
		Synchronously generates a new asymmetric key pair of the given `type`.

		// TODO(section-4): finer-grained return encodings per key type
	**/
	@:overload(function(type:String):KeyPairKeyObjectResult {})
	static function generateKeyPairSync(type:String, ?options:Any):EitherType<KeyPairKeyObjectResult, KeyPairEncodedResult>;

	/**
		Generates a pseudorandom prime of `size` bits.
	**/
	@:overload(function(size:Int, options:GeneratePrimeOptions, callback:Error->EitherType<ArrayBuffer, Any>->Void):Void {})
	static function generatePrime(size:Int, callback:Error->ArrayBuffer->Void):Void;

	/**
		Generates a pseudorandom prime of `size` bits (synchronous).
	**/
	static function generatePrimeSync(size:Int, ?options:GeneratePrimeOptions):EitherType<ArrayBuffer, Any>;

	/**
		One-shot hashing. Returns a digest for `data` using `algorithm`.
	**/
	@:overload(function(algorithm:String, data:EitherType<String, EitherType<Buffer, ArrayBufferView>>, options:HashOptions):EitherType<String, Buffer> {})
	static function hash(algorithm:String, data:EitherType<String, EitherType<Buffer, ArrayBufferView>>, ?encoding:String):EitherType<String, Buffer>;

	/**
		Calculates and returns the signature for `data` using the given private key and algorithm.
	**/
	@:overload(function(algorithm:Null<String>, data:EitherType<Buffer, ArrayBufferView>, key:EitherType<String, EitherType<Buffer, KeyObject>>,
		callback:Error->Buffer->Void):Void {})
	static function sign(algorithm:Null<String>, data:EitherType<Buffer, ArrayBufferView>,
		key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>):Buffer;

	/**
		Verifies the given signature for `data` using the given key and algorithm.
	**/
	@:overload(function(algorithm:Null<String>, data:EitherType<Buffer, ArrayBufferView>,
		key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>, signature:EitherType<Buffer, ArrayBufferView>,
		callback:Error->Bool->Void):Void {})
	static function verify(algorithm:Null<String>, data:EitherType<Buffer, ArrayBufferView>,
		key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>,
		signature:EitherType<Buffer, ArrayBufferView>):Bool;

	/**
		Computes the Diffie-Hellman shared secret based on a `privateKey` and a `publicKey`.
	**/
	@:overload(function(options:DiffieHellmanOptions, callback:Error->Buffer->Void):Void {})
	static function diffieHellman(options:DiffieHellmanOptions):Buffer;

	/**
		A Web Crypto-compatible implementation of `getRandomValues`.
	**/
	static function getRandomValues<T:ArrayBufferView>(typedArray:T):T;

	/**
		Returns information about the secure heap usage used by OpenSSL.
	**/
	static function secureHeapUsed():SecureHeapUsage;

	/**
		Key encapsulation (KEM) using a public key.
	**/
	@:overload(function(key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>,
		callback:Error->EncapsulateResult->Void):Void {})
	static function encapsulate(key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>):EncapsulateResult;

	/**
		Key decapsulation using a private key.
	**/
	@:overload(function(key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>,
		ciphertext:EitherType<ArrayBuffer, ArrayBufferView>, callback:Error->Buffer->Void):Void {})
	static function decapsulate(key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>,
		ciphertext:EitherType<ArrayBuffer, ArrayBufferView>):Buffer;

	/**
		Provides an asynchronous Argon2 implementation.
	**/
	static function argon2(algorithm:Argon2Algorithm, parameters:Argon2Parameters, callback:Error->Buffer->Void):Void;

	/**
		Provides a synchronous Argon2 implementation.
	**/
	static function argon2Sync(algorithm:Argon2Algorithm, parameters:Argon2Parameters):Buffer;
}

/**
	An options type for `privateEncrypt`, `privateDecrypt`, `publicEncrypt`, `publicDecrypt` methods of `Crypto`.
**/
typedef CryptoKeyOptions = {
	/**
		PEM encoded public key
	**/
	var key:String;

	/**
		Passphrase for the private key
	**/
	@:optional var passphrase:String;

	/**
		Padding value, one of the following:
		* `Constants.RSA_NO_PADDING`
		* `Constants.RSA_PKCS1_PADDING`
		* `Constants.RSA_PKCS1_OAEP_PADDING`
	**/
	@:optional var padding:Int;
}

/**
	Binary input accepted by several crypto helpers (`ArrayBuffer`, `Buffer`, or `ArrayBufferView`).
**/
typedef CryptoArrayBufferLike = EitherType<ArrayBuffer, EitherType<Buffer, ArrayBufferView>>;

/**
	Options for `Crypto.scrypt` and `Crypto.scryptSync`.
**/
typedef ScryptOptions = {
	/**
		CPU/memory cost parameter. Must be a power of two greater than one. Default: `16384`.
		Only one of `cost` or `N` may be specified.
	**/
	@:optional var cost:Int;

	/**
		Block size parameter. Default: `8`.
		Only one of `blockSize` or `r` may be specified.
	**/
	@:optional var blockSize:Int;

	/**
		Parallelization parameter. Default: `1`.
		Only one of `parallelization` or `p` may be specified.
	**/
	@:optional var parallelization:Int;

	/**
		Alias for `cost`. Only one of `cost` or `N` may be specified.
	**/
	@:optional var N:Int;

	/**
		Alias for `blockSize`. Only one of `blockSize` or `r` may be specified.
	**/
	@:optional var r:Int;

	/**
		Alias for `parallelization`. Only one of `parallelization` or `p` may be specified.
	**/
	@:optional var p:Int;

	/**
		Memory upper bound. It is an error when (approximately) `128 * N * r > maxmem`.
		Default: `32 * 1024 * 1024`.
	**/
	@:optional var maxmem:Int;
}

/**
	Options for `Crypto.randomUUID`.
**/
typedef RandomUUIDOptions = {
	/**
		By default, to improve performance, Node.js generates and caches enough random data
		to generate up to 128 random UUIDs. To generate a UUID without using the cache,
		set `disableEntropyCache` to `true`. Default: `false`.
	**/
	@:optional var disableEntropyCache:Bool;
}

/**
	Options for `Crypto.checkPrime` and `Crypto.checkPrimeSync`.
**/
typedef CheckPrimeOptions = {
	/**
		The number of Miller-Rabin probabilistic primality iterations to perform.
		When the value is `0`, a number of checks is used that yields a false positive rate
		of at most 2^-64 for random input. Default: `0`.
	**/
	@:optional var checks:Int;
}

/**
	Options for `Crypto.getCipherInfo`.
**/
typedef CipherInfoOptions = {
	/**
		A test key length.
	**/
	@:optional var keyLength:Int;

	/**
		A test IV length.
	**/
	@:optional var ivLength:Int;
}

/**
	Information about a cipher returned by `Crypto.getCipherInfo`.
**/
typedef CipherInfo = {
	/**
		The name of the cipher.
	**/
	var name:String;

	/**
		The nid of the cipher.
	**/
	var nid:Int;

	/**
		The block size of the cipher in bytes.
		This property is omitted when `mode` is `'stream'`.
	**/
	@:optional var blockSize:Int;

	/**
		The expected or default initialization vector length in bytes.
		This property is omitted if the cipher does not use an initialization vector.
	**/
	@:optional var ivLength:Int;

	/**
		The expected or default key length in bytes.
	**/
	@:optional var keyLength:Int;

	/**
		The cipher mode. One of `'cbc'`, `'ccm'`, `'cfb'`, `'ctr'`, `'ecb'`, `'gcm'`,
		`'ocb'`, `'ofb'`, `'stream'`, `'wrap'`, `'xts'`.
	**/
	@:optional var mode:String;
}

/**
	Input object accepted by several crypto key helpers.
**/
typedef CryptoKeyInput = {
	var key:EitherType<String, EitherType<Buffer, ArrayBufferView>>;
	@:optional var format:String;
	@:optional var type:String;
	@:optional var passphrase:EitherType<String, Buffer>;
	@:optional var encoding:String;
}

/**
	Options for `Crypto.generateKey` / `generateKeySync`.
**/
typedef GenerateKeyOptions = {
	var length:Int;
}

/**
	Result when `generateKeyPairSync` returns KeyObject instances.
**/
typedef KeyPairKeyObjectResult = {
	var publicKey:KeyObject;
	var privateKey:KeyObject;
}

/**
	Result when `generateKeyPairSync` returns encoded keys.
**/
typedef KeyPairEncodedResult = {
	var publicKey:EitherType<String, Buffer>;
	var privateKey:EitherType<String, Buffer>;
}

/**
	Options for `Crypto.generatePrime` / `generatePrimeSync`.
**/
typedef GeneratePrimeOptions = {
	@:optional var safe:Bool;
	@:optional var bigint:Bool;
	@:optional var add:EitherType<ArrayBuffer, ArrayBufferView>;
	@:optional var rem:EitherType<ArrayBuffer, ArrayBufferView>;
}

/**
	Options for one-shot `Crypto.hash`.
**/
typedef HashOptions = {
	@:optional var outputEncoding:String;
	@:optional var outputLength:Int;
}

/**
	Options for `Crypto.diffieHellman`.
**/
typedef DiffieHellmanOptions = {
	var privateKey:KeyObject;
	var publicKey:KeyObject;
}

/**
	Result of `Crypto.secureHeapUsed`.
**/
typedef SecureHeapUsage = {
	var total:Float;
	var min:Float;
	var used:Float;
	var utilization:Float;
}

/**
	Result of `Crypto.encapsulate`.
**/
typedef EncapsulateResult = {
	var sharedKey:Buffer;
	var ciphertext:Buffer;
}

/**
	Argon2 algorithm identifiers.
**/
enum abstract Argon2Algorithm(String) from String to String {
	var Argon2d = "argon2d";
	var Argon2i = "argon2i";
	var Argon2id = "argon2id";
}

/**
	Parameters for `Crypto.argon2` / `argon2Sync`.
**/
typedef Argon2Parameters = {
	var message:EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>;
	var nonce:EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>;
	var parallelism:Int;
	var tagLength:Int;
	var memory:Int;
	var passes:Int;
	@:optional var secret:EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>;
	@:optional var associatedData:EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>;
}
