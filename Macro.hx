import haxe.macro.Context;

class Macro {
	public static function init() {
		Context.onGenerate(function(_) {
			Context.filterMessages(msg -> switch msg {
				case Warning("This typedef is deprecated in favor of { ?slashes : Null<Bool>, ?search : Null<String>, ?query : Null<haxe.extern.EitherType<String, haxe.DynamicAccess<String>>>, ?protocol : Null<String>, ?port : Null<String>, ?pathname : Null<String>, ?path : Null<String>, ?href : Null<String>, ?hostname : Null<String>, ?host : Null<String>, ?hash : Null<String>, ?auth : Null<String> }",
					_): false;
				case _: true;
			});
		});
	}
}
