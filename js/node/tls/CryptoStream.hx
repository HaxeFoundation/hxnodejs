package js.node.tls;

/**
	This is an encrypted stream. Base class for `CleartextStream` and `EncryptedStream`.
**/
extern class CryptoStream extends js.node.stream.Duplex<CryptoStream> {
	/**
		A proxy to the underlying socket's bytesWritten accessor,
		this will return the total bytes written to the socket,
		including the TLS overhead.
	**/
	var bytesWritten(default,null):Int;
}
