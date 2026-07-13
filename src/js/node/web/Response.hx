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

package js.node.web;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.web.Request.BodyInit;
#if haxe4
import js.lib.ArrayBuffer;
import js.lib.Promise;
import js.lib.Uint8Array;
#else
import js.html.ArrayBuffer;
import js.Promise;
import js.html.Uint8Array;
#end

/**
	The Fetch API `Response` interface (undici).

	@see https://nodejs.org/api/globals.html#class-response
**/
@:native("Response")
extern class Response {
	/**
		Returns a new `Response` object associated with a network error.
	**/
	static function error():Response;

	/**
		Creates a new response with a different URL.
	**/
	static function redirect(url:String, ?status:Int):Response;

	/**
		Creates a new response with a JSON body.
	**/
	static function json(data:Dynamic, ?init:ResponseInit):Response;

	var type(default, null):String;
	var url(default, null):String;
	var redirected(default, null):Bool;
	var status(default, null):Int;
	var ok(default, null):Bool;
	var statusText(default, null):String;
	var headers(default, null):Headers;

	/**
		A `ReadableStream` of the body contents, or `null`.
		Typed as `Dynamic` until web streams externs are added.
	**/
	var body(default, null):Dynamic;

	var bodyUsed(default, null):Bool;

	function new(?body:BodyInit, ?init:ResponseInit):Void;

	function clone():Response;
	function arrayBuffer():Promise<ArrayBuffer>;
	function blob():Promise<Blob>;
	function bytes():Promise<Uint8Array>;
	function formData():Promise<FormData>;
	function json():Promise<Dynamic>;
	function text():Promise<String>;
}

/**
	Init options for `Response`.
**/
typedef ResponseInit = {
	@:optional var status:Int;
	@:optional var statusText:String;
	@:optional var headers:EitherType<Headers, EitherType<Array<Array<String>>, DynamicAccess<String>>>;
}
