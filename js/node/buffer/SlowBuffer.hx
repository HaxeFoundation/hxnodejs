package js.node.buffer;

/**
	Returns an un-pooled Buffer.

	In order to avoid the garbage collection overhead of creating many individually allocated Buffers,
	by default allocations under 4KB are sliced from a single larger allocated object.
	This approach improves both performance and memory usage since v8 does not need to track
	and cleanup as many Persistent objects.

	In the case where a developer may need to retain a small chunk of memory from a pool
	for an indeterminate amount of time it may be appropriate to create an un-pooled Buffer instance
	using `SlowBuffer` and copy out the relevant bits.

	Though this should used sparingly and only be a last resort after a developer has actively observed
	undue memory retention in their applications.
**/
@:jsRequire("buffer", "SlowBuffer")
extern class SlowBuffer extends Buffer {}
