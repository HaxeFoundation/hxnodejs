package nodejs.net;
import js.html.webgl.Buffer;

/**
 * Class that serves as an 'enum' for TCPSocketEvents.
 */
class UDPSocketEventType
{
	/**
	 * msg Buffer object. The message
	 * rinfo Object. Remote address information
     * Emitted when a new datagram is available on a socket. msg is a Buffer and rinfo is an object with the sender's address information and the number of bytes in the datagram.
	 */
	static public var Message : String = "message";
	
	/**
	 * Emitted when a socket starts listening for datagrams. This happens as soon as UDP sockets are created.
	 */
	static public var Listening : String = "listening";
	
	/**
	 * Emitted when a socket is closed with close(). No new message events will be emitted on this socket.
	 */
	static public var Close : String = "close";
	
	/**
	 * exception Error object
	 * Emitted when an error occurs.
	 */
	static public var Error : String = "error";
	
}

/**
 * 
 */
class UDPSocketType
{
	/**
	 * 
	 */
	static public var UDP4 : String = "udp4";
	
	/**
	 * 
	 */
	static public var UDP6 : String = "udp6";
	
}


/**
 * 
 */
@:native("(require('dgram'))")
extern class UDP
{
	
	/**
	 * Creates a datagram Socket of the specified types. Valid types are udp4 and udp6.
	 * Takes an optional callback which is added as a listener for message events.
	 * Call socket.bind if you want to receive datagrams. 
	 * socket.bind() will bind to the "all interfaces" address on a random port (it does the right thing for both udp4 and udp6 sockets).
	 * You can then retrieve the address and port with socket.address().address and socket.address().port.
	 * @param	p_type
	 * @param	p_callback
	 * @return
	 */
	@:overload(function createSocket(p_type : String):UDPSocket { } )	
	static function createSocket(p_type : String, p_callback : Buffer -> Dynamic->Void):UDPSocket;
}

/**
 * The dgram Socket class encapsulates the datagram functionality. It should be created via dgram.createSocket(type, [callback]).
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
@:native("(require('dgram').Socket)")
extern class UDPSocket
{
	var send					: Dynamic;//	(buf, offset, length, port, address, [callback])
	var bind					: Dynamic;//	(port, [address], [callback])
	var close					: Dynamic;//	()
	var address					: Dynamic;//	()
	var setBroadcast			: Dynamic;//	(flag)
	var setTTL					: Dynamic;//	(ttl)
	var setMulticastTTL			: Dynamic;//	(ttl)
	var setMulticastLoopback	: Dynamic;//	(flag)
	var addMembership			: Dynamic;//	(multicastAddress, [multicastInterface])
	var dropMembership			: Dynamic;//	(multicastAddress, [multicastInterface])
	var unref					: Dynamic;//	()
	var ref						: Dynamic;//	()	
}