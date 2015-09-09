package haxe.io;

// TODO: understand how to properly override std class but only for the target output, not for the macro
#if !macro
@:dce
// @:coreApi // disabled due to `length` accessor
class Bytes {

    public var length(get,never) : Int;
    var b : BytesData;

    inline function new(b : BytesData) {
        this.b = b;
    }

    inline function get_length():Int {
        return b.length;
    }

    public inline function get( pos : Int ) : Int {
        return b[pos];
    }

    public inline function set( pos : Int, v : Int ) : Void {
        b[pos] = v;
    }

    public function blit( pos : Int, src : Bytes, srcpos : Int, len : Int ) : Void {
        if( pos < 0 || srcpos < 0 || len < 0 || pos + len > length || srcpos + len > src.length ) throw Error.OutsideBounds;
        src.b.copy(b, pos, srcpos, srcpos + len);
    }

    public inline function fill( pos : Int, len : Int, value : Int ) : Void {
        b.fill(value, pos, pos + len);
    }

    public function sub( pos : Int, len : Int ) : Bytes {
        if( pos < 0 || len < 0 || pos + len > length ) throw Error.OutsideBounds;
        return new Bytes(b.slice(pos, pos + len));
    }

    public inline function compare( other : Bytes ) : Int {
        return b.compare(other.b);
    }

    public inline function getDouble( pos : Int ) : Float {
        return b.readDoubleLE(pos);
    }

    public inline function getFloat( pos : Int ) : Float {
        return b.readFloatLE(pos);
    }

    public inline function setDouble( pos : Int, v : Float ) : Void {
        b.writeDoubleLE(v, pos);
    }

    public inline function setFloat( pos : Int, v : Float ) : Void {
        b.writeFloatLE(v, pos);
    }

    public inline function getUInt16( pos : Int ) : Int {
        return b.readInt16LE(pos);
    }

    public inline function setUInt16( pos : Int, v : Int ) : Void {
        return b.writeUInt16LE(v, pos);
    }

    public inline function getInt32( pos : Int ) : Int {
        return b.readInt32LE(pos);
    }

    public inline function getInt64( pos : Int ) : haxe.Int64 {
        return haxe.Int64.make(getInt32(pos+4),getInt32(pos));
    }

    public inline function setInt32( pos : Int, v : Int ) : Void {
        b.writeInt32LE(v, pos);
    }

    public inline function setInt64( pos : Int, v : haxe.Int64 ) : Void {
        setInt32(pos, v.low);
        setInt32(pos + 4, v.high);
    }

    public inline function getString( pos : Int, len : Int ) : String {
        return b.toString("utf-8", pos, pos + len);
    }

    public inline function toString() : String {
        return b.toString();
    }

    public inline function toHex() : String {
        return b.toString("hex");
    }

    public inline function getData() : BytesData {
        return b;
    }

    public inline static function alloc( length : Int ) : Bytes {
        return new Bytes(new BytesData(length));
    }

    public inline static function ofString( s : String ) : Bytes {
        return new Bytes(new BytesData(s));
    }

    public inline static function ofData( b : BytesData ) : Bytes {
        return new Bytes(b);
    }

    public inline static function fastGet( b : BytesData, pos : Int ) : Int {
        return b[pos];
    }
}

#else

class Bytes {

    public var length(default,null) : Int;
    var b : BytesData;

    function new(length,b) {
        this.length = length;
        this.b = b;
    }

    public inline function get( pos : Int ) : Int {
        return untyped $sget(b,pos);
    }

    public inline function set( pos : Int, v : Int ) : Void {
        untyped $sset(b,pos,v);
    }

    public function blit( pos : Int, src : Bytes, srcpos : Int, len : Int ) : Void {
        try untyped $sblit(b,pos,src.b,srcpos,len) catch( e : Dynamic ) throw Error.OutsideBounds;
    }

    public function fill( pos : Int, len : Int, value : Int ) {
        for( i in 0...len )
            set(pos++, value);
    }

    public function sub( pos : Int, len : Int ) : Bytes {
        return try new Bytes(len,untyped __dollar__ssub(b,pos,len)) catch( e : Dynamic ) throw Error.OutsideBounds;
    }

    public function compare( other : Bytes ) : Int {
        return untyped __dollar__compare(b,other.b);
    }


