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

package js.node.crypto;

import haxe.extern.EitherType;
import js.html.CryptoKey;
import js.node.Buffer;

/**
	Node.js representation of a key for use by crypto APIs.
	Instances are created via `Crypto.create*Key` / `generateKey*` helpers.

	@see https://nodejs.org/docs/latest-v24.x/api/crypto.html#class-keyobject
**/
@:jsRequire("crypto", "KeyObject")
extern class KeyObject {
	/**
		Converts a Web Crypto `CryptoKey` to a Node.js `KeyObject`.
	**/
	static function from(key:CryptoKey):KeyObject;

	/**
		Depending on the type of this `KeyObject`, this property is either
		`'secret'`, `'public'`, or `'private'`.
	**/
	final type:KeyObjectType;

	/**
		For asymmetric keys, the type of the key (e.g. `'rsa'`, `'ec'`, `'ed25519'`).
		`undefined` for secret keys.
	**/
	@:optional final asymmetricKeyType:String;

	/**
		Details about an asymmetric key. `undefined` for secret keys.
	**/
	@:optional final asymmetricKeyDetails:AsymmetricKeyDetails;

	/**
		For secret keys, the size of the key in bytes. `undefined` for asymmetric keys.
	**/
	@:optional final symmetricKeySize:Int;

	/**
		Returns `true` if the keys have exactly the same type, value, and parameters.
	**/
	function equals(otherKeyObject:KeyObject):Bool;

	/**
		Exports the key material.
		Result type depends on `format` (`'pem'` → String, `'der'` → Buffer, `'jwk'` → object).
	**/
	function export(?options:KeyExportOptions):EitherType<String, EitherType<Buffer, Any>>;

	/**
		Converts this `KeyObject` instance to a Web Crypto `CryptoKey`.
	**/
	function toCryptoKey(algorithm:Any, extractable:Bool, keyUsages:Array<String>):CryptoKey;
}

/**
	Possible values for `KeyObject.type`.
**/
enum abstract KeyObjectType(String) from String to String {
	var Secret = "secret";
	var Public = "public";
	var Private = "private";
}

/**
	Details about an asymmetric key from `KeyObject.asymmetricKeyDetails`.
**/
typedef AsymmetricKeyDetails = {
	/** Key size in bits (RSA, DSA). **/
	@:optional final modulusLength:Int;
	/** Public exponent (RSA). Number or BigInt depending on key material. **/
	@:optional final publicExponent:Any;
	/** Name of the message digest (RSA-PSS). **/
	@:optional final hashAlgorithm:String;
	/** Name of the message digest used by MGF1 (RSA-PSS). **/
	@:optional final mgf1HashAlgorithm:String;
	/** Minimal salt length in bytes (RSA-PSS). **/
	@:optional final saltLength:Int;
	/** Size of `q` in bits (DSA). **/
	@:optional final divisorLength:Int;
	/** Name of the curve (EC). **/
	@:optional final namedCurve:String;
}

/**
	Options for `KeyObject.export`.
**/
typedef KeyExportOptions = {
	@:optional final type:String;
	@:optional final format:String;
	@:optional final cipher:String;
	@:optional final passphrase:EitherType<String, Buffer>;
}
