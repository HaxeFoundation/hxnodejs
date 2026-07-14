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
import js.node.Buffer;
import js.node.Crypto.CryptoKeyInput;
import js.node.stream.Writable;

/**
	Class for verifying signatures.
	Returned by `Crypto.createVerify`.

	Verify objects are writable streams. The written data is used to validate against the supplied signature.
	Once all of the data has been written, the `verify` method will return true if the supplied signature is valid.

	The legacy `update` method is also supported.

	@see https://nodejs.org/docs/latest-v24.x/api/crypto.html#class-verify
**/
extern class Verify extends Writable<Verify> {
	/**
		Updates the verifier object with data. This can be called many times with new data as it is streamed.
	**/
	@:overload(function(data:Buffer):Verify {})
	function update(data:String, ?encoding:String):Verify;

	/**
		Verifies the signed data by using the object and signature.

		`object` can be a PEM string, a `KeyObject`, or a key object descriptor
		(RSA/DSA public key or X.509 certificate).

		`signature` is the previously calculated signature for the data,
		in the `signature_format` which can be `'binary'`, `'hex'` or `'base64'`.
		If no encoding is specified, then a buffer is expected.

		Returns true or false depending on the validity of the signature for the data and public key.

		Note: verifier object can not be used after `verify` method has been called.
	**/
	@:overload(function(object:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>, signature:Buffer):Bool {})
	function verify(object:EitherType<String, EitherType<Buffer, EitherType<KeyObject, CryptoKeyInput>>>, signature:String,
		signature_format:String):Bool;
}
