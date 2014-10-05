package nodejs.fs;
import nodejs.stream.Readable;

/**
 * 
 */
class ReadStreamEventType
{
	/**
	 * fd Integer file descriptor used by the ReadStream.
	 * Emitted when the ReadStream's file is opened.
	 */
	static public var Open : String = "open";
}

/**
 * ReadStream is a Readable Stream.
 * @author Eduardo Pons - eduardo@thelaborat.org
 */
extern class ReadStream extends Readable
{

	
	
}