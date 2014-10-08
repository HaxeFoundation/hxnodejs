package js.node;

/**
	For printing to stdout and stderr.

	Similar to the console object functions provided by most web browsers, here the output is sent to stdout or stderr.

	The console functions are synchronous when the destination is a terminal or a file (to avoid lost messages in case of premature exit
	and asynchronous  when it's a pipe (to avoid blocking for long periods of time).
**/
@:native("console")
extern class Console {
	/**
		Prints to stdout with newline. This function can take multiple arguments in a printf()-like way.
		Example: console.log('count: %d', count);
		If formatting elements are not found in the first string then `Util.inspect` is used on each argument.
		See `Util.format` for more information.
	**/
	@:overload(function(args:haxe.Rest<Dynamic>):Void {})
	static function log(data:String, args:haxe.Rest<Dynamic>):Void;

	/**
		Same as `log`.
	**/
	@:overload(function(args:haxe.Rest<Dynamic>):Void {})
	static function info(data:String, args:haxe.Rest<Dynamic>):Void;

	/**
		Same as `log` but prints to stderr.
	**/
	@:overload(function(args:haxe.Rest<Dynamic>):Void {})
	static function error(data:String, args:haxe.Rest<Dynamic>):Void;

	/**
		Same as `error`.
	**/
	@:overload(function(args:haxe.Rest<Dynamic>):Void {})
	static function warn(data:String, args:haxe.Rest<Dynamic>):Void;

	/**
		Uses util.inspect on obj and prints resulting string to stdout.
	**/
	static function dir(obj:Dynamic):Void;

	/**
		Mark a time with `label`.
		Finish with `timeEnd`
	**/
	static function time(label:String):Void;

	/**
		Finish timer marked with `label`, record output.
	**/
	static function timeEnd(label:String):Void;

	/**
		Print to stderr 'Trace :', followed by the formatted message and stack trace to the current position.
	**/
	@:overload(function(args:haxe.Rest<Dynamic>):Void {})
	static function trace(message:String, args:haxe.Rest<Dynamic>):Void;

	/**
		Similar to `Assert.ok`, but the error message is formatted as `Util.format(message...)`.
	**/
	@:overload(function(value:Bool, args:haxe.Rest<Dynamic>):Void {})
	@:overload(function(value:Bool, message:String, args:haxe.Rest<Dynamic>):Void {})
	static function assert(value:Bool):Void;
}
