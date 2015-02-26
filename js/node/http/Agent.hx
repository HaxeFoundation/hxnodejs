package js.node.http;

import haxe.DynamicAccess;

import js.node.net.Socket;

/**
	In node 0.5.3+ there is a new implementation of the HTTP Agent
	which is used for pooling sockets used in HTTP client requests.

	Previously, a single agent instance helped pool for a single host+port.
	The current implementation now holds sockets for any number of hosts.

	The current HTTP Agent also defaults client requests to using Connection:keep-alive.
	If no pending HTTP requests are waiting on a socket to become free the socket is closed.
	This means that node's pool has the benefit of keep-alive when under load but still
	does not require developers to manually close the HTTP clients using keep-alive.

	Sockets are removed from the agent's pool when the socket emits either a "close" event
	or a special "agentRemove" event.
**/
@:jsRequire("http", "Agent")
extern class Agent {
	/**
		Determines how many concurrent sockets the agent can have open per origin.
		Default: Infinity
	**/
	var maxSockets:Float;

	/**
		For Agents supporting HTTP KeepAlive, this sets the maximum number of sockets
		that will be left open in the free state.
		Default: 256
	**/
	var maxFreeSockets:Float;

	/**
		An object which contains arrays of sockets currently in use by the Agent.
		Do not modify.
	**/
	var sockets(default,null):DynamicAccess<Array<Socket>>;

	/**
		An object which contains queues of requests that have not yet been assigned to sockets.
		Do not modify.
	**/
	var requests(default,null):DynamicAccess<Array<ClientRequest>>;

	function new(?options:AgentOptions);

	/**
		Destroy any sockets that are currently in use by the agent.

		It is usually not necessary to do this. However, if you are using an agent with KeepAlive enabled,
		then it is best to explicitly shut down the agent when you know that it will no longer be used.
		Otherwise, sockets may hang open for quite a long time before the server terminates them.
	**/
	function destroy():Void;

	/**
		Get a unique name for a set of request options, to determine whether a connection can be reused.
		In the http agent, this returns host:port:localAddress. In the https agent, the name includes the CA,
		cert, ciphers, and other HTTPS/TLS-specific options that determine socket reusability.

		TODO: proper typing for this?
	**/
	function getName(options:{}):String;
}


/**
	Options for `Agent` constructor.
**/
typedef AgentOptions = {
	/**
		Keep sockets around in a pool to be used by other requests in the future.
		Default: false
	**/
	@:optional var keepAlive:Bool;

	/**
		When using HTTP KeepAlive, how often to send TCP KeepAlive packets over sockets being kept alive.
		Default: 1000.
		Only relevant if `keepAlive` is set to `true`.
	**/
	@:optional var keepAliveMsecs:Int;

	/**
		Maximum number of sockets to allow per host.
		Default: Infinity.
	**/
	@:optional var maxSockets:Float;

	/**
		Maximum number of sockets to leave open in a free state.
		Only relevant if `keepAlive` is set to `true`.
		Default: 256.
	**/
	@:optional var maxFreeSockets:Float;
}
