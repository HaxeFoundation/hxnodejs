/*
 * Copyright (C)2014-2019 Haxe Foundation
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
	`Types` provides a number of type checks for different kinds of built-in objects.
	Unlike `Syntax.instanceof` or `Object.prototype.toString.call(value)`, these checks do not
	inspect properties of the object that are accessible from JavaScript (like their prototype),
	and usually have the overhead of calling into C++.

	The result generally does not make any guarantees about what kinds of properties or behavior
	a value exposes in JavaScript. They are primarily useful for addon developers who prefer to do
	type checking in JavaScript.
**/
@:jsRequire("util", "types")
extern class Types {
	/**
		Returns `true` if the value is a built-in ArrayBuffer or SharedArrayBuffer instance.
	**/
	static function isAnyArrayBuffer(value:Dynamic):Bool;

	/**
		Returns `true` if the value is an arguments object.
	**/
	static function isArgumentsObject(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in ArrayBuffer instance.
		
		This does not include SharedArrayBuffer instances. Usually, it is desirable to test for both.
	**/
	static function isArrayBuffer(value:Dynamic):Bool;

	/**
		Returns `true` if the value is an async function.
		
		Note that this only reports back what the JavaScript engine is seeing; in particular, the return value may not match
		the original source code if a transpilation tool was used.
	**/
	static function isAsyncFunction(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a BigInt64Array instance.
	**/
	static function isBigInt64Array(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a BigUint64Array instance.
	**/
	static function isBigUint64Array(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a boolean object,
		e.g. created by `new Boolean()`.
	**/
	static function isBooleanObject(value:Dynamic):Bool;

	/**
		Returns `true` if the value is any boxed primitive object,
		e.g. created by `new Boolean()`, `new String()` or `Object(Symbol())`.
	**/
	static function isBoxedPrimitive(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in DataView instance.
	**/
	static function isDataView(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Date instance.
	**/
	static function isDate(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a native External value.
	**/
	static function isExternal(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Float32Array instance.
	**/
	static function isFloat32Array(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Float64Array instance.
	**/
	static function isFloat64Array(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a generator function.
		
		Note that this only reports back what the JavaScript engine is seeing; in particular, 
		the return value may not match the original source code if a transpilation tool was used.
	**/
	static function isGeneratorFunction(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a generator object as returned from a built-in generator function.
		
		Note that this only reports back what the JavaScript engine is seeing; in particular,
		the return value may not match the original source code if a transpilation tool was used.
	**/
	static function isGeneratorObject(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Int8Array instance.
	**/
	static function isInt8Array(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Int16Array instance.
	**/
	static function isInt16Array(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Int32Array instance.
	**/
	static function isInt32Array(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Map instance.
	**/
	static function isMap(value:Dynamic):Bool;

	/**
		Returns `true` if the value is an iterator returned for a built-in Map instance.
	**/
	static function isMapIterator(value:Dynamic):Bool;

	/**
		Returns `true` if the value is an instance of a Module Namespace Object.
	**/
	static function isModuleNamespaceObject(value:Dynamic):Bool;

	/**
		Returns `true` if the value is an instance of a built-in Error type.
	**/
	static function isNativeError(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a number object, e.g. created by `new Number()`.
	**/
	static function isNumberObject(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Promise.
	**/
	static function isPromise(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a Proxy instance.
	**/
	static function isProxy(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a regular expression object.
	**/
	static function isRegExp(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Set instance.
	**/
	static function isSet(value:Dynamic):Bool;

	/**
		Returns `true` if the value is an iterator returned for a built-in Set instance.
	**/
	static function isSetIterator(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in SharedArrayBuffer instance.
		
		This does not include ArrayBuffer instances. Usually, it is desirable to test for both.
	**/
	static function isSharedArrayBuffer(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a string object, e.g. created by `new String()`.
	**/
	static function isStringObject(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a symbol object, created by calling `Object()` on a `Symbol` primitive.
	**/
	static function isSymbolObject(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in TypedArray instance.
	**/
	static function isTypedArray(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Uint8Array instance.
	**/
	static function isUint8Array(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Uint8ClampedArray instance.
	**/
	static function isUint8ClampedArray(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Uint16Array instance.
	**/
	static function isUint16Array(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in Uint32Array instance.
	**/
	static function isUint32Array(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in WeakMap instance.
	**/
	static function isWeakMap(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in WeakSet instance.
	**/
	static function isWeakSet(value:Dynamic):Bool;

	/**
		Returns `true` if the value is a built-in WebAssembly.Module instance.
	**/
	static function isWebAssemblyCompiledModule(value:Dynamic):Bool;
}