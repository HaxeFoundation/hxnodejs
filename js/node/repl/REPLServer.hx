package js.node.repl;

import js.node.events.EventEmitter;

/**
	Enumeration of events emitted by `REPLServer` objects.
**/
@:enum abstract REPLServerEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted when the user exits the REPL in any of the defined ways.
		Namely, typing .exit at the repl, pressing Ctrl+C twice to signal SIGINT,
		or pressing Ctrl+D to signal "end" on the input stream.
	**/
	var Exit : REPLServerEvent<Void->Void> = "exit";
}

/**
	An object representing REPL instance created by `Repl.start`.
**/
@:jsRequire("repl", "REPLServer")
extern class REPLServer extends EventEmitter<REPLServer> {
	/**
		You can expose a variable to the REPL explicitly by assigning it
		to the `context` object associated with each REPLServer.
	**/
	var context(default,null):Dynamic<Dynamic>;
}
