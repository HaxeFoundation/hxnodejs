import js.lib.Error;
import js.lib.RegExp;
import js.node.Assert;

class AssertThrows {
	static function main() {
		Assert.throws(function() throw new Error("Wrong value"), Error);
		Assert.throws(function() throw new Error("Wrong value"), new RegExp("value"));
		Assert.throws(function() throw new Error("Wrong value"), function(err)
			return switch Std.downcast(cast err, Error) {
				case null: false;
				case e: ~/value/.match(e.message);
			},
			"unexpected error"
		);
	}
}
