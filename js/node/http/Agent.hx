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
extern class Agent {
	/**
		By default set to 5.
		Determines how many concurrent sockets the agent can have open per origin.
	**/
	var maxSockets:Int;

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
}
