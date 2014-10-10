package js.node.http;

/**
	Enumeration of events emitted by the `Server` class.
**/
@:enum abstract ServerEvent(String) to String {
	/**
		Emitted each time there is a request.

		Note that there may be multiple requests per connection (in the case of keep-alive connections).

		Listener arguments:
			* request : IncomingMessage
			* response : ServerResponse
	**/
	var Request = "request";

	/**
		When a new TCP stream is established. Usually users will not want to access this event.
		In particular, the socket will not emit readable events because of how the protocol parser attaches to the socket.

		Listener arguments:
			* socket : Socket
	**/
	var Connection = "connection";

	/**
		Emitted when the server closes.
	**/
	var Close = "close";

	/**
		Emitted when the server has been bound after calling `Server.listen`.
	**/
	var Listening = "listening";

	/**
		Emitted when an error occurs.
		The 'close' event will be called directly following this event.
	**/
	var Error = "error";

	/**
		If a client connection emits an 'error' event - it will forwarded here.
		Listener arguments:
			exception : Error
			socket : Socket
	**/
	var ClientError = "clientError";

	/**
		Emitted each time a request with an http Expect: 100-continue is received.

		If this event isn't listened for, the server will automatically respond with a 100 Continue as appropriate.

		Handling this event involves calling `response.writeContinue` if the client should continue
		to send the request body, or generating an appropriate HTTP response (e.g., 400 Bad Request) if the client
		should not continue to send the request body.

		Note that when this event is emitted and handled, the 'request' event will not be emitted.

		Listener arguments:
			* request : IncomingMessage
			* response : ServerResponse
	**/
	var CheckContinue = "checkContinue";

	/**
		Emitted each time a client requests a http CONNECT method.

		If this event isn't listened for, then clients requesting a CONNECT method will have their connections closed.

		Listener arguments:
			* request : IncomingMessage - arguments for the http request, as it is in the request event
			* socket : Socket - network socket between the server and client
			* head : Buffer - instance of Buffer, the first packet of the tunneling stream, this may be empty

		After this event is emitted, the request's socket will not have a 'data' event listener,
		meaning you will need to bind to it in order to handle data sent to the server on that socket.
	**/
	var Connect = "connect";

	/**
		Emitted each time a client requests a http upgrade.

		If this event isn't listened for, then clients requesting an upgrade will have their connections closed.

		Listener arguments:
			* request : IncomingMessage - arguments for the http request, as it is in the request event
			* socket : Socket - network socket between the server and client
			* head : Buffer - instance of Buffer, the first packet of the tunneling stream, this may be empty

		After this event is emitted, the request's socket will not have a data event listener,
		meaning you will need to bind to it in order to handle data sent to the server on that socket.
	**/
	var Upgrade = "upgrade";
}

extern class Server extends js.node.net.Server {
	/**
		Limits maximum incoming headers count, equal to 1000 by default.
		If set to 0 - no limit will be applied.
	**/
	var maxHeadersCount:Int;

	/**
		Sets the timeout value for sockets, and emits a 'timeout' event on the `Server` object,
		passing the socket as an argument, if a timeout occurs.

		If there is a 'timeout' event listener on the `Server` object,
		then it will be called with the timed-out socket as an argument.

		By default, the Server's timeout value is 2 minutes, and sockets are destroyed automatically if they time out.
		However, if you assign a callback to the Server's 'timeout' event, then you are responsible
		for handling socket timeouts.
	**/
	function setTimeout(msecs:Int, ?callback:js.node.net.Socket->Void):Void;

	/**
		The number of milliseconds of inactivity before a socket is presumed to have timed out.

		Note that the socket timeout logic is set up on connection, so changing this value
		only affects new connections to the server, not any existing connections.

		Set to 0 to disable any kind of automatic timeout behavior on incoming connections.

		Default: 120000 (2 minutes)
	**/
	var timeout:Int;
}
