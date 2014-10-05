package js.node.http;
import js.Error;
import js.node.http.MultipartForm.MultipartForm;
import js.node.http.MultipartForm.MultipartFormOption;
import js.node.NodeJS;



/**
 * Wrapper class for the functionalities of the 'url' package. Also includes features of 'querystring' and 'multiparty' for multipart content processing.
 * Watch for dependencies!
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
class URL
{
	static private var m_url(get_m_url, null) : Dynamic;
	static private function get_m_url():Dynamic { return __url == null ? (__url = NodeJS.require("url")) : __url; }
	static private var __url : Dynamic;
	
	static private var qs(get_qs, null) : Dynamic;
	static private function get_qs():Dynamic { return m_qs == null ? (m_qs = NodeJS.require("querystring")) : m_qs; }
	static private var m_qs : Dynamic;
	
	static private var mp(get_mp, null) : Dynamic;
	static private function get_mp():Dynamic { return m_mp == null ? (m_mp = NodeJS.require("multiparty")) : m_mp; }
	static private var m_mp : Dynamic;
	
	
	/**
	 * Parse the string and extract URLData from it.
	 * @param	url
	 * @return
	 */
	static public function Parse(url:String):URLData
	{
		var d : URLData = m_url.parse(url);
		return d;
	}
	
	
	/**
	 * Deserialize a query string to an object. Optionally override the default separator ('&') and assignment ('=') characters.
	 * MaxKeys is equal to 1000 by default, it'll be used to limit processed keys. Set it to 0 to remove key count limitation.
	 * @param	query
	 * @return
	 */
	static public function ParseQuery(query : String,separator:String="&",assigment:String="=",max_keys:Int=1000):Dynamic
	{
		if (query == null) return { };
		if (query == "")   return { };
		return qs.parse(query, separator, assigment, { maxKeys: max_keys } );
	}
	
	/**
	 * Serialize an object to a query string. Optionally override the default separator ('&') and assignment ('=') characters.
	 * @param	target
	 * @param	separator
	 * @param	assigment
	 * @return
	 */
	static public function ToQuery(target : Dynamic, separator:String = "&", assigment:String = "="):String
	{
		if (target == null) return "null";
		return qs.stringify(target, separator, assigment);
	}
	
	/**
	 * 
	 * @param	request
	 * @param	callback
	 * @param	options
	 * @return
	 */
	static public function ParseMultipart(request : IncomingMessage,callback: String -> Dynamic -> Dynamic -> Void=null,options : MultipartFormOption=null):MultipartForm
	{		
		var opt 		: MultipartFormOption 	= options == null ? (cast { } ) : options;		
		var multipart 	: Dynamic 				= mp;
		var options 	: Dynamic 				= opt;
		var f : MultipartForm = untyped __js__ ("new multipart.Form(opt)");		
		
		if (callback == null)
		{
			try
			{				
				f.parse(request); 
			}
			catch (e:Error) { trace("URL> " + e+"\n\t"+e.stack); }
		}
		else
		{
			try
			{				
				f.parse(request,callback); 
			}
			catch (e:Dynamic) { trace("!!! " + e); }
		}
		return f;
	}
	
	/**
	 * 
	 * @param	from
	 * @param	to
	 * @return
	 */
	static public function Resolve(from:String,to:String):String
	{		
		return m_url.resolve(from, to);
	}
	
	
}