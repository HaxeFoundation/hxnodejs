package nodejs.tls;

/**
 * This is an encrypted stream.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class CryptoStream
{
	
	/**
	 * A proxy to the underlying socket's bytesWritten accessor, this will return the total bytes written to the socket, including the TLS overhead.
	 */
	var bytesWritten : Int;
	
}