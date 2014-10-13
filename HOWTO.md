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

@:enum abstract Process(String) to String {
    var Exit = "exit";
}
```

Note that the abstract type must have a `to String` cast so it can be used where a string is expected (because event names are strings).

**TODO: decide on event inheritance https://github.com/HaxeFoundation/hxnodejs/issues/21**

## Method overloading and optional arguments

TODO (describe the difference of overloading/optional argument concepts and advise where to use which and that, describe `haxe.Rest`)

## Typing

TODO (describe the idea of maximum typing while keeping sanity)

### Multiple inheritance

TODO (describe how to deal with multiple inheritance using interfaces, as we do with IReadable/IWritable streams).

### Object structures

TODO (describe structure typedefs, their naming and extending structures)

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

### @:enum abstracts

TODO (describe the idea of using those for finite sets of values and how it can be used with `haxe.EitherType`, define rules for `to/from`)

## Tricks and hints

TODO (dealing with keywords, `untyped __js__`, inline methods and properties on extern classes)
