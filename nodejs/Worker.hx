package nodejs;
import nodejs.events.EventEmitter;

/**
 * 
 */
class WorkerEventType
{
	/**
	 * 
	 */
	static public var  Message       : String = "message";
	
	/**
	 * 
	 */
	static public var  Online        : String = "online";
	
	/**
	 * 
	 */
	static public var  Listening     : String = "listening";
	
	/**
	 * 
	 */
	static public var  Disconnect    : String = "disconnect";
	
	/**
	 * 
	 */
	static public var  Exit          : String = "exit";
	
	/**
	 * 
	 */
	static public var  Error         : String = "error";
}


/**
 * A Worker object contains all public information and method about a worker. In the master it can be obtained using cluster.workers. In a worker it can be obtained using cluster.worker.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class Worker extends EventEmitter
{
	var id			 : Dynamic;
	var process      : Dynamic;
	var suicide      : Dynamic;
	var send		 : Dynamic;//		(message, [sendHandle])
	var kill		 : Dynamic;//		([signal='SIGTERM'])
	var disconnect	 : Dynamic;	//	()
	
}