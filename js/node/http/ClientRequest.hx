package js.node.http;

import js.node.stream.Writable;

/**
	Enumeration of events emitted by `ClientRequest`
**/
@:enum abstract ClientRequestEvent(String) to String {
	/**
		Emitted when a response is received to this request. This event is emitted only once.
		Listener arguments:
			* response : IncomingMessage
	**/
	var Response = "response";

	/**
		Emitted after a socket is assigned to this request.
	**/
	var Socket = "socket";

	/**
		Emitted each time a server responds to a request with a CONNECT method.
		If this event isn't being listened for, clients receiving a CONNECT method
		will have their connections closed.

		Listener arguments:
			* response : IncomingMessage
			* socket : Socket
			* head : Buffer
	**/
	var Connect = "connect";

	/**
		Emitted each time a server responds to a request with an upgrade.
		If this event isn't being listened for, clients receiving an upgrade header
		will have their connections closed.

		Listener argument:
			* response : IncomingMessage
			* socket : Socket
			* head : Buffer
	**/
	var Upgrade = "upgrade";

	/**
		Emitted when the server sends a '100 Continue' HTTP response,
		usually because the request contained 'Expect: 100-continue'.
		This is an instruction that the client should send the request body.
	**/
	var Continue = "continue";
}

/**
	This object is created internally and returned from `Http.request`.
	It represents an in-progress request whose header has already been queued.
**/
extern class ClientRequest extends Writable {

	/**
		Get header value
	**/
	function getHeader(name:String):String;

	/**
		Set header value.

		Headers can only be modified before the request is sent.
	**/
	function setHeader(name:String, value:String):Void;

	/**
		Remove header

		Headers can only be modified before the request is sent.
	**/
	function removeHeader(name:String):String;

	/**
		Aborts a request.
	**/
	function abort():Void;

	/**
		Once a socket is assigned to this request and is connected
		`socket.setTimeout` will be called.
	**/
	function setTimeout(timeout:Int, ?callback:Void->Void):Void;

	/**
		Once a socket is assigned to this request and is connected
		`socket.setNoDelay` will be called.
	**/
	function setNoDelay(?noDelay:Bool):Void;

	/**
		Once a socket is assigned to this request and is connected
		`socket.setKeepAlive`() will be called.
	**/
    @:overload(function(?initialDelay:Int):Void {})
    function setKeepAlive(enable:Bool, ?initialDelay:Int):Void;
}
