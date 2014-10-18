package js.node;

import js.node.events.EventEmitter;

/**
    Base class for all streams.
**/
@:jsRequire("stream") // the module itself is also a class
extern class Stream<TSelf:Stream<TSelf>> extends EventEmitter<TSelf> implements IStream {}

/**
    `IStream` interface is used as "any Stream".

    See `Stream` for actual class.
**/
@:remove
extern interface IStream extends IEventEmitter {}
