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

TODO (describe @:enum abstract, decide on https://github.com/HaxeFoundation/hxnodejs/issues/21)

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

TODO (describe `haxe.EitherType`)

### @:enum abstracts

TODO (describe the idea of using those for finite sets of values and how it can be used with `haxe.EitherType`, define rules for `to/from`)

## Tricks and hints

TODO (dealing with keywords, `untyped __js__`, inline methods and properties on extern classes)
