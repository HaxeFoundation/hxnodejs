/*
 * Copyright (C)2014-2026 Haxe Foundation
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
import js.node.tls.SecureContext;

/**
	Enumerations of crypto algorithms to be used.
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
	The `node:crypto` module provides cryptographic functionality that includes
	a set of wrappers for OpenSSL's hash, HMAC, cipher, decipher, sign, and verify functions.

	@see https://nodejs.org/docs/latest-v24.x/api/crypto.html
**/
@:jsRequire("crypto")
extern class Crypto {
	/**
		Load and set an OpenSSL engine for some/all OpenSSL functions (selected by `flags`).

		`engine` could be either an id or a path to the engine's shared library.

		`flags` is optional and has `Constants.ENGINE_METHOD_ALL` value by default.
		It could take one of or a mix of flags prefixed with `ENGINE_METHOD_` defined in `Constants`.
	**/
	static function setEngine(engine:String, ?flags:Int):Void;

	/**
		Legacy default encoding for crypto helpers that accept strings or buffers.

		Kept for compatibility with older typings; modern Node.js always prefers buffers.
	**/
	@:deprecated("Use explicitly set encoding on crypto streams instead")
	static var DEFAULT_ENCODING:String;

	/**
		Property for checking and controlling whether a FIPS compliant crypto provider is currently in use.
		Setting to true requires a FIPS build of Node.js.

		Deprecated since Node.js v10.0.0. Use `getFips` / `setFips` instead.
	**/
	@:deprecated("Use crypto.setFips() / getFips() instead")
	static var fips:Bool;

	/**
		OpenSSL crypto constants (padding modes, DH check codes, engine methods, etc.).
	**/
	static final constants:DynamicAccess<Int>;

	/**
		A convenient alias for `Crypto.webcrypto.subtle`.
	**/
	static final subtle:SubtleCrypto;

	/**
		Node.js Web Crypto API implementation (`crypto.webcrypto`).

		Typed as the Haxe std `js.html.Crypto` surface. Node-specific Web Crypto
		extensions beyond that DOM typedef are not duplicated here — no separate
		`js.node.webcrypto` package.

		// TODO(section-4): audit Node-only Web Crypto additions vs `js.html.Crypto`
	**/
	static final webcrypto:js.html.Crypto;

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
		Creates and returns a `Hash` object that can be used to generate hash digests
		using the given `algorithm`. `options` is an optional stream configuration;
		for XOF hash functions such as `'shake256'`, `outputLength` may be used.
	**/
	static function createHash(algorithm:CryptoAlgorithm, ?options:HashCreateOptions):Hash;

	/**
		Creates and returns an `Hmac` object that uses the given `algorithm` and `key`.
		`key` may be a `KeyObject` of type `secret`.
	**/
	static function createHmac(algorithm:CryptoAlgorithm, key:EitherType<String, EitherType<Buffer, KeyObject>>,
		?options:js.node.stream.Transform.TransformNewOptions):Hmac;

	/**
		Creates and returns a `Cipher` object with the given `algorithm` and `password`.

		Removed from Node.js; use `createCipheriv` instead.
	**/
	@:deprecated("Removed from Node.js; use createCipheriv instead")
	static function createCipher(algorithm:String, password:EitherType<String, Buffer>):Cipher;

	/**
		Creates and returns a `Cipheriv` object with the given `algorithm`, `key` and initialization vector (`iv`).

		`key` may be a `KeyObject` of type `secret`. `iv` may be `null` for ciphers that do not need an IV.
		`options` controls stream behavior; `authTagLength` is required for CCM/OCB modes.
	**/
	@:overload(function(algorithm:String, key:EitherType<EitherType<String, Buffer>, KeyObject>, iv:Null<EitherType<String, Buffer>>,
		?options:CipherivOptions):Cipheriv {})
	@:overload(function(algorithm:String, key:EitherType<EitherType<String, Buffer>, KeyObject>, iv:Null<EitherType<String, Buffer>>):Cipheriv {})
	static function createCipheriv(algorithm:String, key:EitherType<String, Buffer>, iv:EitherType<String, Buffer>,
		?options:CipherivOptions):Cipheriv;

	/**
		Creates and returns a `Decipher` object with the given `algorithm` and `password`.

		Removed from Node.js; use `createDecipheriv` instead.
	**/
	@:deprecated("Removed from Node.js; use createDecipheriv instead")
	static function createDecipher(algorithm:String, password:EitherType<String, Buffer>):Decipher;

	/**
		Creates and returns a `Decipheriv` object with the given `algorithm`, `key` and initialization vector (`iv`).

		`key` may be a `KeyObject` of type `secret`. `iv` may be `null` for ciphers that do not need an IV.
		`options` controls stream behavior; `authTagLength` is required for CCM/OCB modes.
	**/
	@:overload(function(algorithm:String, key:EitherType<EitherType<String, Buffer>, KeyObject>, iv:Null<EitherType<String, Buffer>>,
		?options:CipherivOptions):Decipheriv {})
	@:overload(function(algorithm:String, key:EitherType<EitherType<String, Buffer>, KeyObject>, iv:Null<EitherType<String, Buffer>>):Decipheriv {})
	static function createDecipheriv(algorithm:String, key:EitherType<String, Buffer>, iv:EitherType<String, Buffer>,
		?options:CipherivOptions):Decipheriv;

	/**
		Creates and returns a `Sign` object that uses the given `algorithm`.
		Example: `'RSA-SHA256'`.
	**/
	static function createSign(algorithm:String, ?options:js.node.stream.Writable.WritableNewOptions):Sign;

	/**
		Creates and returns a `Verify` object that uses the given `algorithm`.
	**/
	static function createVerify(algorithm:String, ?options:js.node.stream.Writable.WritableNewOptions):Verify;

	/**
		Creates a `DiffieHellman` key exchange object.

		Overloads accept a prime length (generator defaults to `2`), a prime `Buffer`,
		or a prime string with encoding (and optional generator).
	**/
	@:overload(function(prime_length:Int, ?generator:Int):DiffieHellman {})
	@:overload(function(prime:Buffer, ?generator:EitherType<Int, Buffer>):DiffieHellman {})
	@:overload(function(prime:String, primeEncoding:String, ?generator:EitherType<Int, EitherType<String, Buffer>>,
		?generatorEncoding:String):DiffieHellman {})
	static function createDiffieHellman(prime:String, encoding:String):DiffieHellman;

	/**
		Creates a predefined Diffie-Hellman key exchange object for a well-known group.
		Keys cannot be changed after creation (`setPublicKey` / `setPrivateKey` are unavailable).

		Groups `'modp1'`, `'modp2'`, and `'modp5'` are still supported but deprecated.
	**/
	static function getDiffieHellman(group_name:DiffieHellmanGroupName):DiffieHellmanGroup;

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
		Provides an asynchronous Password-Based Key Derivation Function 2 (PBKDF2) implementation.
		Applies a cryptographic HMAC digest chosen by `digest` to derive a key of the requested byte length
		from `password`, `salt` and `iterations`.
	**/
	static function pbkdf2(password:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, iterations:Int, keylen:Int, digest:String,
		callback:(err:Null<Error>, derivedKey:Buffer)->Void):Void;

	/**
		Provides a synchronous Password-Based Key Derivation Function 2 (PBKDF2) implementation.
	**/
	static function pbkdf2Sync(password:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, iterations:Int, keylen:Int,
		digest:String):Buffer;

	/**
		Provides an asynchronous scrypt implementation.
		Scrypt is a password-based key derivation function that is designed to be expensive
		computationally and memory-wise in order to make brute-force attacks unrewarding.
	**/
	@:overload(function(password:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, keylen:Int, options:ScryptOptions,
		callback:(err:Null<Error>, buffer:Buffer)->Void):Void {})
	static function scrypt(password:EitherType<String, Buffer>, salt:EitherType<String, Buffer>, keylen:Int, callback:(err:Null<Error>, buffer:Buffer)->Void):Void;

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
		callback:(err:Null<Error>, derivedKey:ArrayBuffer)->Void):Void;

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
	@:overload(function(size:Int, callback:(err:Null<Error>, buffer:Buffer)->Void):Void {})
	static function randomBytes(size:Int):Buffer;

	/**
		This function is similar to `randomBytes` but requires the first argument to be a `Buffer` or `TypedArray`
		that will be filled. It also requires that a callback is passed in.

		The supplied callback is invoked with two arguments: `err` and `buf`.
		The `buf` argument is a reference to the `buffer` filled with random data.
	**/
	@:overload(function<T>(buffer:T, offset:Int, callback:(err:Null<Error>, buf:T)->Void):Void {})
	@:overload(function<T>(buffer:T, offset:Int, size:Int, callback:(err:Null<Error>, buf:T)->Void):Void {})
	static function randomFill<T>(buffer:T, callback:(err:Null<Error>, buf:T)->Void):Void;

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
	@:overload(function(max:Int, callback:(err:Null<Error>, n:Int)->Void):Void {})
	@:overload(function(min:Int, max:Int):Int {})
	@:overload(function(min:Int, max:Int, callback:(err:Null<Error>, n:Int)->Void):Void {})
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
	@:overload(function(candidate:CryptoArrayBufferLike, options:CheckPrimeOptions, callback:(err:Null<Error>, result:Bool)->Void):Void {})
	static function checkPrime(candidate:CryptoArrayBufferLike, callback:(err:Null<Error>, result:Bool)->Void):Void;

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
	static function generateKey(type:String, options:GenerateKeyOptions, callback:(err:Null<Error>, key:KeyObject)->Void):Void;

	/**
		Synchronously generates a new random secret key of the given `length`.
		`type` is currently `'hmac'` or `'aes'`.
	**/
	static function generateKeySync(type:String, options:GenerateKeyOptions):KeyObject;

	/**
		Generates a new asymmetric key pair of the given `type`.

		// TODO(section-4): finer-grained overloads per key type / encoding (RSA, EC, Ed25519, …)
	**/
	@:overload(function(type:String, options:Any, callback:(err:Null<Error>, publicKey:EitherType<String, KeyObject>, privateKey:EitherType<String, KeyObject>)->Void):Void {})
	@:overload(function(type:String, callback:(err:Null<Error>, publicKey:KeyObject, privateKey:KeyObject)->Void):Void {})
	static function generateKeyPair(type:String, options:Any, callback:(err:Null<Error>, publicKey:KeyObject, privateKey:KeyObject)->Void):Void;

	/**
		Synchronously generates a new asymmetric key pair of the given `type`.

		// TODO(section-4): finer-grained return encodings per key type
	**/
	@:overload(function(type:String):KeyPairKeyObjectResult {})
	static function generateKeyPairSync(type:String, ?options:Any):EitherType<KeyPairKeyObjectResult, KeyPairEncodedResult>;

	/**
		Generates a pseudorandom prime of `size` bits.
	**/
	@:overload(function(size:Int, options:GeneratePrimeOptions, callback:(err:Null<Error>, prime:EitherType<ArrayBuffer, Any>)->Void):Void {})
	static function generatePrime(size:Int, callback:(err:Null<Error>, prime:ArrayBuffer)->Void):Void;

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
		callback:(err:Null<Error>, buffer:Buffer)->Void):Void {})
	static function sign(algorithm:Null<String>, data:EitherType<Buffer, ArrayBufferView>,
		key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>):Buffer;

	/**
		Verifies the given signature for `data` using the given key and algorithm.
	**/
	@:overload(function(algorithm:Null<String>, data:EitherType<Buffer, ArrayBufferView>,
		key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>, signature:EitherType<Buffer, ArrayBufferView>,
		callback:(err:Null<Error>, result:Bool)->Void):Void {})
	static function verify(algorithm:Null<String>, data:EitherType<Buffer, ArrayBufferView>,
		key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>,
		signature:EitherType<Buffer, ArrayBufferView>):Bool;

	/**
		Computes the Diffie-Hellman shared secret based on a `privateKey` and a `publicKey`.
	**/
	@:overload(function(options:DiffieHellmanOptions, callback:(err:Null<Error>, buffer:Buffer)->Void):Void {})
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
		callback:(err:Null<Error>, result:EncapsulateResult)->Void):Void {})
	static function encapsulate(key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>):EncapsulateResult;

	/**
		Key decapsulation using a private key.
	**/
	@:overload(function(key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>,
		ciphertext:EitherType<ArrayBuffer, ArrayBufferView>, callback:(err:Null<Error>, buffer:Buffer)->Void):Void {})
	static function decapsulate(key:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>,
		ciphertext:EitherType<ArrayBuffer, ArrayBufferView>):Buffer;

	/**
		Provides an asynchronous Argon2 implementation.
	**/
	static function argon2(algorithm:Argon2Algorithm, parameters:Argon2Parameters, callback:(err:Null<Error>, buffer:Buffer)->Void):Void;

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
	final key:String;

	/**
		Passphrase for the private key
	**/
	@:optional final passphrase:String;

	/**
		Padding value, one of the following:
		* `Constants.RSA_NO_PADDING`
		* `Constants.RSA_PKCS1_PADDING`
		* `Constants.RSA_PKCS1_OAEP_PADDING`
	**/
	@:optional final padding:Int;
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
	@:optional final cost:Int;

	/**
		Block size parameter. Default: `8`.
		Only one of `blockSize` or `r` may be specified.
	**/
	@:optional final blockSize:Int;

	/**
		Parallelization parameter. Default: `1`.
		Only one of `parallelization` or `p` may be specified.
	**/
	@:optional final parallelization:Int;

	/**
		Alias for `cost`. Only one of `cost` or `N` may be specified.
	**/
	@:optional final N:Int;

	/**
		Alias for `blockSize`. Only one of `blockSize` or `r` may be specified.
	**/
	@:optional final r:Int;

	/**
		Alias for `parallelization`. Only one of `parallelization` or `p` may be specified.
	**/
	@:optional final p:Int;

	/**
		Memory upper bound. It is an error when (approximately) `128 * N * r > maxmem`.
		Default: `32 * 1024 * 1024`.
	**/
	@:optional final maxmem:Int;
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
	@:optional final disableEntropyCache:Bool;
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
	@:optional final checks:Int;
}

