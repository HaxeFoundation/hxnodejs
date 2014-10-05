package nodejs;
import nodejs.NodeJS;
import nodejs.events.EventEmitter;
import nodejs.stream.Readable;
import nodejs.stream.Writable;

/**
 * Class that contains constants that define the events emitted by the Process class.
 */
class ProcessEventType
{
	/**
	 * Emitted when the process is about to exit. 
	 * There is no way to prevent the exiting of the event loop at this point, and once all exit listeners have finished running the process will exit.
	 * Therefore you must only perform synchronous operations in this handler. 
	 * This is a good hook to perform checks on the module's state (like for unit tests). 
	 * The callback takes one argument, the code the process is exiting with.
	 */
	static public var Exit 		: String = "exit";
	
	/**
	 * Emitted when an exception bubbles all the way back to the event loop.
	 * If a listener is added for this exception, the default action (which is to print a stack trace and exit) will not occur.
	 */
	static public var Exception : String = "uncaughtException";
}

/**
 * ...
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class Process extends EventEmitter
{
		
	/**
	 * An array containing the command line arguments. The first element will be 'node', the second element will be the name of the JavaScript file. 
	 * The next elements will be any additional command line arguments.
	 * E.g:
	 * $ node process-2.js one two=three four
	 * 0: node
	 * 1: /Users/mjr/work/node/process-2.js
	 * 2: one
	 * 3: two=three
	 * 4: four
	 */
	var argv : Array<String>;
	
	
	/**
	 * Getter/setter to set what is displayed in 'ps'.
	 * When used as a setter, the maximum length is platform-specific and probably short.
	 * On Linux and OS X, it's limited to the size of the binary name plus the length of the command line arguments because it overwrites the argv memory.
	 * v0.8 allowed for longer process title strings by also overwriting the environ memory but that was potentially insecure/confusing in some (rather obscure) cases.
	 */
	var title : String;
	
	/**
	 * The PID of the process.
	 */
	var pid : Int;
		
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Gets the group identity of the process. (See getgid(2).) This is the numerical group id, not the group name. 
	 * @return
	 */
	function getgid():Int;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Sets the group identity of the process. (See setgid(2).) This accepts either a numerical ID or a groupname string. 
	 * If a groupname is specified, this method blocks while resolving it to a numerical ID.
	 * @param	v
	 */
	function setgid(v:Int):Void;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Gets the user identity of the process. (See getuid(2).) This is the numerical userid, not the username.
	 * @return
	 */
	function getuid():Int;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Returns an array with the supplementary group IDs. POSIX leaves it unspecified if the effective group ID is included but node.js ensures it always is.
	 * @return
	 */
	function getgroups():Array<Dynamic>;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Sets the supplementary group IDs. This is a privileged operation, meaning you need to be root or have the CAP_SETGID capability.
	 * The list can contain group IDs, group names or both.
	 * @param	v
	 */
	function setgroups(v:Array<Dynamic>):Void;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Reads /etc/group and initializes the group access list, using all groups of which the user is a member. This is a privileged operation, meaning you need to be root or have the CAP_SETGID capability.
	 * user is a user name or user ID. extra_group is a group name or group ID.
	 * Some care needs to be taken when dropping privileges. 
	 */
	function initgroups(p_user:String,p_extra_group:Int):Void;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Sets the user identity of the process. (See setuid(2).) This accepts either a numerical ID or a username string.
	 * If a groupname is specified, this method blocks while resolving it to a numerical ID.
	 * @param	v
	 */
	function setuid(v:Int):Void;
	
	/**
	 * A Writable Stream to stdout.
	 */
	var stdout : Writable;
	
	/**
	 * A Readable Stream for stdin.
	 */
	var stdin : Readable;
	
	/**
	 * A writable stream to stderr.
	 * process.stderr and process.stdout are unlike other streams in Node in that writes to them are usually blocking.
	 */
	var stderr:Writable;
	
	/**
	 * A compiled-in property that exposes NODE_VERSION.
	 */
	var version : String;
	
	/**
	 * A property exposing version strings of node and its dependencies.
	 */
	var versions : Dynamic;
	
	/**
	 * This is the absolute pathname of the executable that started the process.
	 */
	var execPath : Dynamic;
	
	/**
	 * This is the set of node-specific command line options from the executable that started the process. 
	 * These options do not show up in process.argv, and do not include the node executable, the name of the script, or any options following the script name. 
	 * These options are useful in order to spawn child processes with the same execution environment as the parent.
	 */
	var execArgv : Array<String>;
	
	/**
	 * Ends the process with the specified code. If omitted, exit uses the 'success' code 0.
	 * @param	p_code
	 */
	function exit(p_code:Int):Void;
	
	/**
	 * This causes node to emit an abort. This will cause node to exit and generate a core file.
	 */
	function abort():Void;
	
	/**
	 * Returns the current working directory of the process.
	 */
	function cwd():Void;
	
	/**
	 * An object containing the user environment. See environ(7).
	 */
	var env : Dynamic;
	
	/**
	 * What processor architecture you're running on: 'arm', 'ia32', or 'x64'.
	 */
	var arch : String;
	
	/**
	 * What platform you're running on: 'darwin', 'freebsd', 'linux', 'sunos' or 'win32'
	 */
	var platform : String;
	
	/**
	 * On the next loop around the event loop call this callback. 
	 * This is not a simple alias to setTimeout(fn, 0), it's much more efficient. 
	 * It typically runs before any other I/O events fire, but there are some exceptions. 
	 */
	function nextTick(p_callback : Void->Void):Void;
	
	
	/**
	 * Callbacks passed to process.nextTick will usually be called at the end of the current flow of execution, 
	 * and are thus approximately as fast as calling a function synchronously. 
	 * Left unchecked, this would starve the event loop, preventing any I/O from occurring.
	 */
	var maxTickDepth : Int;
	
	/**
	 * Number of seconds Node has been running.
	 * @return
	 */
	function uptime():Int;
	
	/**
	 * Returns the current high-resolution real time in a [seconds, nanoseconds] tuple Array. 
	 * It is relative to an arbitrary time in the past. It is not related to the time of day and therefore not subject to clock drift. 
	 * The primary use is for measuring performance between intervals.
	 * You may pass in the result of a previous call to process.hrtime() to get a diff reading, useful for benchmarks and measuring intervals:
	 * @return
	 */
	function hrtime():Int;
	
	/**
	 * An Object containing the JavaScript representation of the configure options that were used to compile the current node executable. 
	 * This is the same as the "config.gypi" file that was produced when running the ./configure script.
	 */
	var config : Dynamic;
		
	/**
	 * Send a signal to a process. pid is the process id and signal is the string describing the signal to send. Signal names are strings like 'SIGINT' or 'SIGHUP'. 
	 * If omitted, the signal will be 'SIGTERM'. See Signal Events and kill(2) for more information.
	 * Will throw an error if target does not exist, and as a special case, a signal of 0 can be used to test for the existence of a process.
	 * Note that just because the name of this function is process.kill, it is really just a signal sender, like the kill system call. The signal sent may do something other than kill the target process.
	 * @param	p_pid
	 * @param	p_signal
	 */
	@:overload(function(p_id:Int):Void{})
	function kill(p_pid:Int, p_signal:String):Void;
	
	/**
	 * Returns an object describing the memory usage of the Node process measured in bytes. 
	 */
	function memoryUsage():Dynamic;
	
}
