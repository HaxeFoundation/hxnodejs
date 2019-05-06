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

import haxe.DynamicAccess;
import js.node.Util.InspectOptions;

@:jsRequire("util", "inspect")
extern class Inspect {
	/**
		The `inspect()` method returns a string representation of `object` that is intended for debugging.
		The output of `inspect` may change at any time and should not be depended upon programmatically.
		Additional `options` may be passed that alter certain aspects of the formatted string.
		`inspect()` will use the constructor's name and/or `@@toStringTag` to make an identifiable tag for an inspected value.

		Values may supply their own custom `inspect(depth, opts)` functions, when called these receive the current `depth`
		in the recursive inspection, as well as the options object passed to `inspect()`.

		Using the `showHidden` option allows to inspect WeakMap and WeakSet entries.
		If there are more entries than `maxArrayLength`, there is no guarantee which entries are displayed.
		That means retrieving the same WeakSet entries twice might actually result in a different output.
		Besides this any item might be collected at any point of time by the garbage collectorif there is no strong reference
		left to that object. Therefore there is no guarantee to get a reliable output.
	**/
	@:selfCall
	@:overload(function(object:Dynamic, ?showHidden:Bool, ?depth:Int, ?colors:Bool):String {})
	static function inspect(object:Dynamic, ?options:InspectOptions):String;

	/**
		a map assigning each style a color from `inspect_colors`.
		Highlighted styles and their default values are:
			number (yellow)
			boolean (yellow)
			string (green)
			date (magenta)
			regexp (red)
			null (bold)
			undefined (grey)
			special - only function at this time (cyan)
			name (intentionally no styling)
	**/
	static var styles:DynamicAccess<String>;

	/**
		Predefined color codes are: white, grey, black, blue, cyan, green, magenta, red and yellow.
		There are also bold, italic, underline and inverse codes.
	**/
	static var colors:DynamicAccess<Array<Int>>;

	/**
		The `defaultOptions` value allows customization of the default options used by `Util.inspect`.
		This is useful for functions like `Console.log` or `Util.format` which implicitly call into `Util.inspect`
		It shall be set to an object containing one or more valid `Util.inspect()` options.
		Setting option properties directly is also supported.
	**/
	static var defaultOptions:InspectOptions;

	/**
		In addition to being accessible through `Inspect.custom`, this symbol is registered globally
		and can be accessed in any environment as `Symbol.for_('nodejs.util.inspect.custom')`.
	**/
	#if haxe4
	static final custom:js.lib.Symbol;
	#else
	static var custom(default,never):Dynamic;
	#end
}
