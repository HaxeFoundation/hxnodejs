package sys;
import js.node.Fs;

class FileSystem {

	public inline static function exists( path : String ) : Bool {
		return Fs.existsSync(path);
	}

	public inline static function rename( path : String, newpath : String ) : Void
	{
		Fs.renameSync(path, newpath);
	}

	public static function stat( path : String ) : sys.FileStat
	{
		return Fs.statSync(path);
	}

	public inline static function createDirectory( path : String ) : Void
	{
		Fs.mkdirSync(path);
	}

	public inline static function deleteFile( path : String ) : Void
	{
		Fs.unlinkSync(path);
	}

	public inline static function readDirectory( path : String ) : Array<String> {
		return Fs.readdirSync(path);
	}


}