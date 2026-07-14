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

import js.node.Buffer;
import js.node.crypto.Cipher.CipherAADOptions;

/**
	Class for decrypting data.

	Returned by `Crypto.createDecipheriv` (and the removed legacy `Crypto.createDecipher`).

	Decipher objects are streams that are both readable and writable.
	The written enciphered data is used to produce the plain-text data on the readable side.

	The legacy `update` and `final` methods are also supported.

	@see https://nodejs.org/docs/latest-v24.x/api/crypto.html#class-decipheriv
**/
extern class Decipher extends js.node.stream.Transform<Decipher> {
	/**
		Updates the decipher with `data`, which is encoded in `'binary'`, `'base64'` or `'hex'`.
		If no encoding is provided, then a buffer is expected.

		The `output_encoding` specifies in what format to return the deciphered plaintext: `'binary'`, `'ascii'` or `'utf8'`.
		If no encoding is provided, then a buffer is returned.
	**/
	@:overload(function(data:Buffer):Buffer {})
	@:overload(function(data:String, input_encoding:String):Buffer {})
	function update(data:String, input_encoding:String, output_encoding:String):String;

	/**
		Returns any remaining plaintext which is deciphered,
		with `output_encoding` being one of: `'binary'`, `'ascii'` or `'utf8'`.
		If no encoding is provided, then a buffer is returned.

		Note: decipher object can not be used after `final` method has been called.
	**/
	@:native("final") @:overload(function():Buffer {})
	function finalContents(output_encoding:String):String;

	/**
		You can disable auto padding if the data has been encrypted without standard block padding
		to prevent `final` from checking and removing it.

		Can only work if the input data's length is a multiple of the cipher's block size.

		You must call this before streaming data to `update`.
	**/
	@:overload(function():Decipher {})
	function setAutoPadding(auto_padding:Bool):Decipher;

	/**
		For authenticated encryption modes (GCM, CCM, OCB, chacha20-poly1305),
		this method must be used to pass in the received authentication tag.
		If no tag is provided or if the ciphertext has been tampered with, `final` will throw.
	**/
	function setAuthTag(buffer:Buffer):Decipher;

	/**
		For authenticated encryption modes (GCM, CCM, OCB, chacha20-poly1305),
		sets the value used for the additional authenticated data (AAD) input parameter.

		Must be called before `update`. When using CCM, `options.plaintextLength` is required.
	**/
	@:overload(function(buffer:Buffer, ?options:CipherAADOptions):Decipher {})
	function setAAD(buffer:Buffer):Decipher;
}
