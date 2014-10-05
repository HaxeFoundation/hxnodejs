package nodejs;

/**
 * This module is used for writing unit tests for your applications, you can access it with require('assert').
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('assert'))")
extern class Assert
{
	/**
	 * Throws an exception that displays the values for actual and expected separated by the provided operator.
	 * @param	actual
	 * @param	expected
	 * @param	message
	 * @param	operator
	 */
	static function fail(actual:Dynamic, expected:Dynamic, message:String, operator:Dynamic):Void;		
	
	/**
	 * Tests if value is truthy, it is equivalent to assert.equal(true, !!value, message);
	 * @param	value
	 * @param	message
	 */
	@:overload(function(value:Bool):Void{})
	static function ok(value:Bool, message:String):Void;
	
	/**
	 * Tests shallow, coercive equality with the equal comparison operator ( == ).
	 * @param	actual
	 * @param	expected
	 * @param	message
	 */	
	@:overload(function (actual:Dynamic, expected:Dynamic):Void{})
	static function equal(actual:Dynamic, expected:Dynamic, message:String):Void;
	
	/**
	 * Tests shallow, coercive non-equality with the not equal comparison operator ( != ).
	 * @param	actual
	 * @param	expected
	 * @param	message
	 */
	@:overload(function(actual:Dynamic, expected:Dynamic):Void{})
	static function notEqual(actual:Dynamic, expected:Dynamic, message:String):Void;
	
	/**
	 * Tests for deep equality.
	 * @param	actual
	 * @param	expected
	 * @param	message
	 */
	@:overload(function(actual:Dynamic, expected:Dynamic):Void{})
	static function deepEqual(actual:Dynamic, expected:Dynamic, message:String):Void;
	
	/**
	 * Tests for any deep inequality.
	 * @param	actual
	 * @param	expected
	 * @param	message
	 */
	@:overload(function(actual:Dynamic, expected:Dynamic):Void{})
	static function notDeepEqual(actual:Dynamic, expected:Dynamic, message:String):Void;
	
	/**
	 * Tests strict equality, as determined by the strict equality operator ( === )
	 * @param	actual
	 * @param	expected
	 * @param	message
	 */
	@:overload(function(actual:Dynamic, expected:Dynamic):Void{})
	static function strictEqual(actual:Dynamic, expected:Dynamic, message:String):Void;
	
	/**
	 * Tests strict non-equality, as determined by the strict not equal operator ( !== )
	 * @param	actual
	 * @param	expected
	 * @param	message
	 */
	@:overload(function(actual:Dynamic, expected:Dynamic):Void{})
	static function notStrictEqual(actual:Dynamic, expected:Dynamic, message:String):Void;
	
	/**
	 * Expects block to throw an error. error can be constructor, regexp or validation function.
	 * @param	block
	 * @param	error
	 * @param	message
	 */
	@:overload(function(block:Void->Void, error:Dynamic):Void{})
	static function throws(block:Void->Void, error:Dynamic, message:String):Void;
	
	/**
	 * Expects block not to throw an error, see assert.throws for details.
	 * @param	block
	 * @param	message
	 */
	@:overload(function(block:Void->Void):Void{})
	static function doesNotThrow(block:Void->Void, message:String):Void;
	
	/**
	 * Tests if value is not a false value, throws if it is a true value. Useful when testing the first argument, error in callbacks.
	 * @param	value
	 */
	static function ifError(value:Bool):Void;
	//*/
	
}