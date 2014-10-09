package js.node;

/**
	This module has utilities for URL resolution and parsing.
**/
@:jsRequire("url")
extern class Url
{
	/**
	 * Take a URL string, and return an object.
	 * Pass true as the second argument to also parse the query string using the querystring module. Defaults to false.
	 * Pass true as the third argument to treat //foo/bar as { host: 'foo', pathname: '/bar' } rather than { pathname: '//foo/bar' }. Defaults to false.
	 * @param	urlStr
	 * @param	[parseQueryString]
	 * @param	[slashesDenoteHost]
	 * @return
	 */
	@:overload(function(urlStr:String):URLData { } )
	@:overload(function(urlStr:String, parseQueryString :Bool):URLData { } )
	static function parse(urlStr:String, parseQueryString :Bool, slashesDenoteHost:Bool): URLData;

	/**
	 * Take a parsed URL object, and return a formatted URL string.
	 *	href will be ignored.
	 *	protocol is treated the same with or without the trailing : (colon).
	 *	The protocols http, https, ftp, gopher, file will be postfixed with :// (colon-slash-slash).
	 *	All other protocols mailto, xmpp, aim, sftp, foo, etc will be postfixed with : (colon)
	 *	slashes set to true if the protocol requires :// (colon-slash-slash)
	 *	Only needs to be set for protocols not previously listed as requiring slashes, such as mongodb://localhost:8000/
	 *
	 *	-auth 		will be used if present.
	 *	-hostname 	will only be used if host is absent.
	 *	-port 		will only be used if host is absent.
	 *	-host 		will be used in place of hostname and port
	 *	-pathname 	is treated the same with or without the leading / (slash)
	 *	-search 	will be used in place of query
	 *	-query 		(object; see querystring) will only be used if search is absent.
	 *	-search 	is treated the same with or without the leading ? (question mark)
	 *	-hash 		is treated the same with or without the leading # (pound sign, anchor)
	 *
	 * @param	urlObj
	 * @return
	 */
	static function format(urlObj:URLData):String;

	/**
	 *Take a base URL, and a href URL, and resolve them as a browser would for an anchor tag.
	 * Examples:
	 *  url.resolve('/one/two/three', 'four')         // '/one/two/four'
	 *  url.resolve('http://example.com/', '/one')    // 'http://example.com/one'
	 *  url.resolve('http://example.com/one', '/two') // 'http://example.com/two'
	 * @param	from
	 * @param	to
	 * @return
	 */
	static function resolve(from:String, to:String):String;

}

/**
 * Wrapper class for the URL data that came from a request.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
typedef URLData =
{

	/**
	 * The full URL that was originally parsed. Both the protocol and host are lowercased.
	 * Example: 'http://user:pass@host.com:8080/p/a/t/h?query=string#hash'
	 */
	var href : String;

	/**
	 * The request protocol, lowercased.
	 * Example: 'http:'
	 */
	var protocol : String;

	/**
	 * The full lowercased host portion of the URL, including port information.
	 * Example: 'host.com:8080'
	 */
	var host: String;

	/**
	 * The authentication information portion of a URL.
	 * Example: 'user:pass'
	 */
	var auth : String;

	/**
	 * Just the lowercased hostname portion of the host.
	 * Example: 'host.com'
	 */
	var hostname :String;

	/**
	 * The port number portion of the host.
	 * Example: '8080'
	 */
	var port : String;

	/**
	 * The path section of the URL, that comes after the host and before the query, including the initial slash if present.
	 * Example: '/p/a/t/h'
	 */
	var pathname : String;

	/**
	 * The 'query string' portion of the URL, including the leading question mark.
	 * Example: '?query=string'
	 */
	var search : String;

	/**
	 * Concatenation of pathname and search.
	 * Example: '/p/a/t/h?query=string'
	 */
	var path : String;

	/**
	 * Either the 'params' portion of the query string, or a querystring - parsed object.
	 * Example: 'query=string' or {'query':'string'}
	 */
	var query : String;

	/**
	 * The 'fragment' portion of the URL including the pound - sign.
	 * Example: '#hash'
	 */
	var hash : String;

}