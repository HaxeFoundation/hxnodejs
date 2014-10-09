package js.node;

@:jsRequire("punycode")
extern class Punycode {
    /**
        Converts a Punycode string of ASCII code points to a string of Unicode code points.
    **/
    static function decode(string:String):String;

    /**
        Converts a string of Unicode code points to a Punycode string of ASCII code points.
    **/
    static function encode(string:String):String;

    /**
        Converts a Punycode string representing a domain name to Unicode.

        Only the Punycoded parts of the domain name will be converted, i.e. it doesn't matter
        if you call it on a string that has already been converted to Unicode.
    **/
    static function toUnicode(domain:String):String;

    /**
        Converts a Unicode string representing a domain name to Punycode.

        Only the non-ASCII parts of the domain name will be converted, i.e. it doesn't matter
        if you call it with a domain that's already in ASCII.
    **/
    static function toASCII(domain:String):String;

    static var ucs2(default,null):PunycodeUcs2;

    /**
        The current Punycode.js version number.
    **/
    static var version(default,null):String;
}

extern class PunycodeUcs2 {
    /**
        Creates an array containing the decimal code points of each Unicode character in the string.
        While JavaScript uses UCS-2 internally, this function will convert a pair of surrogate halves (each of which
        UCS-2 exposes as separate characters) into a single code point, matching UTF-16.
    **/
    function decode(string:String):Array<Int>;

    /**
        Creates a string based on an array of decimal code points.
    **/
    function encode(codePoints:Array<Int>):String;
}
