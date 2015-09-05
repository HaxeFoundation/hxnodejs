class Sys {

	public static function exit( code : Int ) {
		js.Node.process.exit(code);
	}

	public static function getEnv (key :String) :String
	{
		return Reflect.field(js.Node.process.env, key);
	}
}