/**
	Options for `Crypto.getCipherInfo`.
**/
typedef CipherInfoOptions = {
	/**
		A test key length.
	**/
	@:optional final keyLength:Int;

	/**
		A test IV length.
	**/
	@:optional final ivLength:Int;
}

/**
	Information about a cipher returned by `Crypto.getCipherInfo`.
**/
typedef CipherInfo = {
	/**
		The name of the cipher.
	**/
	final name:String;

	/**
		The nid of the cipher.
	**/
	final nid:Int;

	/**
		The block size of the cipher in bytes.
		This property is omitted when `mode` is `'stream'`.
	**/
	@:optional final blockSize:Int;

	/**
		The expected or default initialization vector length in bytes.
		This property is omitted if the cipher does not use an initialization vector.
	**/
	@:optional final ivLength:Int;

	/**
		The expected or default key length in bytes.
	**/
	@:optional final keyLength:Int;

	/**
		The cipher mode. One of `'cbc'`, `'ccm'`, `'cfb'`, `'ctr'`, `'ecb'`, `'gcm'`,
		`'ocb'`, `'ofb'`, `'stream'`, `'wrap'`, `'xts'`.
	**/
	@:optional final mode:String;
}

/**
	Input object accepted by several crypto key helpers.
**/
typedef CryptoKeyInput = {
	final key:EitherType<String, EitherType<Buffer, ArrayBufferView>>;
	@:optional final format:String;
	@:optional final type:String;
	@:optional final passphrase:EitherType<String, Buffer>;
	@:optional final encoding:String;
}

