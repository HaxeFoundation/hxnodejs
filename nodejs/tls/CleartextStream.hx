package nodejs.tls;
import js.Error;
import nodejs.events.EventEmitter;
import nodejs.net.TCPSocket.NetworkAdress;

class CleartextStreamEventType
{
	/**
	 * This event is emitted after a new connection has been successfully handshaked. 
	 * The listener will be called no matter if the server's certificate was authorized or not.
	 * It is up to the user to test cleartextStream.authorized to see if the server certificate was signed by one of the specified CAs.
	 * If cleartextStream.authorized === false then the error can be found in cleartextStream.authorizationError. 
	 * Also if NPN was used - you can check cleartextStream.npnProtocol for negotiated protocol.
	 */
	static var SecureConnect : String = "secureConnect";
}

/**
 * This is a stream on top of the Encrypted stream that makes it possible to read/write an encrypted data as a cleartext data.
 * This instance implements a duplex Stream interfaces. It has all the common stream methods and events.
 * A ClearTextStream is the clear member of a SecurePair object.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class CleartextStream extends EventEmitter
{
	
	/**
	 * A boolean that is true if the peer certificate was signed by one of the specified CAs, otherwise false
	 */
	var authorized : Bool;
	
	/**
	 * The reason why the peer's certificate has not been verified. This property becomes available only when cleartextStream.authorized === false.
	 */
	var authorizationError : Error;
	
	/**
	 * The string representation of the remote IP address. For example, '74.125.127.100' or '2001:4860:a005::68'.
	 */
	var remoteAddress : String;
	
	/**
	 * The numeric representation of the remote port. For example, 443.
	 */
	var remotePort : Int;
	
	/**
	 * Returns an object representing the peer's certificate. The returned object has some properties corresponding to the field of the certificate.
	 * If the peer does not provide a certificate, it returns null or an empty object.
	 */
	function getPeerCertificate():Dynamic;
	
	/**
	 * Returns an object representing the cipher name and the SSL/TLS protocol version of the current connection.
	 * Example: { name: 'AES256-SHA', version: 'TLSv1/SSLv3' }
	 * See SSL_CIPHER_get_name() and SSL_CIPHER_get_version() in http://www.openssl.org/docs/ssl/ssl.html#DEALING_WITH_CIPHERS for more information.
	 */
	function getCipher() : Dynamic;
	
	/**
	 * Returns the bound address, the address family name and port of the underlying socket as reported by the operating system. Returns an object with three properties, e.g. { port: 12346, family: 'IPv4', address: '127.0.0.1' }
	 */
	function address() : NetworkAdress;
	
	
}