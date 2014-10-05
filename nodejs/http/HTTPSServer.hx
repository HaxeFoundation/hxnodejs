package nodejs.http;
import nodejs.NodeJS;
import js.html.ArrayBufferView;
import nodejs.events.EventEmitter;


/**
 * HTTPS Server EventEmitter. This class is used to create a TCP or UNIX server.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class HTTPSServer extends EventEmitter
{	
	var listen		: Dynamic;//		(port, [host], [backlog], [callback])
	//var listen		: Dynamic;//		(path, [callback])
	//var listen		: Dynamic;//		(handle, [callback])
	var close		: Dynamic;//		([callback])
	
}