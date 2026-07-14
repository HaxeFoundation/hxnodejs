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
import js.lib.ArrayBuffer;
import js.lib.ArrayBufferView;
import js.node.Buffer;

/**
	SPKAC is a Certificate Signing Request mechanism originally implemented by Netscape
	and formerly specified as part of HTML5's `keygen` element.

	Prefer the static methods. The instance API is a deprecated legacy interface.

	@see https://nodejs.org/docs/latest-v24.x/api/crypto.html#class-certificate
**/
@:jsRequire("crypto", "Certificate")
extern class Certificate {
	/**
		Legacy constructor. Prefer static `Certificate` methods.
	**/
	@:deprecated("Use Certificate static methods instead")
	function new();

	/**
		Returns the challenge component of the `spkac` data structure.
	**/
	@:overload(function(spkac:EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>, ?encoding:String):Buffer {})
	static function exportChallenge(spkac:Buffer):Buffer;

	/**
		Returns the public key component of the `spkac` data structure.
	**/
	@:overload(function(spkac:EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>, ?encoding:String):Buffer {})
	static function exportPublicKey(spkac:Buffer):Buffer;

	/**
		Returns `true` if the given `spkac` data structure is valid.
	**/
	@:overload(function(spkac:EitherType<String, EitherType<ArrayBuffer, ArrayBufferView>>, ?encoding:String):Bool {})
	static function verifySpkac(spkac:Buffer):Bool;
}
