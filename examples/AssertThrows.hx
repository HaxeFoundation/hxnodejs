#if haxe4
import js.lib.Error;
import js.lib.RegExp;
#else
import js.Error;
import js.RegExp;
#end
import js.node.Assert;

class AssertThrows {
	static function main() {
		Assert.throws(function() throw new Error("Wrong value"), Error);
		Assert.throws(function() throw new Error("Wrong value"), new RegExp("value"));
		Assert.throws(
			function() throw new Error("Wrong value"),
			function(err) return (Std.is(err, Error) && ~/value/.match(err.message)),
			"unexpected error"
		);
	}
}
