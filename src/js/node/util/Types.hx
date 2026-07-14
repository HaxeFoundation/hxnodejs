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

package js.node.util;

/**
	`util.types` provides a number of type checks for different kinds of built-in objects.

	@see https://nodejs.org/api/util.html#utiltypes
**/
@:jsRequire("util", "types")
extern class Types {
	/**
		Returns `true` if the value is a built-in `ArrayBuffer` or `SharedArrayBuffer` instance.

		@see https://nodejs.org/api/util.html#utiltypesisanyarraybuffervalue
	**/
	static function isAnyArrayBuffer(value:Any):Bool;

	/**
		Returns `true` if the value is an `arguments` object.

		@see https://nodejs.org/api/util.html#utiltypesisargumentsobjectvalue
	**/
	static function isArgumentsObject(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `ArrayBuffer` instance.

		@see https://nodejs.org/api/util.html#utiltypesisarraybuffervalue
	**/
	static function isArrayBuffer(value:Any):Bool;

	/**
		Returns `true` if the value is an `ArrayBufferView` (TypedArray or DataView).

		@see https://nodejs.org/api/util.html#utiltypesisarraybufferviewvalue
	**/
	static function isArrayBufferView(value:Any):Bool;

	/**
		Returns `true` if the value is an async function.

		@see https://nodejs.org/api/util.html#utiltypesisasyncfunctionvalue
	**/
	static function isAsyncFunction(value:Any):Bool;

	/**
		Returns `true` if the value is a `BigInt64Array` instance.

		@see https://nodejs.org/api/util.html#utiltypesisbigint64arrayvalue
	**/
	static function isBigInt64Array(value:Any):Bool;

	/**
		Returns `true` if the value is a `BigUint64Array` instance.

		@see https://nodejs.org/api/util.html#utiltypesisbiguint64arrayvalue
	**/
	static function isBigUint64Array(value:Any):Bool;

	/**
		Returns `true` if the value is a boolean object, e.g. created by `new Boolean()`.

		@see https://nodejs.org/api/util.html#utiltypesisbooleanobjectvalue
	**/
	static function isBooleanObject(value:Any):Bool;

	/**
		Returns `true` if the value is any boxed primitive object, e.g. created by `new Boolean()`, `new String()` or
		`Object(Symbol())`.

		@see https://nodejs.org/api/util.html#utiltypesisboxedprimitivevalue
	**/
	static function isBoxedPrimitive(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `DataView` instance.

		@see https://nodejs.org/api/util.html#utiltypesisdataviewvalue
	**/
	static function isDataView(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Date` instance.

		@see https://nodejs.org/api/util.html#utiltypesisdatevalue
	**/
	static function isDate(value:Any):Bool;

	/**
		Returns `true` if the value is a native `External` value.

		@see https://nodejs.org/api/util.html#utiltypesisexternalvalue
	**/
	static function isExternal(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Float32Array` instance.

		@see https://nodejs.org/api/util.html#utiltypesisfloat32arrayvalue
	**/
	static function isFloat32Array(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Float64Array` instance.

		@see https://nodejs.org/api/util.html#utiltypesisfloat64arrayvalue
	**/
	static function isFloat64Array(value:Any):Bool;

	/**
		Returns `true` if the value is a generator function.

		@see https://nodejs.org/api/util.html#utiltypesisgeneratorfunctionvalue
	**/
	static function isGeneratorFunction(value:Any):Bool;

	/**
		Returns `true` if the value is a generator object as returned from a built-in generator function.

		@see https://nodejs.org/api/util.html#utiltypesisgeneratorobjectvalue
	**/
	static function isGeneratorObject(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Int8Array` instance.

		@see https://nodejs.org/api/util.html#utiltypesisint8arrayvalue
	**/
	static function isInt8Array(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Int16Array` instance.

		@see https://nodejs.org/api/util.html#utiltypesisint16arrayvalue
	**/
	static function isInt16Array(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Int32Array` instance.

		@see https://nodejs.org/api/util.html#utiltypesisint32arrayvalue
	**/
	static function isInt32Array(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Map` instance.

		@see https://nodejs.org/api/util.html#utiltypesismapvalue
	**/
	static function isMap(value:Any):Bool;

	/**
		Returns `true` if the value is an iterator returned for a built-in `Map` instance.

		@see https://nodejs.org/api/util.html#utiltypesismapiteratorvalue
	**/
	static function isMapIterator(value:Any):Bool;

	/**
		Returns `true` if the value is an instance of a Module Namespace Object.

		@see https://nodejs.org/api/util.html#utiltypesismodulenamespaceobjectvalue
	**/
	static function isModuleNamespaceObject(value:Any):Bool;

	/**
		Returns `true` if the value is an instance of a built-in `Error` type.

		@see https://nodejs.org/api/util.html#utiltypesisnativeerrorvalue
	**/
	static function isNativeError(value:Any):Bool;

	/**
		Returns `true` if the value is a number object, e.g. created by `new Number()`.

		@see https://nodejs.org/api/util.html#utiltypesisnumberobjectvalue
	**/
	static function isNumberObject(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Promise`.

		@see https://nodejs.org/api/util.html#utiltypesispromisevalue
	**/
	static function isPromise(value:Any):Bool;

	/**
		Returns `true` if the value is a `Proxy` instance.

		@see https://nodejs.org/api/util.html#utiltypesisproxyvalue
	**/
	static function isProxy(value:Any):Bool;

	/**
		Returns `true` if the value is a regular expression object.

		@see https://nodejs.org/api/util.html#utiltypesisregexpvalue
	**/
	static function isRegExp(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Set` instance.

		@see https://nodejs.org/api/util.html#utiltypesissetvalue
	**/
	static function isSet(value:Any):Bool;

	/**
		Returns `true` if the value is an iterator returned for a built-in `Set` instance.

		@see https://nodejs.org/api/util.html#utiltypesissetiteratorvalue
	**/
	static function isSetIterator(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `SharedArrayBuffer` instance.

		@see https://nodejs.org/api/util.html#utiltypesissharedarraybuffervalue
	**/
	static function isSharedArrayBuffer(value:Any):Bool;

	/**
		Returns `true` if the value is a string object, e.g. created by `new String()`.

		@see https://nodejs.org/api/util.html#utiltypesisstringobjectvalue
	**/
	static function isStringObject(value:Any):Bool;

	/**
		Returns `true` if the value is a symbol object, created by calling `Object()` on a `Symbol` primitive.

		@see https://nodejs.org/api/util.html#utiltypesissymbolobjectvalue
	**/
	static function isSymbolObject(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `TypedArray` instance.

		@see https://nodejs.org/api/util.html#utiltypesistypedarrayvalue
	**/
	static function isTypedArray(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Uint8Array` instance.

		@see https://nodejs.org/api/util.html#utiltypesisuint8arrayvalue
	**/
	static function isUint8Array(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Uint8ClampedArray` instance.

		@see https://nodejs.org/api/util.html#utiltypesisuint8clampedarrayvalue
	**/
	static function isUint8ClampedArray(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Uint16Array` instance.

		@see https://nodejs.org/api/util.html#utiltypesisuint16arrayvalue
	**/
	static function isUint16Array(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `Uint32Array` instance.

		@see https://nodejs.org/api/util.html#utiltypesisuint32arrayvalue
	**/
	static function isUint32Array(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `WeakMap` instance.

		@see https://nodejs.org/api/util.html#utiltypesisweakmapvalue
	**/
	static function isWeakMap(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `WeakSet` instance.

		@see https://nodejs.org/api/util.html#utiltypesisweaksetvalue
	**/
	static function isWeakSet(value:Any):Bool;

	/**
		Returns `true` if the value is a built-in `WebAssembly.Module` instance.

		Removed in Node.js (EOL). Use `value instanceof WebAssembly.Module` instead.

		@see https://nodejs.org/api/deprecations.html#dep0177-utiltypesiswebassemblycompiledmodule
	**/
	@:deprecated("Use value instanceof WebAssembly.Module instead")
	static function isWebAssemblyCompiledModule(value:Any):Bool;

	/**
		Returns `true` if the value is a `BigInt` object boxed wrapper (not a primitive BigInt).

		@see https://nodejs.org/api/util.html#utiltypesisbigintobjectvalue
	**/
	static function isBigIntObject(value:Any):Bool;

	/**
		Returns `true` if the value is a `Float16Array` instance.

		@see https://nodejs.org/api/util.html#utiltypesisfloat16arrayvalue
	**/
	static function isFloat16Array(value:Any):Bool;

	/**
		Returns `true` if the value is a `KeyObject` from the `crypto` module.

		@see https://nodejs.org/api/util.html#utiltypesiskeyobjectvalue
	**/
	static function isKeyObject(value:Any):Bool;

	/**
		Returns `true` if the value is a Web Crypto `CryptoKey` instance.

		@see https://nodejs.org/api/util.html#utiltypesiscryptokeyvalue
	**/
	static function isCryptoKey(value:Any):Bool;
}
