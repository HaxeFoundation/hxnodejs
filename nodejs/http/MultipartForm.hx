package nodejs.http;
import nodejs.events.EventEmitter;

/**
 * Enumeration of all event types of MultipartForm.
 */
class MultipartFormEventType
{
	/**
	 * Emitted when a part is encountered in the request. part is a ReadableStream. It also has the following properties:
	 * headers 		- the headers for this part. For example, you may be interested in content-type.
	 * name 		- the field name for this part
	 * filename 	- only if the part is an incoming file
	 * byteOffset 	- the byte offset of this part in the request body
	 * byteCount 	- assuming that this is the last part in the request, this is the size of this part in bytes. You could use this, for example, to set the Content-Length header if uploading to S3. If the part had a Content-Length header then that value is used here instead.
	 */
	static public var Part :String = "part";
	
	/**
	 * Emitted when the request is aborted. This event will be followed shortly by an error event. In practice you do not need to handle this event.
	 */
	static public var Aborted : String = "aborted";
	
	/**
	 * Unless you supply a callback to form.parse, you definitely want to handle this event. Otherwise your server will crash when users submit bogus multipart requests!
	 * Only one 'error' event can ever be emitted, and if an 'error' event is emitted, then 'close' will not be emitted.
	 */
	static public var Error 	 : String = "error";
	
	/**
	 * 
	 */
	static public var Progress 	 : String = "progress";
	
	/**
	 * name - field name
	 * value - string field value
	 */
	static public var Field		 : String = "field";
	
	/**
	 * By default multiparty will not touch your hard drive. But if you add this listener, multiparty automatically sets form.autoFiles to true and will stream uploads to disk for you.
	 * The max bytes accepted per request can be specified with maxFilesSize.
     * name 			- the field name for this file
     * file 			- an object with these properties:
     * fieldName 		- same as name - the field name for this file
     * originalFilename - the filename that the user reports for the file
     * path 			- the absolute path of the uploaded file on disk
     * headers 			- the HTTP headers that were sent along with this file
     * size 			- size of the file in bytes
     * If you set the form.hash option, then file will also contain a hash property which is the checksum of the file.
	 */
	static public var File		 : String = "file";
	
	/**
	 * Emitted after all parts have been parsed and emitted. Not emitted if an error event is emitted. This is typically when you would send your response.
	 */
	static public var Close		 : String = "close";
	
	
	
}

/**
 * Describes a Form file descriptor.
 */
extern class FormFile
{
	/**
	 * 
	 */
	var fieldName : String;
	
	/**
	 * 
	 */
	var originalFilename : String;
	
	/**
	 * 
	 */
	var path : String;
	
	/**
	 * 
	 */
	var headers : Dynamic;
	
	/**
	 * 
	 */
	var size : Int;
	
	/**
	 * 
	 */
	var hash : String;
	
}

/**
 * 
 */
extern class MultipartFormOption
{
	/**
	 * sets encoding for the incoming form fields. Defaults to utf8.
	 */
	var encoding 			:String;
	
	/**
	 * Limits the amount of memory a field (not a file) can allocate in bytes. If this value is exceeded, an error event is emitted. The default size is 2MB.
	 */
	var maxFieldsSize 		:Int;
	
	/**
	 * Limits the number of fields that will be parsed before emitting an error event. A file counts as a field in this case. Defaults to 1000.
	 */
	var maxFields 			:Int;
	
	/**
	 * Only relevant when autoFiles is true. Limits the total bytes accepted for all files combined. If this value is exceeded, an error event is emitted. The default is Infinity.
	 */
	var maxFilesSize 		:Int;
	
	/**
	 * Enables field events. This is automatically set to true if you add a field listener.
	 */
	var autoFields 			:Bool;
	
	/**
	 * Enables file events. This is automatically set to true if you add a file listener.
	 */
	var autoFiles 			:Bool;
	
	/**
	 *  Only relevant when autoFiles is true. The directory for placing file uploads in. You can move them later using fs.rename(). Defaults to os.tmpDir().
	 */
	var uploadDir 			:String;
	
	/**
	 *  Only relevant when autoFiles is true. If you want checksums calculated for incoming files, set this to either sha1 or md5. Defaults to off.
	 */
	var hash 				:String;
}

/**
 * multiparty
 * 
 * Parse http requests with content-type multipart/form-data, also known as file uploads.
 * See also busboy - a faster alternative which may be worth looking into.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("require('multiparty')")
extern class MultipartForm extends EventEmitter
{	
	
	/**
	 * Creates a new form.
	 * @param	p_options
	 */
	@:overload(function():Void { } )	
	function new(p_options:MultipartFormOption):Void;
	/**
	 * Parses an incoming node.js request containing form data. If cb is provided, autoFields and autoFiles are set to true and all fields and files are collected and passed to the callback:
	 */
	@:overload(function(request:IncomingMessage):Void{ })
	function parse(request : IncomingMessage, callback : String -> Dynamic -> Dynamic -> Void) : Void;
	
	/**
	 * The amount of bytes received for this form so far.
	 */
	var bytesReceived : Int;
	
	/**
	 * The expected number of bytes in this form.
	 */
	var bytesExpected : Int;
	
}