/**
	Options for `Crypto.generateKey` / `generateKeySync`.
**/
typedef GenerateKeyOptions = {
	final length:Int;
}

/**
	Result when `generateKeyPairSync` returns KeyObject instances.
**/
typedef KeyPairKeyObjectResult = {
	final publicKey:KeyObject;
	final privateKey:KeyObject;
}

/**
	Result when `generateKeyPairSync` returns encoded keys.
**/
typedef KeyPairEncodedResult = {
	final publicKey:EitherType<String, Buffer>;
	final privateKey:EitherType<String, Buffer>;
}

/**
	Options for `Crypto.generatePrime` / `generatePrimeSync`.
**/
typedef GeneratePrimeOptions = {
	@:optional final safe:Bool;
	@:optional final bigint:Bool;
	@:optional final add:EitherType<ArrayBuffer, ArrayBufferView>;
	@:optional final rem:EitherType<ArrayBuffer, ArrayBufferView>;
}

/**
	Options for one-shot `Crypto.hash`.
**/
typedef HashOptions = {
	@:optional final outputEncoding:String;
	@:optional final outputLength:Int;
}

/**
	Options for `Crypto.createHash` (stream options plus optional XOF `outputLength`).
**/
typedef HashCreateOptions = {
	> js.node.stream.Transform.TransformNewOptions,
	@:optional final outputLength:Int;
}

/**
	Options for `Crypto.createCipheriv` / `createDecipheriv` (stream options plus AEAD tag length).
**/
typedef CipherivOptions = {
	> js.node.stream.Transform.TransformNewOptions,
	/**
		Length of the authentication tag in bytes. Required for CCM/OCB modes.
	**/
	@:optional final authTagLength:Int;
}

/**
	Options for `Crypto.diffieHellman`.
**/
typedef DiffieHellmanOptions = {
	final privateKey:KeyObject;
	final publicKey:KeyObject;
}

/**
	Result of `Crypto.secureHeapUsed`.
**/
typedef SecureHeapUsage = {
	final total:Float;
	final min:Float;
	final used:Float;
	final utilization:Float;
}

/**
	Result of `Crypto.encapsulate`.
**/
typedef EncapsulateResult = {
	final sharedKey:Buffer;
	final ciphertext:Buffer;
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
	final message:EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>;
	final nonce:EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>;
	final parallelism:Int;
	final tagLength:Int;
	final memory:Int;
	final passes:Int;
	@:optional final secret:EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>;
	@:optional final associatedData:EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>;
}
