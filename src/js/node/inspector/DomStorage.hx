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

package js.node.inspector;

/**
	Helpers that broadcast Chrome DevTools Protocol `DOMStorage` events to connected frontends.

	Stability: 1.1 - Active development.

	Added in: v24.16.0 (Active LTS). Not available on Maintenance LTS 22.x.
	Only available with the `--experimental-storage-inspection` flag enabled.

	Haxe type is `DomStorage` (acronyms are not uppercased); the Node.js export name is `DOMStorage`.

	@see https://nodejs.org/docs/latest-v24.x/api/inspector.html#inspectordomstoragedomstorageitemadded
**/
@:jsRequire("inspector", "DOMStorage")
extern class DomStorage {
	/**
		Broadcasts the `DOMStorage.domStorageItemAdded` event to connected frontends.
	**/
	static function domStorageItemAdded(params:DomStorageItemAddedParams):Void;

	/**
		Broadcasts the `DOMStorage.domStorageItemRemoved` event to connected frontends.
	**/
	static function domStorageItemRemoved(params:DomStorageItemRemovedParams):Void;

	/**
		Broadcasts the `DOMStorage.domStorageItemUpdated` event to connected frontends.
	**/
	static function domStorageItemUpdated(params:DomStorageItemUpdatedParams):Void;

	/**
		Broadcasts the `DOMStorage.domStorageItemsCleared` event to connected frontends.
	**/
	static function domStorageItemsCleared(params:DomStorageItemsClearedParams):Void;

	/**
		Registers storage for inspection.
	**/
	static function registerStorage(params:DomStorageRegisterParams):Void;
}

typedef DomStorageId = {
	@:optional var securityOrigin:String;
	@:optional var storageKey:String;
	var isLocalStorage:Bool;
}

typedef DomStorageItemAddedParams = {
	var storageId:DomStorageId;
	var key:String;
	var newValue:String;
}

typedef DomStorageItemRemovedParams = {
	var storageId:DomStorageId;
	var key:String;
}

typedef DomStorageItemUpdatedParams = {
	var storageId:DomStorageId;
	var key:String;
	var oldValue:String;
	var newValue:String;
}

typedef DomStorageItemsClearedParams = {
	var storageId:DomStorageId;
}

/**
	Parameters for `DomStorage.registerStorage`.

	`storageMap` is the storage backing object; shape follows the experimental
	storage-inspection API (kept pragmatic).
**/
typedef DomStorageRegisterParams = {
	var isLocalStorage:Bool;
	var storageMap:{};
}
