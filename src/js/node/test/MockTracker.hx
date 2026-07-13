/*
 * Copyright (C)2014-2020 Haxe Foundation
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
import haxe.extern.Rest;
#if haxe4
import js.lib.Error;
#else
import js.Error;
#end

/**
	A single recorded call to a mocked function.
**/
typedef MockFunctionCall = {
	/**
		Arguments passed to the mock function.
	**/
	var arguments:Array<Dynamic>;

	/**
		If the mocked function threw, this property contains the thrown value.
	**/
	@:optional var error:Dynamic;

	/**
		Value returned by the mocked function.
	**/
	@:optional var result:Dynamic;

	/**
		Error whose stack can be used to determine the callsite.
	**/
	var stack:Error;

	/**
		If the mocked function is a constructor, the class being constructed.
	**/
	@:optional var target:Dynamic;

	/**
		The mocked function's `this` value.
	**/
	@:native("this")
	var thisValue:Dynamic;
};

/**
	Options for `MockTracker.fn` / `MockTracker.method`.
**/
typedef MockFunctionOptions = {
	/**
		Number of times the mock uses `implementation` before restoring `original`.
		Default: `Infinity`.
	**/
	@:optional var times:Float;
};

/**
	Options for `MockTracker.method` when mocking getters/setters.
**/
typedef MockMethodOptions = {
	/**
		If `true`, `object[methodName]` is treated as a getter.
	**/
	@:optional var getter:Bool;

	/**
		If `true`, `object[methodName]` is treated as a setter.
	**/
	@:optional var setter:Bool;

	/**
		Number of times the mock uses `implementation` before restoring the original.
		Default: `Infinity`.
	**/
	@:optional var times:Float;
};

/**
	Options for `MockTracker.module`.
**/
typedef MockModuleOptions = {
	/**
		If `false`, each `require`/`import` generates a new mock module.
		If `true`, subsequent calls return the same mock. Default: `false`.
	**/
	@:optional var cache:Bool;

	/**
		Mocked exports. `default` is used as the mocked module's default export;
		other own enumerable properties are named exports.
	**/
	@:optional var exports:Dynamic;

	/**
		@deprecated Prefer `exports.default`.
	**/
	@:optional var defaultExport:Dynamic;

	/**
		@deprecated Prefer `exports`.
	**/
	@:optional var namedExports:Dynamic;
};

/**
	Mocked function returned by `MockTracker.fn` / `MockTracker.method`.
**/
extern class MockedFunction {
	@:selfCall
	function call(args:Rest<Dynamic>):Dynamic;

	/**
		Context used to inspect or manipulate the mock.
	**/
	var mock(default, never):MockFunctionContext;
}

/**
	Proxy returned by `MockTracker.property`.
**/
typedef MockedProperty = {
	/**
		Context used to inspect or manipulate the mocked property.
	**/
	var mock:MockPropertyContext;
};

/**
	The `MockFunctionContext` class is used to inspect or manipulate the behavior
	of mocks created via the `MockTracker` APIs.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mockfunctioncontext
**/
extern class MockFunctionContext {
	/**
		Copy of the internal array used to track calls to the mock.
	**/
	var calls(default, never):Array<MockFunctionCall>;

	/**
		Number of times this mock has been invoked.
	**/
	function callCount():Int;

	/**
		Change the behavior of an existing mock.
	**/
	function mockImplementation(implementation:Function):Void;

	/**
		Change the behavior of an existing mock for a single invocation.
	**/
	function mockImplementationOnce(implementation:Function, ?onCall:Int):Void;

	/**
		Reset the call history of the mock function.
	**/
	function resetCalls():Void;

	/**
		Reset the implementation of the mock function to its original behavior.
	**/
	function restore():Void;
}

/**
	The `MockModuleContext` class is used to manipulate module mocks.

	Stability: 1.0 - Early development

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mockmodulecontext
**/
extern class MockModuleContext {
	/**
		Reset the implementation of the mock module.
	**/
	function restore():Void;
}

/**
	A single recorded access to a mocked property.
**/
typedef MockPropertyAccess = {
	/**
		Either `"get"` or `"set"`.
	**/
	var type:String;

	/**
		Value that was read or written.
	**/
	var value:Dynamic;

	/**
		Error whose stack can be used to determine the callsite.
	**/
	var stack:Error;
};

/**
	The `MockPropertyContext` class is used to inspect or manipulate property mocks.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mockpropertycontext
**/
extern class MockPropertyContext {
	/**
		Copy of the internal array used to track accesses to the mocked property.
	**/
	var accesses(default, never):Array<MockPropertyAccess>;

	/**
		Number of times the property was accessed (read or written).
	**/
	function accessCount():Int;

	/**
		Change the value returned by the mocked property getter.
	**/
	function mockImplementation(value:Dynamic):Void;

	/**
		Change the mocked property value for a single access.
	**/
	function mockImplementationOnce(value:Dynamic, ?onAccess:Int):Void;

	/**
		Reset the access history of the mocked property.
	**/
	function resetAccesses():Void;

	/**
		Reset the implementation of the mock property to its original behavior.
	**/
	function restore():Void;
}

/**
	The `MockTracker` class manages mocking functionality.

	The test runner module provides a top-level `mock` export which is a `MockTracker`
	instance. Each test also provides its own instance via `TestContext.mock`.

	@see https://nodejs.org/docs/latest-v24.x/api/test.html#class-mocktracker
**/
extern class MockTracker {
	/**
		Create a mock function.
	**/
	@:overload(function(?original:Function, ?options:MockFunctionOptions):MockedFunction {})
	function fn(?original:Function, ?implementation:Function, ?options:MockFunctionOptions):MockedFunction;

	/**
		Syntax sugar for `method` with `options.getter` set to `true`.
	**/
	@:overload(function(object:Dynamic, methodName:EitherType<String, Dynamic>, ?options:MockFunctionOptions):MockedFunction {})
	function getter(object:Dynamic, methodName:EitherType<String, Dynamic>, ?implementation:Function, ?options:MockFunctionOptions):MockedFunction;

	/**
		Create a mock on an existing object method.
	**/
	@:overload(function(object:Dynamic, methodName:EitherType<String, Dynamic>, ?options:MockMethodOptions):MockedFunction {})
	function method(object:Dynamic, methodName:EitherType<String, Dynamic>, ?implementation:Function, ?options:MockMethodOptions):MockedFunction;

	/**
		Mock the exports of a module.

		Requires `--experimental-test-module-mocks`.
	**/
	function module(specifier:EitherType<String, Dynamic>, ?options:MockModuleOptions):MockModuleContext;

	/**
		Create a mock for a property value on an object.
	**/
	function property(object:Dynamic, propertyName:EitherType<String, Dynamic>, ?value:Dynamic):MockedProperty;

	/**
		Restore default behavior of all mocks created by this tracker and disassociate them.
	**/
	function reset():Void;

	/**
		Restore default behavior of all mocks without disassociating them from this tracker.
	**/
	function restoreAll():Void;

	/**
		Syntax sugar for `method` with `options.setter` set to `true`.
	**/
	@:overload(function(object:Dynamic, methodName:EitherType<String, Dynamic>, ?options:MockFunctionOptions):MockedFunction {})
	function setter(object:Dynamic, methodName:EitherType<String, Dynamic>, ?implementation:Function, ?options:MockFunctionOptions):MockedFunction;

	/**
		`MockTimers` instance associated with this tracker.
	**/
	var timers(default, never):MockTimers;
}
