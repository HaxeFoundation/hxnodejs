/*
 * Copyright (C)2014-2020 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation documents (the "Software"),
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

/**
	Predefined Diffie-Hellman group object returned by
	`Crypto.getDiffieHellman` / `Crypto.createDiffieHellmanGroup`.

	Unlike `DiffieHellman`, keys cannot be set with `setPublicKey` / `setPrivateKey`.
**/
@:jsRequire("crypto", "DiffieHellmanGroup")
extern class DiffieHellmanGroup implements IDiffieHellman {
	@:overload(function():js.node.Buffer {})
	function generateKeys(encoding:String):String;

	@:overload(function(other_public_key:js.node.Buffer):js.node.Buffer {})
	@:overload(function(other_public_key:String, input_encoding:String):js.node.Buffer {})
	function computeSecret(other_public_key:String, input_encoding:String, output_encoding:String):String;

	@:overload(function():js.node.Buffer {})
	function getPrime(encoding:String):String;

	@:overload(function():js.node.Buffer {})
	function getGenerator(encoding:String):String;

	@:overload(function():js.node.Buffer {})
	function getPublicKey(encoding:String):String;

	@:overload(function():js.node.Buffer {})
	function getPrivateKey(encoding:String):String;
}
