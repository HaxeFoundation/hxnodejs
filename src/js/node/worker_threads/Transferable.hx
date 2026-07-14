/*
 * Copyright (C)2014-2025 Haxe Foundation
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

package js.node.worker_threads;

import haxe.extern.EitherType;
import js.lib.ArrayBuffer;
import js.node.fs.FileHandle;
import js.node.web.AbortSignal;
import js.node.web.ReadableStream;
import js.node.web.TransformStream;
import js.node.web.WritableStream;

/**
	Objects accepted in a `worker_threads` `transferList` / structured-clone transfer list.

	Matches the Node.js transferable set that already has externs in this repo
	(`ArrayBuffer`, `MessagePort`, `AbortSignal`, `FileHandle`, and web streams).
	Does not invent types such as `SharedArrayBuffer` that are not yet externed.

	@see https://nodejs.org/docs/latest-v24.x/api/worker_threads.html#portpostmessagevalue-transferlist
**/
typedef Transferable = EitherType<ArrayBuffer,
	EitherType<MessagePort,
		EitherType<AbortSignal, EitherType<FileHandle, EitherType<ReadableStream, EitherType<WritableStream, TransformStream>>>>>>;
