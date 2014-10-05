package nodejs;

/**
 * In each module, the module free variable is a reference to the object representing the current module.
 * For convenience, module.exports is also accessible via the exports module-global. 
 * Module isn't actually a global but rather local to each module.
 *
 * http://nodejs.org/api/modules.html#modules_modules
 * 
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class Module
{

	/**
	 * The identifier for the module. Typically this is the fully resolved filename.
	 */
	var id :String;
	
	/**
	 * The fully resolved filename to the module.
	 */
	var filename :String;
	
	/**
	 * Whether or not the module is done loading, or is in the process of loading.
	 */
	var loaded : Bool;
	
	/**
	 * The module that required this one.
	 */
	var parent : Module;
	
	/**
	 * The module objects required by this one.
	 */
	var children : Array < Module>;
	
	/**
	 * The module.exports object is created by the Module system. 
	 * Sometimes this is not acceptable; many want their module to be an instance of some class.
	 * To do this assign the desired export object to module.exports. 
	 * Note that assigning the desired object to exports will simply rebind the local exports variable, which is probably not what you want to do.
	 */
	var exports : Dynamic;
	
	/**
	 * id String
	 * Return: Object module.exports from the resolved module
	 * The module.require method provides a way to load a module as if require() was called from the original module.
	 * Note that in order to do this, you must get a reference to the module object. Since require() returns the module.exports,
	 * and the module is typically only available within a specific module's code, it must be explicitly exported in order to be used.
	 * @param	id
	 * @return
	 */
	function require(id:String):Dynamic;
	
}