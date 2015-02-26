package js.node.smalloc;

/**
    Enum of possible external array types.
**/
@:jsRequire("smalloc", "Types")
@:fakeEnum(Int) extern enum Types {
    Int8;
    Uint8;
    Int16;
    Uint16;
    Int32;
    Uint32;
    Float;
    Double;
    Uint8Clamped;
}
