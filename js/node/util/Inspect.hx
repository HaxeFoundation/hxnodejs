/*
 * Copyright (C)2014-2015 Haxe Foundation
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
        Return a string representation of `object`, which is useful for debugging.
        An optional `options` object may be passed that alters certain aspects of the formatted string.

        Objects also may define their own `inspect(depth:Int)` function which `inspect` will invoke and
        use the result of when inspecting the object.
    **/
    @:selfCall
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
}
