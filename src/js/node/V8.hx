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

import haxe.Constraints.Function;
import js.lib.Promise;
import js.node.Buffer;
import js.node.stream.Readable.IReadable;

/**
	The `v8` module exposes APIs that are specific to the version of V8 built into the Node.js binary.

	@see https://nodejs.org/docs/latest-v24.x/api/v8.html
**/
@:jsRequire("v8")
extern class V8 {
	/**
		Returns an integer representing a version tag derived from the V8 version, command-line flags,
		and detected CPU features. This is useful for determining whether a `vm.Script` `cachedData` buffer
		is compatible with this instance of V8.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8cacheddataversiontag
	**/
	static function cachedDataVersionTag():Int;

	/**
		Returns an object with statistics about the V8 heap.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8getheapstatistics
	**/
	static function getHeapStatistics():V8HeapStatistics;

	/**
		Returns statistics about the V8 heap spaces, i.e. the segments which make up the V8 heap.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8getheapspacestatistics
	**/
	static function getHeapSpaceStatistics():Array<V8HeapSpaceStatistics>;

	/**
		Get statistics about code and its metadata in the heap, see V8 `GetHeapCodeAndMetadataStatistics`.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8getheapcodestatistics
	**/
	static function getHeapCodeStatistics():V8HeapCodeStatistics;

	/**
		Retrieves CppHeap statistics regarding memory consumption and utilization.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8getcppheapstatisticsdetaillevel
	**/
	static function getCppHeapStatistics(?detailLevel:V8CppHeapStatisticsDetailLevel):Dynamic;

	/**
		Generates a snapshot of the current V8 heap and returns a Readable stream that may be used to
		read the JSON serialized representation.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8getheapsnapshotoptions
	**/
	static function getHeapSnapshot(?options:V8HeapSnapshotOptions):IReadable;

	/**
		Generates a snapshot of the current V8 heap and writes it to a JSON file.
		Returns the filename where the snapshot was saved.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8writeheapsnapshotfilename-options
	**/
	@:overload(function(?options:V8HeapSnapshotOptions):String {})
	static function writeHeapSnapshot(?filename:String, ?options:V8HeapSnapshotOptions):String;

	/**
		This method can be used to programmatically set V8 command line flags.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8setflagsfromstringflags
	**/
	static function setFlagsFromString(string:String):Void;

	/**
		The `v8.stopCoverage()` method allows the user to stop collecting coverage, which was started by
		`NODE_V8_COVERAGE`. While `NODE_V8_COVERAGE` can be used for collecting coverage for both
		tests (via `node:test`) and application code, this method can be used to stop collecting coverage
		on either side of that boundary.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8stopcoverage
	**/
	static function stopCoverage():Void;

	/**
		The `v8.takeCoverage()` method allows the user to write the coverage started by `NODE_V8_COVERAGE`
		to disk on demand.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8takecoverage
	**/
	static function takeCoverage():Void;

	/**
		This API sets a limit for near-heap-limit callback invocations.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8setheapsnapshotnearheaplimitlimit
	**/
	static function setHeapSnapshotNearHeapLimit(limit:Int):Void;

	/**
		Uses a `DefaultSerializer` to serialize `value` into a buffer.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8serializevalue
	**/
	static function serialize(value:Dynamic):Buffer;

	/**
		Uses a `DefaultDeserializer` with default options to read a JS value from a buffer.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8deserializebuffer
	**/
	static function deserialize(buffer:Buffer):Dynamic;

	/**
		This API will find all objects corresponding to the constructor `ctor`.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8queryobjectsctor-options
	**/
	static function queryObjects(ctor:Function, ?options:V8QueryObjectsOptions):Dynamic;

	/**
		Tracks `Promise` lifecycle callbacks. Prefer `async_hooks` / `diagnostics_channel` for most apps.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#promise-hooks
	**/
	static final promiseHooks:V8PromiseHooks;

	/**
		Startup snapshot builder API (only meaningful when building a snapshot).

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#startup-snapshot-api
	**/
	static final startupSnapshot:V8StartupSnapshot;

	/**
		Starts a CPU profile then returns a `SyncCPUProfileHandle`.
		Supports `using` / `[Symbol.dispose]` syntax.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8startcpuprofile
	**/
	static function startCpuProfile():V8SyncCpuProfileHandle;

	/**
		Returns whether the string is stored in one-byte (Latin-1) representation in V8.

		@see https://nodejs.org/docs/latest-v24.x/api/v8.html#v8isstringonebyterepresentationcontent
	**/
	static function isStringOneByteRepresentation(content:String):Bool;
}

/**
	Detail level for `V8.getCppHeapStatistics`.
**/
enum abstract V8CppHeapStatisticsDetailLevel(String) from String to String {
	var Brief = "brief";
	var Detailed = "detailed";
}

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

/**
	Options for `V8.queryObjects`.
**/
typedef V8QueryObjectsOptions = {
	/**
		If `"count"`, return only the number of matching objects; otherwise return the objects themselves.
	**/
	@:optional var format:String;
}

typedef V8PromiseHooks = {
	function onInit(init:(promise:Dynamic, parent:Dynamic) -> Void):() -> Void;
	function onSettled(settled:(promise:Dynamic) -> Void):() -> Void;
	function onBefore(before:(promise:Dynamic) -> Void):() -> Void;
	function onAfter(after:(promise:Dynamic) -> Void):() -> Void;
	function createHook(callbacks:V8PromiseHookCallbacks):() -> Void;
}

typedef V8PromiseHookCallbacks = {
	@:optional var init:(promise:Dynamic, parent:Dynamic) -> Void;
	@:optional var before:(promise:Dynamic) -> Void;
	@:optional var after:(promise:Dynamic) -> Void;
	@:optional var settled:(promise:Dynamic) -> Void;
}

typedef V8StartupSnapshot = {
	function addSerializeCallback(callback:(data:Dynamic) -> Void, ?data:Dynamic):Void;
	function addDeserializeCallback(callback:(data:Dynamic) -> Void, ?data:Dynamic):Void;
	function setDeserializeMainFunction(callback:(data:Dynamic) -> Void, ?data:Dynamic):Void;
	function isBuildingSnapshot():Bool;
}

/**
	Handle returned by `V8.startCpuProfile`.

	Also implements `[Symbol.dispose]()` to stop and discard the profile.

	@see https://nodejs.org/docs/latest-v24.x/api/v8.html#class-synccpuprofilehandle
**/
typedef V8SyncCpuProfileHandle = {
	/**
		Stop collecting the profile and return the profile data.
	**/
	function stop():String;
}

/**
	Collects GC profile data. Supports `using` / `[Symbol.dispose]` syntax.

	@see https://nodejs.org/docs/latest-v24.x/api/v8.html#class-v8gcprofiler
**/
@:jsRequire("v8", "GCProfiler")
extern class V8GCProfiler {
	function new();

	/**
		Start collecting GC profile data.
	**/
	function start():Void;

	/**
		Stop collecting GC profile data and return the profile.
	**/
	function stop():Dynamic;

	/**
		Stop collecting GC data and discard the profile.

		Maps to `[Symbol.dispose]()`.
	**/
	@:native("@@dispose")
	function dispose():Void;
}

/**
	Compatibility alias for `V8SyncCpuProfileHandle`.
**/
@:deprecated("Use V8SyncCpuProfileHandle instead")
typedef V8CpuProfileHandle = V8SyncCpuProfileHandle;

// Serializer / Deserializer hierarchy: prefer `V8.serialize` / `V8.deserialize` for common cases.
// Full custom subclass hooks can be added when a caller needs them.
