package nodejs.http;
import js.Error;
import nodejs.http.MultipartForm.MultipartForm;
import nodejs.http.MultipartForm.MultipartFormOption;
import nodejs.NodeJS;


/**
 * Wrapper class for the functionalities of the 'url' package. Also includes features of 'querystring' and 'multiparty' for multipart content processing.
 * Watch for dependencies!
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
class URL
{
	static private var url(get_url, null) : Dynamic;
	static private function get_url():Dynamic { return m_url == null ? (m_url = NodeJS.require("url")) : m_url; }
	static private var m_url : Dynamic;
	
	static private var qs(get_qs, null) : Dynamic;
	static private function get_qs():Dynamic { return m_qs == null ? (m_qs = NodeJS.require("querystring")) : m_qs; }
	static private var m_qs : Dynamic;
	
	static private var mp(get_mp, null) : Dynamic;
	static private function get_mp():Dynamic { return m_mp == null ? (m_mp = NodeJS.require("multiparty")) : m_mp; }
	static private var m_mp : Dynamic;
	
	
	/**
	 * Parse the string and extract URLData from it.
	 * @param	p_url
	 * @return
	 */
	static public function Parse(p_url:String):URLData
	{
		var d : URLData = url.parse(p_url);
		return d;
	}
	
	
	/**
	 * Deserialize a query string to an object. Optionally override the default separator ('&') and assignment ('=') characters.
	 * MaxKeys is equal to 1000 by default, it'll be used to limit processed keys. Set it to 0 to remove key count limitation.
	 * @param	p_query
	 * @return
	 */
	static public function ParseQuery(p_query : String,p_separator:String="&",p_assigment:String="=",p_max_keys:Int=1000):Dynamic
	{
		if (p_query == null) return { };
		if (p_query == "")   return { };
		return qs.parse(p_query, p_separator, p_assigment, { maxKeys: p_max_keys } );
	}
	
	/**
	 * Serialize an object to a query string. Optionally override the default separator ('&') and assignment ('=') characters.
	 * @param	p_target
	 * @param	p_separator
	 * @param	p_assigment
	 * @return
	 */
	static public function ToQuery(p_target : Dynamic, p_separator:String = "&", p_assigment:String = "="):String
	{
		if (p_target == null) return "null";
		return qs.stringify(p_target, p_separator, p_assigment);
	}
	
	/**
	 * 
	 * @param	p_request
	 * @param	p_callback
	 * @param	p_options
	 * @return
	 */
	static public function ParseMultipart(p_request : IncomingMessage,p_callback: String -> Dynamic -> Dynamic -> Void=null,p_options : MultipartFormOption=null):MultipartForm
	{		
		var opt 		: MultipartFormOption 	= p_options == null ? (cast { } ) : p_options;		
		var multipart 	: Dynamic 				= mp;
		var options 	: Dynamic 				= opt;
		var f : MultipartForm = untyped __js__ ("new multipart.Form(opt)");		
		
		if (p_callback == null)
		{
			try
			{				
				f.parse(p_request); 
			}
			catch (e:Error) { trace("URL> " + e+"\n\t"+e.stack); }
		}
		else
		{
			try
			{				
				f.parse(p_request,p_callback); 
			}
			catch (e:Dynamic) { trace("!!! " + e); }
		}
		return f;
	}
	
	/**
	 * 
	 * @param	p_from
	 * @param	p_to
	 * @return
	 */
	static public function Resolve(p_from:String,p_to:String):String
	{		
		return url.resolve(p_from, p_to);
	}
	
	
}