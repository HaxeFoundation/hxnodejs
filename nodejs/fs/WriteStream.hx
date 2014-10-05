package nodejs.fs;
import nodejs.stream.Readable;
import nodejs.stream.Writable;

/**
 * 
 */
class WriteStreamEventType
{
	/**
	 * fd Integer file descriptor used by the WriteStream.
	 * Emitted when the WriteStream's file is opened.
	 */
	static public var Open : String = "open";
}

/**
 * ReadStream is a Writable Stream.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class WriteStream extends Writable
{

	
	
}