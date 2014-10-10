package js.node;

/**
	This module provides utilities for dealing with query strings.
**/
@:jsRequire("querystring")
extern class Querystring {
	/**
		Serialize an object to a query string.
		Optionally override the default separator ('&') and assignment ('=') characters.
	**/
	static function stringify(obj:{}, ?sep:String, ?eq:String):String;

	/**
		Deserialize a query string to an object.
		Optionally override the default separator ('&') and assignment ('=') characters.

		Options object may contain `maxKeys` property (equal to 1000 by default), it'll be used to limit processed keys.
		Set it to 0 to remove key count limitation.
	**/
	@:overload(function(str:String, ?options:{maxKeys:Int}):Dynamic<String> {})
	@:overload(function(str:String, sep:String, ?options:{maxKeys:Int}):Dynamic<String> {})
	static function parse(str:String, ?sep:String, ?eq:String):Dynamic<String>;

	/**
		The escape function used by `Querystring.stringify`, provided so that it could be overridden if necessary.
	**/
	static dynamic function escape(obj:Dynamic):String;

	/**
		The unescape function used by `Querystring.parse`, provided so that it could be overridden if necessary.
	**/
	static dynamic function unescape(str:String):Dynamic;
}
