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

package js.node;

import haxe.Constraints.Function;
import js.node.Buffer;
import js.node.stream.Readable.IReadable;

/**
	The v8 module exposes APIs that are specific to the version of V8 built into the Node.js binary.

	@see https://nodejs.org/docs/latest-v24.x/api/v8.html

	// TODO(section-5): expand Serializer/Deserializer/DefaultSerializer subclasses and CPU/Heap profile handles
**/
@:jsRequire("v8")
extern class V8 {
	/**
		Returns an integer representing a version tag derived from the V8 version, command-line flags,
		and detected CPU features. This is useful for determining whether a `vm.Script` `cachedData` buffer
		is compatible with this instance of V8.
	**/
	static function cachedDataVersionTag():Int;

	/**
		Returns an object with statistics about the V8 heap spaces.
	**/
	static function getHeapStatistics():V8HeapStatistics;

	/**
		Returns statistics about the V8 heap spaces, i.e. the segments which make up the V8 heap.
	**/
	static function getHeapSpaceStatistics():Array<V8HeapSpaceStatistics>;

	/**
		Get statistics about code and its metadata in the heap, see V8 `GetHeapCodeAndMetadataStatistics`.
	**/
	static function getHeapCodeStatistics():V8HeapCodeStatistics;

	/**
		Generates a snapshot of the current V8 heap and returns a Readable stream that may be used to
		read the JSON serialized representation.
	**/
	static function getHeapSnapshot(?options:V8HeapSnapshotOptions):IReadable;

	/**
		Generates a snapshot of the current V8 heap and writes it to a JSON file.
		Returns the filename where the snapshot was saved.
	**/
	@:overload(function(?options:V8HeapSnapshotOptions):String {})
	static function writeHeapSnapshot(?filename:String, ?options:V8HeapSnapshotOptions):String;

	/**
		This method can be used to programmatically set V8 command line flags.
	**/
	static function setFlagsFromString(string:String):Void;

	/**
		The `v8.stopCoverage()` method allows the user to stop collecting coverage, which was started by
		`NODE_V8_COVERAGE`. While `NODE_V8_COVERAGE` can be used for collecting coverage for both
		tests (via `node:test`) and application code, this method can be used to stop collecting coverage
		on either side of that boundary.
	**/
	static function stopCoverage():Void;

	/**
		The `v8.takeCoverage()` method allows the user to write the coverage started by `NODE_V8_COVERAGE`
		to disk on demand.
	**/
	static function takeCoverage():Void;

	/**
		This API sets a limit for near-heap-limit callback invocations.
	**/
	static function setHeapSnapshotNearHeapLimit(limit:Int):Void;

	/**
		Uses a `DefaultSerializer` to serialize `value` into a buffer.
	**/
	static function serialize(value:Dynamic):Buffer;

	/**
		Uses a `DefaultDeserializer` with default options to read a JS value from a buffer.
	**/
	static function deserialize(buffer:Buffer):Dynamic;

	/**
		This API will find all objects corresponding to the constructor `ctor`.
	**/
	static function queryObjects(ctor:Function, ?options:{format:String}):Dynamic;

	/**
		Tracks `Promise` lifecycle callbacks. Prefer `async_hooks` / `diagnostics_channel` for most apps.

		// TODO(section-5): fully type promiseHooks createHook callbacks
	**/
	static var promiseHooks(default, null):V8PromiseHooks;

	/**
		Startup snapshot builder API (only meaningful when building a snapshot).
	**/
	static var startupSnapshot(default, null):V8StartupSnapshot;

	/**
		Starts a CPU profile and returns a handle that can be used to stop it.
		// TODO(section-5): type CPUProfileHandle / SyncCPUProfileHandle / HeapProfileHandle
	**/
	static function startCpuProfile():V8CpuProfileHandle;

	/**
		Returns whether the string is stored in one-byte (Latin-1) representation in V8.
	**/
	static function isStringOneByteRepresentation(content:String):Bool;
}

// TODO(section-5): v8.Serializer / Deserializer / DefaultSerializer / DefaultDeserializer / GCProfiler / getCppHeapStatistics

/**
	Object returned by `V8.getHeapStatistics` method.
**/
typedef V8HeapStatistics = {
	var total_heap_size:Float;
	var total_heap_size_executable:Float;
	var total_physical_size:Float;
	var total_available_size:Float;
	var used_heap_size:Float;
	var heap_size_limit:Float;
	@:optional var malloced_memory:Float;
	@:optional var peak_malloced_memory:Float;
	@:optional var does_zap_garbage:Int;
	@:optional var number_of_native_contexts:Float;
	@:optional var number_of_detached_contexts:Float;
	@:optional var total_global_handles_size:Float;
	@:optional var used_global_handles_size:Float;
	@:optional var external_memory:Float;
}

/**
	Object returned by `V8.getHeapSpaceStatistics` method.
**/
typedef V8HeapSpaceStatistics = {
	var space_name:String;
	var space_size:Float;
	var space_used_size:Float;
	var space_available_size:Float;
	var physical_space_size:Float;
}

/**
	Object returned by `V8.getHeapCodeStatistics` method.
**/
typedef V8HeapCodeStatistics = {
	var code_and_metadata_size:Float;
	var bytecode_and_metadata_size:Float;
	var external_script_source_size:Float;
	@:optional var cpu_profiler_metadata_size:Float;
}

typedef V8HeapSnapshotOptions = {
	/**
		If true, expose internals in the heap dump. Default: `false`.
	**/
	@:optional var exposeInternals:Bool;

	/**
		If true, expose numeric values in artificial fields. Default: `false`.
	**/
	@:optional var exposeNumericValues:Bool;
}

typedef V8PromiseHooks = {
	function onInit(init:Function):Function;
	function onSettled(settled:Function):Function;
	function onBefore(before:Function):Function;
	function onAfter(after:Function):Function;
	function createHook(callbacks:{?init:Function, ?before:Function, ?after:Function, ?settled:Function}):Function;
}

typedef V8StartupSnapshot = {
	function addSerializeCallback(callback:Function, ?data:Dynamic):Void;
	function addDeserializeCallback(callback:Function, ?data:Dynamic):Void;
	function setDeserializeMainFunction(callback:Function, ?data:Dynamic):Void;
	function isBuildingSnapshot():Bool;
}

/**
	Minimal handle returned by `V8.startCpuProfile`.
**/
typedef V8CpuProfileHandle = {
	function stop():String;
}

