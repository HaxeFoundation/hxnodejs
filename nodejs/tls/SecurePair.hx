package nodejs.tls;
import nodejs.events.EventEmitter;

/**
 * 
 */
class SecurePairEventType
{
	/**
	 * The event is emitted from the SecurePair once the pair has successfully established a secure connection.
	 * Similarly to the checking for the server 'secureConnection' event, pair.cleartext.authorized should be 
	 * checked to confirm whether the certificate used properly authorized.
	 */
	static public var Secure : String = "secure";
}

/**
 * Returned by tls.createSecurePair.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class SecurePair extends EventEmitter
{

	
	
}