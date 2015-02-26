package js.node;

import js.node.smalloc.*;

/**
	Buffers are backed by a simple allocator that only handles the assignation of external raw memory.
	Smalloc exposes that functionality.
**/
@:jsRequire("smalloc")
extern class Smalloc {
	/**
		Returns `receiver` with allocated external array data.
		If no `receiver` is passed then a new Object will be created and returned.

		This can be used to create your own `Buffer`-like classes.
		No other properties are set, so the user will need to keep track of
		other necessary information (e.g. length of the allocation).
	**/
	@:overload(function<T>(length:Int, receiver:T, ?type:Types):T {})
	static function alloc<T>(length:Int, ?type:Types):T;

	/**
		Copy memory from one external array allocation to another.

		`copyOnto` automatically detects the length of the allocation internally,
		so no need to set any additional properties for this to work.
	**/
	static function copyOnto(source:Dynamic, sourceStart:Int, dest:Dynamic, destStart:Int, copyLength:Int):Void;

	/**
		Free memory that has been allocated to an object via `alloc`.
	**/
	static function dispose(obj:Dynamic):Void;

	/**
		Returns true if the `obj` has externally allocated memory.
	**/
	static function hasExternalData(obj:Dynamic):Bool;

	/**
		Size of maximum allocation.
		This is also applicable to `Buffer` creation.
	**/
	static var kMaxLength(default,null):Int;
}
