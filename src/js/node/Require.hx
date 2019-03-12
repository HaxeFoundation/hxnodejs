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
package js.node;

import haxe.DynamicAccess;

@:native("require")
extern class Require {
	/**
		Fetches a library and returns the reference to it.
	**/
	@:selfCall
	static function require(module:String):Dynamic;

	/**
		Use the internal `require` machinery to look up the location of a module,
		but rather than loading the module, just return the resolved filename.
	**/
	static function resolve(module:String):String;

	/**
		Modules are cached in this object when they are required.
		By deleting a key value from this object, the next require will reload the module.
	**/
	static var cache(default,null):DynamicAccess<Module>;

	/**
		Instruct require on how to handle certain file extensions.

		Deprecated: In the past, this list has been used to load non-JavaScript modules into Node by compiling them on-demand.
		However, in practice, there are much better ways to do this, such as loading modules via some other Node program,
		or compiling them to JavaScript ahead of time.

		Since the `Module` system is locked, this feature will probably never go away. However, it may have subtle bugs
		and complexities that are best left untouched.
	**/
	@:deprecated
	static var extensions(default,null):DynamicAccess<Dynamic>;

	/**
		When a file is run directly from Node, `Require.main` is set to its module.
		That means that you can determine whether a file has been run directly by testing `Require.main == module`.
	**/
	static var main(default,null):Module;
}
