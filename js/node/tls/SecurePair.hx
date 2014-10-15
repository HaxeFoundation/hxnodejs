package js.node.tls;

/**
	Events emitted by `SecurePair`.
**/
@:enum abstract SecurePairEvent(String) to String {
	/**
		The event is emitted from the `SecurePair` once the pair has successfully established a secure connection.
		Similarly to the checking for the server 'secureConnection' event, pair.cleartext.authorized should be checked
		to confirm whether the certificate used properly authorized.
	**/
	var Secure = "secure";
}

/**
	Returned by `Tls.createSecurePair`.
**/
extern class SecurePair extends js.node.events.EventEmitter<SecurePair> {
	var cleartext:CleartextStream;
	var encrypted:EncryptedStream;
}
