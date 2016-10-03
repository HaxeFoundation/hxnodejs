package sys;


@:dce
@:coreApi
class FileSystem {

	public static function exists( path : String ) : Bool {
		return try { js.node.Fs.accessSync(path); true; } catch (_:Dynamic) false;
	}

	public static inline function rename( path : String, newPath : String ) : Void {
		js.node.Fs.renameSync(path, newPath);
	}

	public static inline function stat( path : String ) : sys.FileStat {
		return cast js.node.Fs.statSync(path);
	}

	public static inline function fullPath( relPath : String ) : String {
		return js.node.Fs.realpathSync(relPath);
	}

	public static inline function absolutePath( relPath : String ) : String {
		return js.node.Path.resolve(relPath);
	}

	public static inline function isDirectory( path : String ) : Bool {
		return js.node.Fs.statSync(path).isDirectory();
	}

	public static function createDirectory( path : String ) : Void {
		try {
			js.node.Fs.mkdirSync(path);
		} catch (e:Dynamic) {
			if (e.code == "ENOENT") {
				// parent doesn't exist - create parent and then this dir
				createDirectory(js.node.Path.dirname(path));
				js.node.Fs.mkdirSync(path);
			} else {
				// some other error - check if path is a dir, rethrow the error if not
				// (the `(e : js.Error)` cast is here to avoid HaxeError wrapping, though we need to investigate this in Haxe itself)
				var stat = try js.node.Fs.statSync(path) catch (_:Dynamic) throw (e : js.Error);
				if (!stat.isDirectory()) throw (e : js.Error);
			}
		}
	}

	public static inline function deleteFile( path : String ) : Void {
		js.node.Fs.unlinkSync(path);
	}

	public static inline function deleteDirectory( path : String ) : Void {
		js.node.Fs.rmdirSync(path);
	}

	public static inline function readDirectory( path : String ) : Array<String> {
		return js.node.Fs.readdirSync(path);
	}

}