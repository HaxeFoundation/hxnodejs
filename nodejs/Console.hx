package nodejs;

/**
 * For printing to stdout and stderr. Similar to the console object functions provided by most web browsers, here the output is sent to stdout or stderr.
 * The console functions are synchronous when the destination is a terminal or a file (to avoid lost messages in case of premature exit) and asynchronous 
 * when it's a pipe (to avoid blocking for long periods of time).
 * That is, in the following example, stdout is non-blocking while stderr is blocking:
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("console")
extern class Console
{	
	/**
	 * Prints to stdout with newline. This function can take multiple arguments in a printf()-like way. Example:
	 * console.log('count: %d', count);
	 * If formatting elements are not found in the first string then util.inspect is used on each argument. See util.format() for more information.
	 * @param	msg
	 */
	@:overload(function(msg:String, ?a0:Dynamic, ?a1:Dynamic, ?a2:Dynamic, ?a3:Dynamic, ?a4:Dynamic, ?a5:Dynamic, ?a6:Dynamic, ?a7:Dynamic, ?a8:Dynamic, ?a9:Dynamic):Void { } )	
	static function log(msg:String):Void;
	
	/**
	 * Same as console.log.
	 * @param	msg
	 */
	@:overload(function(msg:String, ?a0:Dynamic, ?a1:Dynamic, ?a2:Dynamic, ?a3:Dynamic, ?a4:Dynamic, ?a5:Dynamic, ?a6:Dynamic, ?a7:Dynamic, ?a8:Dynamic, ?a9:Dynamic):Void { } )		
	static function info(msg:String):Void;
	
	/**
	 * Same as console.log but prints to stderr.
	 * @param	msg
	 */
	@:overload(function(msg:String, ?a0:Dynamic, ?a1:Dynamic, ?a2:Dynamic, ?a3:Dynamic, ?a4:Dynamic, ?a5:Dynamic, ?a6:Dynamic, ?a7:Dynamic, ?a8:Dynamic, ?a9:Dynamic):Void { } )		
	static function error(msg:String):Void;
	
	/**
	 * Same as console.error.
	 * @param	msg
	 */
	@:overload(function(msg:String, ?a0:Dynamic, ?a1:Dynamic, ?a2:Dynamic, ?a3:Dynamic, ?a4:Dynamic, ?a5:Dynamic, ?a6:Dynamic, ?a7:Dynamic, ?a8:Dynamic, ?a9:Dynamic):Void { } )		
	static function warn(msg:String):Void;
	
	/**
	 * Uses util.inspect on obj and prints resulting string to stdout.
	 * @param	msg
	 */
	static function dir(obj:Dynamic):Void;
		
	/**
	 * Mark a time. Finish with 'timeEnd'
	 * @param	label
	 */
	static function time(label:String):Void;
	
	/**
	 * Finish timer, record output. Example:
	 * @param	label
	 */
	static function timeEnd(label:String):Void;
	
	/**
	 * Print a stack trace to stderr of the current position.
	 * @param	label
	 */
	static function trace(label:String):Void;
	
	/**
	 * Same as assert.ok() where if the expression evaluates as false throw an AssertionError with message.
	 * @param	expression
	 * @param	[message]
	 */
	static function assert(expression :Bool, ? message:String):Void;
	
	
}