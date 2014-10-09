package js.node;

/**
    An abstract type allowing values to be either of T1 or T2 type.

    TODO: move it into std lib? (see https://github.com/HaxeFoundation/hxnodejs/issues/15)
**/
@:forward // TODO: is this a good idea?
abstract EitherType<T1,T2>(Dynamic) from T1 to T1 from T2 to T2 {}
