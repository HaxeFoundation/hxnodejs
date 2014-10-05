package nodejs.tls;
import nodejs.net.TCPServer;

/**
 * 
 */
class TLSServerEventType
{
	/**
	 * function (cleartextStream) {}
	 * This event is emitted after a new connection has been successfully handshaked. 
	 * The argument is a instance of CleartextStream. 
	 * It has all the common stream methods and events.
	 * cleartextStream.authorized is a boolean value which indicates if the client has verified by one of the supplied certificate authorities for the server. 
	 * If cleartextStream.authorized is false, then cleartextStream.authorizationError is set to describe how authorization failed.
	 * Implied but worth mentioning: depending on the settings of the TLS server, you unauthorized connections may be accepted. 
	 * cleartextStream.npnProtocol is a string containing selected NPN protocol. cleartextStream.servername is a string containing servername requested with SNI.
	 */
	static var SecureConnection : String = "secureConnection";
	
	/**
	 * function (exception, securePair) { }
	 * When a client connection emits an 'error' event before secure connection is established - it will be forwarded here.
	 * securePair is the tls.SecurePair that the error originated from.
	 */
	static var ClientError 		: String = "clientError";
	
	/**
	 * function (sessionId, sessionData) { }
	 * Emitted on creation of TLS session. May be used to store sessions in external storage.
	 */
	static var NewSession 		: String = "newSession";
	
	/**
	 * function (sessionId, callback) { }
	 * Emitted when client wants to resume previous TLS session. 
	 * Event listener may perform lookup in external storage using given sessionId, and invoke callback(null, sessionData) once finished. 
	 * If session can't be resumed (i.e. doesn't exist in storage) one may call callback(null, null).
	 * Calling callback(err) will terminate incoming connection and destroy socket.
	 */
	static var ResumeSession 	: String = "resumeSession";
}

/**
 * This class is a subclass of net.Server and has the same methods on it. Instead of accepting just raw TCP connections, this accepts encrypted connections using TLS or SSL.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class TLSServer extends TCPServer
{

	var addContext : Dynamic; //(hostname, credentials)
	
}