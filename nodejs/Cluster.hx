package nodejs;
import nodejs.events.EventEmitter;

/**
 * 
 */
class ClusterEventType
{
	/**
	 * worker Worker object
	 * When a new worker is forked the cluster module will emit a 'fork' event. This can be used to log worker activity, and create your own timeout.
	 */
	static public var  Fork          : String = "fork";
	/**
	 * worker Worker object
	 * After forking a new worker, the worker should respond with an online message. 
	 * When the master receives an online message it will emit this event. 
	 * The difference between 'fork' and 'online' is that fork is emitted when the master forks a worker, and 'online' is emitted when the worker is running.
	 */
	static public var  Online        : String = "online";
	/**
	 * worker Worker object
	 * address Object
	 * After calling listen() from a worker, when the 'listening' event is emitted on the server, a listening event will also be emitted on cluster in the master.
	 * The event handler is executed with two arguments, the worker contains the worker object and the address object contains the following connection properties: address, port and addressType. This is very useful if the worker is listening on more than one address.
	 */
	static public var  Listening     : String = "listening";
	/**
	 * worker Worker object
	 * Emitted after the worker IPC channel has disconnected. 
	 * This can occur when a worker exits gracefully, is killed, or is disconnected manually (such as with worker.disconnect()).
	 * There may be a delay between the disconnect and exit events. 
	 * These events can be used to detect if the process is stuck in a cleanup or if there are long-living connections.
	 */
	static public var  Disconnect    : String = "disconnect";
	/**
	 * worker Worker object
	 * code Number the exit code, if it exited normally.
	 * signal String the name of the signal (eg. 'SIGHUP') that caused the process to be killed.
	 * When any of the workers die the cluster module will emit the 'exit' event.
	 * This can be used to restart the worker by calling .fork() again.
	 */
	static public var  Exit          : String = "exit";
	/**
	 * Emitted the first time that .setupMaster() is called.
	 */
	static public var  Setup         : String = "setup";
}


/**
 * A single instance of Node runs in a single thread. 
 * To take advantage of multi-core systems the user will sometimes want to launch a cluster of Node processes to handle the load.
 * The cluster module allows you to easily create child processes that all share server ports.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("require('cluster')")
extern class Cluster extends EventEmitter
{
	var settings		: Dynamic;
	var isMaster        : Dynamic;
	var isWorker        : Dynamic;
	var setupMaster		: Dynamic;				//([settings])
	var fork			: Dynamic;				//([env])
	var disconnect		: Dynamic;				//([callback])
	var worker          : Dynamic;
	var workers         : Dynamic;
	
}