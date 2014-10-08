package js.node.http;

/**
 * HTTPS Server EventEmitter. This class is used to create a TCP or UNIX server.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class HttpsServer extends js.node.events.EventEmitter {	
	
	var listen		: Dynamic;//		(port, [host], [backlog], [callback])
	//var listen		: Dynamic;//		(path, [callback])
	//var listen		: Dynamic;//		(handle, [callback])
	var close		: Dynamic;//		([callback])
	
}