package js.node.tls;

import js.node.Crypto.CredentialOptions;

/**
	Enumeration of events emitted by `Server` in addition to its parent classes.
**/
@:enum abstract ServerEvent(String) to String {
	/**
		This event is emitted after a new connection has been successfully handshaked.

		Listener arguments:
			cleartextStream : ClearTextStream
			encryptedStream : EncryptedStream
	**/
	var SecureConnection = "secureConnection";

	/**
		When a client connection emits an 'error' event before secure connection is established -
		it will be forwarded here.

		Listener arguments:
			exception - error object
			securePair : SecurePair - a secure pair that the error originated from
	**/
	var ClientError = "clientError";

	/**
		Emitted on creation of TLS session.
		May be used to store sessions in external storage.

		Listener arguments:
			sessionId : Buffer
			sessionData : Buffer
	**/
	var NewSession = "newSession";

	/**
		Emitted when client wants to resume previous TLS session.
		Event listener may perform lookup in external storage using given sessionId,
		and invoke callback(null, sessionData) once finished.
		If session can't be resumed (i.e. doesn't exist in storage) one may call callback(null, null).
		Calling callback(err) will terminate incoming connection and destroy socket.

		Listener arguments:
			sessionId : Buffer
			callback : Error->?Buffer->Void
	**/
	var ResumeSession = "resumeSession";
}

/**
	This class is a subclass of `net.Server` and has the same methods on it.
	Instead of accepting just raw TCP connections, this accepts encrypted connections using TLS or SSL.
**/
extern class Server extends js.node.net.Server {
	/**
		Add secure context that will be used if client request's SNI hostname
		is matching passed hostname (wildcards can be used).
	**/
	function addContext(hostname:String, credentials:CredentialOptions):Void;
}
