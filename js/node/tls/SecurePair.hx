package js.node.tls;

import js.node.events.EventEmitter;

/**
	Events emitted by `SecurePair`.
**/
@:enum abstract SecurePairEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		The event is emitted from the `SecurePair` once the pair has successfully established a secure connection.

		Similarly to the checking for the server 'secureConnection' event,
		`SecurePair.cleartext.authorized` should be checked to confirm whether
		the certificate used properly authorized.
	**/
	var Secure : SecurePairEvent<Void->Void> = "secure";
}

/**
	Returned by `Tls.createSecurePair`.
**/
extern class SecurePair extends EventEmitter<SecurePair> {
	var cleartext(default,null):CleartextStream;
	var encrypted(default,null):EncryptedStream;
}
