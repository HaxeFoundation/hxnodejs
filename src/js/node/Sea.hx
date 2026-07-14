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

import js.lib.ArrayBuffer;
import js.node.web.Blob;

/**
	Built-in helpers for scripts running inside a single-executable application (SEA).

	Stability: 1.1 - Active development.

	@see https://nodejs.org/docs/latest-v24.x/api/single-executable-applications.html#single-executable-application-api
**/
@:jsRequire("node:sea")
extern class Sea {
	/**
		Whether this script is running inside a single-executable application.

		@see https://nodejs.org/docs/latest-v24.x/api/single-executable-applications.html#seaissea
	**/
	static function isSea():Bool;

	/**
		Retrieve a bundled asset by key.

		Without `encoding`, returns a copy of the asset as an `ArrayBuffer`.
		With `encoding`, returns a decoded string (any encoding supported by `TextDecoder`).

		@see https://nodejs.org/docs/latest-v24.x/api/single-executable-applications.html#seagetassetkey-encoding
	**/
	@:overload(function(key:String, encoding:String):String {})
	static function getAsset(key:String):ArrayBuffer;

	/**
		Retrieve a bundled asset as a `Blob`.

		@see https://nodejs.org/docs/latest-v24.x/api/single-executable-applications.html#seagetassetasblobkey-options
	**/
	static function getAssetAsBlob(key:String, ?options:SeaBlobOptions):Blob;

	/**
		Retrieve the raw asset without copying.

		@see https://nodejs.org/docs/latest-v24.x/api/single-executable-applications.html#seagetrawassetkey
	**/
	static function getRawAsset(key:String):ArrayBuffer;

	/**
		Keys of all assets embedded in the executable.
		Throws when not running inside a SEA.

		Added in: v24.8.0

		@see https://nodejs.org/docs/latest-v24.x/api/single-executable-applications.html#seagetassetkeys
	**/
	static function getAssetKeys():Array<String>;
}

/**
	Options for `Sea.getAssetAsBlob`.
**/
typedef SeaBlobOptions = {
	/**
		Optional MIME type for the blob.
	**/
	@:optional var type:String;
}
