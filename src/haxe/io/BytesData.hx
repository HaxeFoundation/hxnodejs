package haxe.io;

// TODO: understand how to properly override std class but only for the target output, not for the macro
#if !macro
typedef BytesData = js.node.Buffer;
#else
typedef BytesData = neko.NativeString;
#end