    /**
        Returns the IEEE double precision value at given position (in low endian encoding).
        Result is unspecified if reading outside of the bounds
    **/
    #if neko_v21 inline #end
    public function getDouble( pos : Int ) : Float {
        #if neko_v21
        return untyped $sgetd(b, pos, false);
        #else
        return FPHelper.i64ToDouble(getInt32(pos),getInt32(pos+4));
        #end
    }

    /**
        Returns the IEEE single precision value at given position (in low endian encoding).
        Result is unspecified if reading outside of the bounds
    **/
    #if neko_v21 inline #end
    public function getFloat( pos : Int ) : Float {
        #if neko_v21
        return untyped $sgetf(b, pos, false);
        #else
        var b = new haxe.io.BytesInput(this,pos,4);
        return b.readFloat();
        #end
    }

    /**
        Store the IEEE double precision value at given position in low endian encoding.
        Result is unspecified if writing outside of the bounds.
    **/
    #if neko_v21 inline #end
    public function setDouble( pos : Int, v : Float ) : Void {
        #if neko_v21
        untyped $ssetd(b, pos, v, false);
        #else
        untyped $sblit(b, pos, FPHelper._double_bytes(v,false), 0, 8);
        #end
    }

    /**
        Store the IEEE single precision value at given position in low endian encoding.
        Result is unspecified if writing outside of the bounds.
    **/
    #if neko_v21 inline #end
    public function setFloat( pos : Int, v : Float ) : Void {
        #if neko_v21
        untyped $ssetf(b, pos, v, false);
        #else
        untyped $sblit(b, pos, FPHelper._float_bytes(v,false), 0, 4);
        #end
    }

    /**
        Returns the 16 bit unsigned integer at given position (in low endian encoding).
    **/
    public inline function getUInt16( pos : Int ) : Int {
        #if neko_v21
        return untyped $sget16(b, pos, false);
        #else
        return get(pos) | (get(pos + 1) << 8);
        #end
    }

    /**
        Store the 16 bit unsigned integer at given position (in low endian encoding).
    **/
    public inline function setUInt16( pos : Int, v : Int ) : Void {
        #if neko_v21
        untyped $sset16(b, pos, v, false);
        #else
        set(pos, v);
        set(pos + 1, v >> 8);
        #end
    }

    /**
        Returns the 32 bit integer at given position (in low endian encoding).
    **/
    public inline function getInt32( pos : Int ) : Int {
        #if neko_v21
        return untyped $sget32(b, pos, false);
        #else
        return get(pos) | (get(pos + 1) << 8) | (get(pos + 2) << 16) | (get(pos+3) << 24);
        #end
    }

    /**
        Returns the 64 bit integer at given position (in low endian encoding).
    **/
    public inline function getInt64( pos : Int ) : haxe.Int64 {
        return haxe.Int64.make(getInt32(pos+4),getInt32(pos));
    }

    public inline function setInt32( pos : Int, v : Int ) : Void {
        #if neko_v21
        untyped $sset32(b, pos, v, false);
        #else
        set(pos, v);
        set(pos + 1, v >> 8);
        set(pos + 2, v >> 16);
        set(pos + 3, v >>> 24);
        #end
    }

    public inline function setInt64( pos : Int, v : haxe.Int64 ) : Void {
        setInt32(pos, v.low);
        setInt32(pos + 4, v.high);
    }

    public function getString( pos : Int, len : Int ) : String {
        return try new String(untyped __dollar__ssub(b,pos,len)) catch( e : Dynamic ) throw Error.OutsideBounds;
    }

    public function toString() : String {
        return new String(untyped __dollar__ssub(b,0,length));
    }

    public function toHex() : String {
        var s = new StringBuf();
        var chars = [];
        var str = "0123456789abcdef";
        for( i in 0...str.length )
            chars.push(str.charCodeAt(i));
        for( i in 0...length ) {
            var c = get(i);
            s.addChar(chars[c >> 4]);
            s.addChar(chars[c & 15]);
        }
        return s.toString();
    }

    public inline function getData() : BytesData {
        return b;
    }

    public static function alloc( length : Int ) : Bytes {
        return new Bytes(length,untyped __dollar__smake(length));
    }

    public static function ofString( s : String ) : Bytes {
        return new Bytes(s.length,untyped __dollar__ssub(s.__s,0,s.length));
    }

    public static function ofData( b : BytesData ) {
        return new Bytes(untyped __dollar__ssize(b),b);
    }

    public inline static function fastGet( b : BytesData, pos : Int ) : Int {
        return untyped __dollar__sget(b,pos);
    }

}

#end
