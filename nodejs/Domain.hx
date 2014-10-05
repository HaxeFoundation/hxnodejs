package nodejs;
import js.Error;
import nodejs.events.EventEmitter;

/**
 * Any time an Error object is routed through a domain, a few extra fields are added to it.
 */
extern class DomainError extends Error
{
	/**
	 * The domain that first handled the error.
	 */
	var domain 			: Domain;			
	/**
	 * The event emitter that emitted an 'error' event with the error object.
	 */
	var domainEmitter 	: EventEmitter;		
	/**
	 * The callback function which was bound to the domain, and passed an error as its first argument.
	 */	
	var domainBound 	: Dynamic; 			
	/**
	 * A boolean indicating whether the error was thrown, emitted, or passed to a bound callback function.
	 */
	var domainThrown 	: Bool; 			
}

/**
 * Domains provide a way to handle multiple different IO operations as a single group.
 * If any of the event emitters or callbacks registered to a domain emit an error event, or throw an error, then the domain object will be notified,
 * rather than losing the context of the error in the process.on('uncaughtException') handler, or causing the program to exit immediately with an error code.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class Domain extends EventEmitter
{
	var members	    :Dynamic;
	var run			:Dynamic;	//(fn)	
	var add			:Dynamic;	//(emitter)
	var remove		:Dynamic;	//(emitter)
	var bind		:Dynamic;	//(callback)	
	var intercept	:Dynamic;	//(callback)	
	var enter		:Dynamic;	//()
	var exit		:Dynamic;	//()
	var dispose		:Dynamic;	//()
}