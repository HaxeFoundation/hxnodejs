package js.node.tls;

/**
	This is an encrypted stream.
**/
extern class CryptoStream extends js.node.stream.Duplex {
	/**
		A proxy to the underlying socket's bytesWritten accessor,
		this will return the total bytes written to the socket,
		including the TLS overhead.
	**/
	var bytesWritten(default,null):Int;
}
