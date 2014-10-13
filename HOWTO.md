# Extern guidelines

This document describes the principles used in `hxnodejs` regarding package structure, naming, typing and useful tricks.
It is advised to follow these guidelines when creating externs for third-party node modules.

## Package structure

If a node module contains functions and/or variables, an extern class with static functions is created with capitalized name of that module. For that class, a `@:jsRequire("modulename")` metadata is added, so it's automatically `require`d on use.

For example:

```haxe
@:jsRequire("fs")
extern class Fs {
    static function writeFileSync(filename:String, data:String):Void;
}
```

If a module contains classes, a package is also created for that module and the classes are placed inside that package. For example:

```haxe
package fs;

extern class Stats {
    // ...
}
```

If that class is supposed to be available to user for creating with `new`, the `@:jsRequire("modulename", "ClassName")` metadata is added. For example:

```haxe
package events;

@:jsRequire("events", "EventEmitter")
extern class EventEmitter implements IEventEmitter {
    function new();
    // ...
}
```

Example module layout:
 * root
   * events
     * EventEmitter.hx
   * fs
     * Stats.hx
     * FSWatcher.hx
   * Fs.hx

### Imports

It makes sense to use e.g. `import fs.*` in the `Fs.hx` so that all relevant classes are brought into context of the module static class. Other than that, usual import recommendations apply: import only what's necessary and remove unused imports.

## Naming

All modules, classes, fields and functions arguments should be named after the official API documentation of the native module. Static classes representing node modules are capitalized as they are Haxe types and must follow haxe type naming requirements. Acronyms are NOT uppercased (i.e. `Json`, not `JSON`).

## Events

node.js event emitters takes strings as event names and we have no way to properly map a callback type to its event name
at compile-time. However we do provide [@:enum abstract types](http://haxe.org/manual/types-abstract-enum.html) that enumerate possible event names for a given event emitter.
They are purely advisory, but they are good for both documentation and holding constant event names.

For each `EventEmitter` subclass, an `@:enum abstract` type must be created with a `Event` postfix in its name. For example,
if we have a `Process` class which is an `EventEmitter`, it should have a pairing `ProcessEvent` type in its module, i.e.:

```haxe
extern class Process extends EventEmitter {
    // ...
}

@:enum abstract ProcessEvent(String) to String {
    var Exit = "exit";
}
```

Note that the abstract type must have a `to String` cast so it can be used where a string is expected (because event names are strings). Event constant names are `UpperCamelCase` and their values are actual event names.

**TODO: decide on event inheritance https://github.com/HaxeFoundation/hxnodejs/issues/21**

## Method overloading and optional arguments

TODO (describe the difference of overloading/optional argument concepts and advise where to use which and that, describe `haxe.Rest`)

## Typing

TODO (describe the idea of maximum typing while keeping sanity)

### Multiple inheritance

TODO (describe how to deal with multiple inheritance using interfaces, as we do with IReadable/IWritable streams, mention `@:remove` metadata for interfaces).

### Object structures

When a function takes/returns an object with predefined fields (e.g. options argument in many node.js methods), [anonymous structures](http://haxe.org/manual/types-anonymous-structure.html) are used along with `typedef`s.

Example:
```haxe
typedef FileOptions = {
    var path:String;
    @:optional var encoding:String;
    @:optional var mode:Int;
}

function readFile(options:FileOptions):Void;
```

**TODO describe typedef naming**

### Dynamic objects

TODO (describe DynamicAccess, see https://github.com/HaxeFoundation/haxe/pull/3464)

### Either types

If a function accepts different types for a single argument, at the most times it is better to use `@:overload` do describe that. However there are cases where it is not sufficient, for example: a collection can contain elements of different (but limited) types or an options object field can be of either type.

To deal with that Haxe provides the `haxe.EitherType<T1,T2>` type that is an abstract over `Dynamic` that can be implicitly casted from and to both `T1` and `T2`.

Example:
```haxe
typedef SomeOptions = {
    var field:haxe.EitherType<String,Array<String>>;
}
```
Here, the `SomeOptions.field` can be assigned to/from either a string or array of strings.

If a type can be of 3 and more types, nested `EitherType` can be used.

### Constant enumeration

If there's a finite set of posible values for a function argument or object field, [@:enum abstract types](http://haxe.org/manual/types-abstract-enum.html) are used to enumerate those values.

Example:

```haxe
@:enum abstract SymlinkType(String) from String to String {
    var File = "file";
    var Dir = "dir";
    var Junction = "junction";
}
```

The `to` and `from` implicit cast must be added so user can use both enumeration constants and original values as documented in API documentation of native library, however `from` cast may be omitted if the type is used only for return values and is not supposed to be created by user.

Constant names are `UpperCamelCase` and their values are actual values expected by native API.


Note that combined with `haxe.EitherType` (described above), `@:enum abstract`s can handle even complicated cases where a value can be of different types, e.g.

```haxe
@:enum abstract ListeningEventAddressType(haxe.EitherType<Int,String>) to haxe.EitherType<Int,String> {
	var TCPv4 = 4;
	var TCPv6 = 6;
	var Unix = -1;
	var UDPv4 = "udp4";
	var UDPv6 = "udp6";
}
```

## API Documenting

We use API documentation style found in Haxe standard library and copy upstream API documentation text to externs (applying some minor editing/reformatting to it). 

Example of Haxe standard library style:

```haxe
/**
	Does that and returns this.
	
	Some more info about using argument `a` and `b`.
**/
static function doStuff(a:Int, b:String):Void;
```

Note that node.js API documentation often describes types of variables which is mostly redundant in Haxe, so these parts can be removed.

## Tricks and hints

TODO (dealing with keywords, `untyped __js__`, inline methods and properties on extern classes)
