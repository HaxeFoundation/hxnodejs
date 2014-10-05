package nodejs.net;

/**
 * ...
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("require('net')")
extern class Net
{
	static var createServer			: Dynamic; //		([options], [connectionListener])
	
	static var connect				: Dynamic; //		(options, [connectionListener])	
	//static var connect				: Dynamic; //		(port, [host], [connectListener])
	//static var connect				: Dynamic; //		(path, [connectListener])
	
	static var createConnection		: Dynamic; //		(options, [connectionListener])
	//static var createConnection		: Dynamic; //		(port, [host], [connectListener])
	//static var createConnection		: Dynamic; //		(path, [connectListener])
	
	/**
	 * Tests if input is an IP address. Returns 0 for invalid strings, returns 4 for IP version 4 addresses, and returns 6 for IP version 6 addresses.
	 * @param	input
	 * @return
	 */
	static function isIP(input:String):Int;
	
	/**
	 * Returns true if input is a version 4 IP address, otherwise returns false.
	 */
	static function isIPv4(input : String) : Bool;
	
	/**
	 * Returns true if input is a version 6 IP address, otherwise returns false.
	 */
	static function isIPv6(input : String) : Bool;
	
}