package js.node.https;

import js.node.http.IncomingMessage;

/**
    An Agent object for HTTPS similar to http.Agent.
    See `Https.request` for more information.
**/
extern class Agent {
    /**
     * By default set to 5. Determines how many concurrent sockets the agent can have open per origin. Origin is either a 'host:port' or 'host:port:localAddress' combination.
     */
    var maxSockets : Int;

    /**
     * An object which contains arrays of sockets currently in use by the Agent. Do not modify.
     */
    var sockets : Array<js.node.net.Socket>;

    /**
     * An object which contains queues of requests that have not yet been assigned to sockets. Do not modify.
     */
    var requests : Array<IncomingMessage>;
}
