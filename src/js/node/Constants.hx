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

/**
	Constants exported by Node.js core modules (legacy aggregate module).

	Prefer module-specific constants (e.g. `fs.constants`, `os.constants`, `crypto.constants`)
	over `require('constants')`. This extern only mirrors a subset historically used by
	crypto engine/padding callers.

	@see https://nodejs.org/api/crypto.html#crypto-constants
**/
@:jsRequire("constants")
extern class Constants {
	static final ENGINE_METHOD_RSA:Int;
	static final ENGINE_METHOD_DSA:Int;
	static final ENGINE_METHOD_DH:Int;
	static final ENGINE_METHOD_RAND:Int;
	static final ENGINE_METHOD_ECDH:Int;
	static final ENGINE_METHOD_ECDSA:Int;
	static final ENGINE_METHOD_CIPHERS:Int;
	static final ENGINE_METHOD_DIGESTS:Int;
	static final ENGINE_METHOD_STORE:Int;
	static final ENGINE_METHOD_PKEY_METH:Int;
	static final ENGINE_METHOD_PKEY_ASN1_METH:Int;
	static final ENGINE_METHOD_ALL:Int;
	static final ENGINE_METHOD_NONE:Int;

	static final RSA_NO_PADDING:Int;
	static final RSA_PKCS1_PADDING:Int;
	static final RSA_PKCS1_OAEP_PADDING:Int;
}
