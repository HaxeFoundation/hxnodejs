package js.node.stream;

/**
    This is a trivial implementation of a `Transform` stream that simply passes the input bytes across to the output.
    Its purpose is mainly for examples and testing, but there are occasionally use cases where it can come in handy
    as a building block for novel sorts of streams.
**/
@:jsRequire("stream", "PassThrough")
extern class PassThrough extends Transform<PassThrough> {}
