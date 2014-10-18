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

In case Haxe name for a node.js module matches the name of its inner class, that class is imported into module using `import as`, adding `Object` as a postfix. For example:

```haxe
import js.node.child_process.ChildProcess as ChildProcessObject; // class representing node.js inner class

@:jsRequire("child_process") // class representing node.js module
extern class ChildProcess {
    static function spawn(/*...*/):ChildProcessObject;
}
```

## Events

Node.js event emitters take strings as event names and don't check listener signatures in any way. The hxnodejs extern for `EventEmitter` supports that behaviour for convenience of copy-pasting JavaScript code. However it also provides a way to type-check event listeners.

If you provide an instance of `Event<T>` abstract string type where an event name is expected in any `EventEmitter` method, then the listener type will be unified with `T` and thus provide type checking and inference for the listener function.

We provide [@:enum abstract types](http://haxe.org/manual/types-abstract-enum.html) that enumerate possible event names for a given event emitter. They are implicitly castable to `Event<T>` and can be used for type-checking listener functions as described above. For each `EventEmitter` subclass, an `@:enum abstract` type must be created with a `Event` postfix in its name. For example, if we have a `Process` class which is an `EventEmitter`, it should have a pairing `ProcessEvent` type in its module, i.e.:

```haxe
extern class Process extends EventEmitter {
    // ...
}

@:enum abstract ProcessEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
    var Exit : ProcessEvent<Int->Void> = "exit";
}
```

In the example above, the listener type for the 'exit' event is `Int->Void` which means it takes `Int` as its first argument and returns nothing.

Event constant names are `UpperCamelCase` and their values are actual event names.

## Method overloading and optional arguments

TODO (describe the difference of overloading/optional argument concepts and advise where to use which and that, describe `haxe.Rest`)

## Typing

The whole idea of haxe externs is provide a fully type-checked access to external API. Considering that, we must avoid the need for use `Dynamic` type or `cast` and think of a way to properly express type restrictions.

On the other hand, we want developers to be able to copy-paste node.js code into haxe with minimal modification and have it compiling. For that reason we have to weaken some typing restrictions, for example adding implicit cast `from String` for our `@:enum abstract` types.

### Multiple inheritance

TODO (describe how to deal with multiple inheritance using interfaces, as we do with IReadable/IWritable streams, mention `@:remove` metadata for interfaces).

### Chaining methods

TODO (describe how to use type parameters + interface to properly type chaining methods)

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

If a JavaScript object is intended to be used as a *keyed collection* of values and thus doesn't have a predefined structure (e.g. `process.env`), use `haxe.DynamicAccess<T>`. It's a special abstract type designed just for that. It provides `Map`-like API for iterating over its keys and working with values.

Note that in some cases, an object doesn't have a predefined structure, but neither is a *collection*. In those cases, use simple `Dynamic<Dynamic>`.

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

## Deprecated API

Use `@:deprecated` metadata for upstream API that is deprecated. That way compiler will emit a warning when using deprecated API.

Example:
```haxe
@:deprecated // default warning message
extern class DeprecatedClass {
}

extern class NotSoDeprecated {
	@:deprecated("use otherMethod instead") // custom warning message
	function deprecatedMethod():Void;

	function otherMethod():Void;
}
```

## Tricks and hints

TODO (dealing with keywords, `untyped __js__`, inline methods and properties on extern classes)
