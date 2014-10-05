package nodejs.http;

/**
 * Wrapper class for the URL data that came from a request.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class URLData
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