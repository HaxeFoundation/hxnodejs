package js.node.http;

import js.node.stream.Readable;
import js.node.net.Socket;

// TODO: these actually (partially) duplicate ReadableEvent
@:enum abstract IncomingMessageEvent(String) to String {
	/**
		Listener argument:
			- chunk (Buffer or String) - The chunk of data.

		If you attach a `data` event listener, then it will switch the stream into flowing mode,
		and data will be passed to your handler as soon as it is available.
	**/
	var Data = "data";

	/**
		Indicates that the underlaying connection was closed.
		Just like 'end', this event occurs only once per response.
	**/
	var Close = "close";

	/**
		This event fires when there will be no more data to read.

		Note that the end event will not fire unless the data is completely consumed.
		This can be done by switching into flowing mode, or by calling read() repeatedly until you get to the end.
	**/
	var End = "end";
}

/**
	An `IncomingMessage` object is created by `Server` or `ClientRequest` and passed as the first
	argument to the 'request' and 'response' event respectively.
	It may be used to access response status, headers and data.
**/
extern class IncomingMessage extends Readable {
	/**
		In case of server request, the HTTP version sent by the client.
		In the case of client response, the HTTP version of the connected-to server.
		Probably either '1.1' or '1.0'.
	**/
	var httpVersion(default,null):String;

	/**
		HTTP Version first integer
	**/
	var httpVersionMajor:Int;

	/**
		HTTP Version second integer
	**/
	var httpVersionMinor:Int;

	/**
		The request/response headers object.
		Read only map of header names and values. Header names are lower-cased
	**/
	var headers(default,null):Dynamic<String>;

	/**
		The request/response trailers object.
		Only populated after the 'end' event.
	**/
	var trailers(default,null):Dynamic<String>;

	/**
		Calls `setTimeout` on the `socket` object.
	**/
	function setTimeout(msecs:Int, ?callback:Void->Void):Void;

	/**
		Only valid for request obtained from `Server`.

		The request method as a string.
		Read only. Example: 'GET', 'DELETE'.
	**/
	var method(default,null):Method;

	/**
		Only valid for request obtained from `Server`.

		Request URL string. This contains only the URL that is present in the actual HTTP request.
	**/
	var url(default,null):String;

	/**
		Only valid for response obtained from `ClientRequest`.
		The 3-digit HTTP response status code. E.G. 404.
	**/
	var statusCode(default,null):Int;

	/**
		The `Socket` object associated with the connection.

		With HTTPS support, use `socket.verifyPeer` and `socket.getPeerCertificate`
		to obtain the client's authentication details. // TODO: we should add these to `js.node.net.Socket` i suppose
	**/
	var socket(default,null):Socket;

	/**
		Alias for `socket`.
	**/
	var connection(default,null):Socket;
}
