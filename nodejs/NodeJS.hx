package nodejs;
import haxe.Json;
import nodejs.http.HTTP.HTTPAgent;



/**
 * Wrapper for the global context of nodejs.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
class NodeJS
{
	
	/**
	 * The name of the directory that the currently executing script resides in.
	 */
	static public var dirname(get_dirname, never):String;
	static private function get_dirname():String { return untyped __js__("__dirname"); }
	
	/**
	 * The filename of the code being executed. This is the resolved absolute path of this code file.
	 * For a main program this is not necessarily the same filename used in the command line.
	 * The value inside a module is the path to that module file.
	 */
	static public var filename(get_filename, never):String;
	static private function get_filename():String { return untyped __js__("__filename"); }

	/**
	 * Fetches a library and returns the reference to it.
	 * @param	p_lib
	 * @return
	 */
	static public function require(p_lib : String):Dynamic { return untyped __js__("require(p_lib)"); }	
	
	/**
	 * The process object is a global object and can be accessed from anywhere. It is an instance of EventEmitter.
	 */
	static public var process(get_process, null):Process;
	static private function get_process():Process {  return untyped __js__("process"); }	
	
	/**
	 * Run callback cb after at least ms milliseconds. The actual delay depends on external factors like OS timer granularity and system load.
	 * The timeout must be in the range of 1-2,147,483,647 inclusive. If the value is outside that range, it's changed to 1 millisecond. 
	 * Broadly speaking, a timer cannot span more than 24.8 days.
	 * Returns an opaque value that represents the timer.
	 * @param	cb
	 * @param	ms
	 * @return
	 */
	static public function setTimeout(cb : Void->Void, ms : Int) : Dynamic { return untyped __js__("setTimeout(cb,ms)"); }
	
	/**
	 * Stop a timer that was previously created with setTimeout(). The callback will not execute.
	 * @param	t
	 */
	static public function clearTimeout(t : Dynamic) : Void { return untyped __js__("clearTimeout(t)"); }
	
	/**
	 * Run callback cb repeatedly every ms milliseconds. Note that the actual interval may vary, depending on external factors like OS timer granularity and system load.
	 * It's never less than ms but it may be longer.
	 * The interval must be in the range of 1-2,147,483,647 inclusive. If the value is outside that range, it's changed to 1 millisecond.
	 * Broadly speaking, a timer cannot span more than 24.8 days.
	 * Returns an opaque value that represents the timer.
	 * @param	cb
	 * @param	ms
	 * @return
	 */
	static public function setInterval(cb : Void->Void, ms : Int) : Dynamic { return untyped __js__("setInterval(cb,ms)"); }
	
	/**
	 * Stop a timer that was previously created with setInterval(). The callback will not execute.
	 * The timer functions are global variables. See the timers section.
	 * @param	t
	 */
	static public function clearInterval(t : Dynamic) : Void { return untyped __js__("clearInterval(t)"); }
	
	/**
	 * Tests if value is truthy.
	 * @param	value
	 * @param	message
	 */
	static public function assert(value:Dynamic, message:String) : Void { untyped __js__("require('assert')(value,message)"); }
	
	/**
	 * In browsers, the top-level scope is the global scope. 
	 * That means that in browsers if you're in the global scope var something will define a global variable. 
	 * In Node this is different. The top-level scope is not the global scope; var something inside a Node module will be local to that module.
	 */
	static public var global(get_global, null):Dynamic;
	static private function get_global():Dynamic {  return untyped __js__("global"); }
	
	/**
	 * Use the internal require() machinery to look up the location of a module, but rather than loading the module, just return the resolved filename.
	 * @return
	 */
	static public function resolve():String {  return untyped __js__("require.resolve()"); }
	
	/**
	 * Modules are cached in this object when they are required. By deleting a key value from this object, the next require will reload the module.
	 */
	static public var cache(get_cache, null):Dynamic;
	static private function get_cache():Dynamic {  return untyped __js__("require.cache"); }
	
	/**
	 * Instruct require on how to handle certain file extensions.
	 * Process files with the extension .sjs as .js:
	 * Deprecated In the past, this list has been used to load non-JavaScript modules into Node by compiling them on-demand. However,
	 * in practice, there are much better ways to do this, such as loading modules via some other Node program, or compiling them to JavaScript ahead of time.
	 * Since the Module system is locked, this feature will probably never go away. However, it may have subtle bugs and complexities that are best left untouched.
	 */
	static public var extensions(get_extensions, null):Dynamic;
	static private function get_extensions():Dynamic {  return untyped __js__("require.extensions"); }
	
	/**
	 * A reference to the current module. In particular module.exports is used for defining what a module exports and makes available through require().
	 * module isn't actually a global but rather local to each module.
	 */
	static public var module(get_module, null):Module;
	static private function get_module():Module {  return untyped __js__("module"); }
	
	/**
	 * A reference to the module.exports that is shorter to type.
	 * See module system documentation for details on when to use exports and when to use module.exports.
	 * exports isn't actually a global but rather local to each module.
	 */
	static public var exports(get_exports, null):Dynamic;
	static private function get_exports():Dynamic {  return untyped __js__("exports"); }
	
	/**
	 * Returns a new Domain object.
	 * See: http://nodejs.org/api/domain.html#domain_domain_create
	 */
	static public var domain(get_domain, null):Domain;
	static private function get_domain():Domain {  return untyped __js__("domain.create()"); }
	
	/**
	 * A Read-Eval-Print-Loop (REPL) is available both as a standalone program and easily includable in other programs. The REPL provides a way to interactively run JavaScript and see the results. It can be used for debugging, testing, or just trying things out.
	 */
	static public var repl(get_repl, null):REPL;
	static private function get_repl():REPL {  return untyped __js__("require('repl')"); }
	
	/*
	unref()
	ref()
	setImmediate(callback, [arg], [...])
	clearImmediate(immediateObject)
	//*/
	
}