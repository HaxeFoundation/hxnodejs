package nodejs;
import nodejs.events.EventEmitter;

/**
 * 
 */
class ChildProcessEventType
{
	/**
	 * This event is emitted after calling the .disconnect() method in the parent or in the child.
	 * After disconnecting it is no longer possible to send messages, and the .connected property is false.
	 */
	static public var Disconnect : String = "disconnect";
	
	/**
	 * Emitted when:
	 * The process could not be spawned, or
	 * The process could not be killed, or
	 * Sending a message to the child process failed for whatever reason.
	 * Note that the exit-event may or may not fire after an error has occured.
	 * If you are listening on both events to fire a function, remember to guard against calling your function twice.
	 * See also ChildProcess#kill() and ChildProcess#send().
	 */
	static public var Error : String = "error";
	
	/**
	 * code Number the exit code, if it exited normally.
	 * signal String the signal passed to kill the child process, if it was killed by the parent.
	 * This event is emitted when the stdio streams of a child process have all terminated. This is distinct from 'exit', since multiple processes might share the same stdio streams.
	 */
	static public var Close : String = "close";
	
	/**
	 * message Object a parsed JSON object or primitive value
	 * sendHandle Handle object a Socket or Server object
	 * Messages send by .send(message, [sendHandle]) are obtained using the message event.
	 */
	static public var Message : String = "message";
	
	/**
	 * code Number the exit code, if it exited normally.
	 * signal String the signal passed to kill the child process, if it was killed by the parent.This event is emitted after the child process ends. 
	 * If the process terminated normally, code is the final exit code of the process, otherwise null. 
	 * If the process terminated due to receipt of a signal, signal is the string name of the signal, otherwise null.
	 * Note that the child process stdio streams might still be open.
	 * Also, note that node establishes signal handlers for 'SIGINT' and 'SIGTERM', so it will not terminate due to receipt of those signals, it will exit.
	 * See waitpid(2).
	 */
	static public var Exit : String = "exit";
}

/**
 * Class that gives access to the 'child_process' module.
 */
@:native("(require('child_process'))")
extern class ChildProcessTool
{
	static var spawn		: Dynamic;//	(command, [args], [options])
	static var exec			: Dynamic;//	(command, [options], callback)
	static var execFile		: Dynamic;//	(file, [args], [options], [callback])
	static var fork			: Dynamic;//	(modulePath, [args], [options])
}

/**
 * ...
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class ChildProcess extends EventEmitter
{
	
	var stdin	: Dynamic;
	var stdout  : Dynamic;
	var stderr  : Dynamic;
	var pid     : Dynamic;
	
	/**
	 * Boolean Set to false after `.disconnect' is called
	 * If .connected is false, it is no longer possible to send messages.
	 */
	var connected : Bool;
	
	var kill		: Dynamic;//	([signal])
	var send		: Dynamic;//	(message, [sendHandle])
	
	/**
	 * Close the IPC channel between parent and child, allowing the child to exit gracefully once there are no other connections keeping it alive. After calling this method the .connected flag will be set to false in both the parent and child, and it is no longer possible to send messages.
	 * The 'disconnect' event will be emitted when there are no messages in the process of being received, most likely immediately.
	 * Note that you can also call process.disconnect() in the child process.
	 */
	function disconnect() : Void;
	
	
}