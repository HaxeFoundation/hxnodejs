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

package js.node.test;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import js.lib.Error;
import js.lib.Symbol;

/**
	Manages mocking functionality.

	Obtained from `Test.mock` or `TestContext.mock`.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mocktracker
**/
extern class MockTracker {
	/**
		Create a mock function.

		The returned function has a `mock` property of type `MockFunctionContext`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#mockfnoriginal-implementation-options
	**/
	@:overload(function(?original:Function, ?options:MockFunctionOptions):MockedFunction {})
	function fn(?original:Function, ?implementation:Function, ?options:MockFunctionOptions):MockedFunction;

	/**
		Syntax sugar for `method` with `options.getter` set to `true`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#mockgetterobject-methodname-implementation-options
	**/
	@:overload(function(object:{}, methodName:EitherType<String, Symbol>, ?options:MockMethodOptions):MockedFunction {})
	function getter(object:{}, methodName:EitherType<String, Symbol>, ?implementation:Function, ?options:MockMethodOptions):MockedFunction;

	/**
		Create a mock on an existing object method.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#mockmethodobject-methodname-implementation-options
	**/
	@:overload(function(object:{}, methodName:EitherType<String, Symbol>, ?options:MockMethodOptions):MockedFunction {})
	function method(object:{}, methodName:EitherType<String, Symbol>, ?implementation:Function, ?options:MockMethodOptions):MockedFunction;

	/**
		Mock exports of an ESM, CommonJS, JSON, or builtin module.

		Requires `--experimental-test-module-mocks`. Stability: 1.0.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#mockmodulespecifier-options
	**/
	function module(specifier:String, ?options:MockModuleOptions):MockModuleContext;

	/**
		Mock a property value on an object.

		Added in: v24.3.0

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#mockpropertyobject-propertyname-value
	**/
	function property(object:{}, propertyName:EitherType<String, Symbol>, ?value:Dynamic):MockedProperty;

	/**
		Restore default behavior of all mocks created by this tracker and
		disassociate them from the tracker.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#mockreset
	**/
	function reset():Void;

	/**
		Restore default behavior of all mocks without disassociating them.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#mockrestoreall
	**/
	function restoreAll():Void;

	/**
		Syntax sugar for `method` with `options.setter` set to `true`.

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#mocksetterobject-methodname-implementation-options
	**/
	@:overload(function(object:{}, methodName:EitherType<String, Symbol>, ?options:MockMethodOptions):MockedFunction {})
	function setter(object:{}, methodName:EitherType<String, Symbol>, ?implementation:Function, ?options:MockMethodOptions):MockedFunction;

	/**
		Mock timers APIs (`setTimeout`, `setInterval`, `setImmediate`, `Date`, …).

		@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mocktimers
	**/
	var timers(default, null):MockTimers;
}

/**
	Options for `MockTracker.fn`.
**/
typedef MockFunctionOptions = {
	/**
		How many times `implementation` is used before restoring `original`.
		Must be an integer greater than zero. Default: `Infinity`.
	**/
	@:optional var times:Int;
}

/**
	Options for `MockTracker.method` / `getter` / `setter`.
**/
typedef MockMethodOptions = {
	> MockFunctionOptions,

	/**
		Treat the member as a getter. Cannot be combined with `setter`. Default: `false`.
	**/
	@:optional var getter:Bool;

	/**
		Treat the member as a setter. Cannot be combined with `getter`. Default: `false`.
	**/
	@:optional var setter:Bool;
}

/**
	Options for `MockTracker.module`.
**/
typedef MockModuleOptions = {
	/**
		If `false`, each import/require gets a new mock. If `true`, the mock is cached. Default: `false`.
	**/
	@:optional var cache:Bool;

	/**
		Mocked exports object. Prefer this over deprecated `defaultExport` / `namedExports`.
	**/
	@:optional var exports:Dynamic;

	/**
		Deprecated. Prefer `exports.default`.
	**/
	@:deprecated("Prefer options.exports.default")
	@:optional var defaultExport:Dynamic;

	/**
		Deprecated. Prefer `options.exports`.
	**/
	@:deprecated("Prefer options.exports")
	@:optional var namedExports:Dynamic;
}

/**
	A mocked function returned by `fn` / `method` / `getter` / `setter`.
	Callable; inspect or reconfigure via `mock`.
**/
@:callable
abstract MockedFunction(Dynamic) from Dynamic to Dynamic {
	/**
		`MockFunctionContext` for inspecting and changing mock behavior.
	**/
	public var mock(get, never):MockFunctionContext;

	inline function get_mock():MockFunctionContext
		return this.mock;
}

/**
	A mocked property proxy returned by `MockTracker.property`.
**/
@:forward
abstract MockedProperty(Dynamic) from Dynamic to Dynamic {
	/**
		`MockPropertyContext` for inspecting and changing mock behavior.
	**/
	public var mock(get, never):MockPropertyContext;

	inline function get_mock():MockPropertyContext
		return this.mock;
}

/**
	Inspect or manipulate mocks created via `MockTracker` function APIs.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mockfunctioncontext
**/
extern class MockFunctionContext {
	/**
		Copy of the internal call-tracking array.
	**/
	var calls(default, null):Array<MockFunctionCall>;

	/**
		Number of times this mock has been invoked.
	**/
	function callCount():Int;

	/**
		Change the mock's implementation.
	**/
	function mockImplementation(implementation:Function):Void;

	/**
		Change the mock's implementation for a single invocation.
	**/
	function mockImplementationOnce(implementation:Function, ?onCall:Int):Void;

	/**
		Reset the call history of the mock function.
	**/
	function resetCalls():Void;

	/**
		Reset the mock implementation to its original behavior.
	**/
	function restore():Void;
}

/**
	One recorded invocation of a mocked function.
**/
typedef MockFunctionCall = {
	/**
		Arguments passed to the mock.
	**/
	var arguments:Array<Dynamic>;

	/**
		Thrown value, if any.
	**/
	@:optional var error:Dynamic;

	/**
		Return value of the mock.
	**/
	var result:Dynamic;

	/**
		Error whose stack identifies the callsite.
	**/
	var stack:Error;

	/**
		Constructed class when the mock was used as a constructor.
	**/
	@:optional var target:Function;

	/**
		`this` value for the invocation.
	**/
	@:native("this") var this_:Dynamic;
}

/**
	Manipulate module mocks created via `MockTracker.module`.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mockmodulecontext
**/
extern class MockModuleContext {
	/**
		Reset the mock module implementation.
	**/
	function restore():Void;
}

/**
	Inspect or manipulate property mocks created via `MockTracker.property`.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mockpropertycontext
**/
extern class MockPropertyContext {
	/**
		Copy of the internal access-tracking array.
	**/
	var accesses(default, null):Array<MockPropertyAccess>;

	/**
		Number of times the property was accessed (get or set).
	**/
	function accessCount():Int;

	/**
		Change the value returned by the mocked property getter.
	**/
	function mockImplementation(value:Dynamic):Void;

	/**
		Change the mocked value for a single access.
	**/
	function mockImplementationOnce(value:Dynamic, ?onAccess:Int):Void;

	/**
		Reset the access history of the mocked property.
	**/
	function resetAccesses():Void;

	/**
		Reset the mock property to its original behavior.
	**/
	function restore():Void;
}

/**
	One recorded get/set of a mocked property.
**/
typedef MockPropertyAccess = {
	/**
		Either `'get'` or `'set'`.
	**/
	var type:String;

	/**
		Value that was read or written.
	**/
	var value:Dynamic;

	/**
		Error whose stack identifies the callsite.
	**/
	var stack:Error;
}
