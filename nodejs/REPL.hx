package nodejs;
import nodejs.events.EventEmitter;
import nodejs.stream.Readable;
import nodejs.stream.Writable;

/**
 * Enumeration for REPL event strings.
 */
class REPLEventType
{
	/**
	 * Emitted when the user exits the REPL in any of the defined ways. Namely, typing .exit at the repl, pressing Ctrl+C twice to signal SIGINT, or pressing Ctrl+D to signal "end" on the input stream.
	 */
	static public var Exit : String = "exit";
}

/**
 * A Read-Eval-Print-Loop (REPL) is available both as a standalone program and easily includable in other programs. The REPL provides a way to interactively run JavaScript and see the results. It can be used for debugging, testing, or just trying things out.
 * By executing node without any arguments from the command-line you will be dropped into the REPL. It has simplistic emacs line-editing.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class REPL extends EventEmitter
{
	
	/**
	 * Returns and starts a REPLServer instance. Accepts an "options" Object that takes the following values:
	 * @param	p_options
	 * @return
	 */
	function start(p_options:REPLOption): EventEmitter;
	
}

/**
 * 
 */
extern class REPLOption
{
	
	var prompt 			: Bool;						//the prompt and stream for all I/O. Defaults to > .
	var input 			: Readable;					//the readable stream to listen to. Defaults to process.stdin.
	var output 			: Writable;					//the writable stream to write readline data to. Defaults to process.stdout.
	var terminal 		: Bool;						//pass true if the stream should be treated like a TTY, and have ANSI/VT100 escape codes written to it. Defaults to checking isTTY on the output stream upon instantiation.
	var eval 			: Dynamic;					//function that will be used to eval each given line. Defaults to an async wrapper for eval(). See below for an example of a custom eval.
	var useColors 		: Bool;						//a boolean which specifies whether or not the writer function should output colors. If a different writer function is set then this does nothing. Defaults to the repl's terminal value.
	var useGlobal 		: Bool;						//if set to true, then the repl will use the global object, instead of running scripts in a separate context. Defaults to false.
	var ignoreUndefined : Bool;						//if set to true, then the repl will not output the return value of command if it's undefined. Defaults to false.
	var writer 			: Dynamic->Dynamic->Void;	//the function to invoke for each command that gets evaluated which returns the formatting (including coloring) to display. Defaults to util.inspect.
	
}


