import js.Error;
import js.node.Assert;

class AssertThrows {
	static function main() {
		Assert.throws(function() throw new Error("Wrong value"), Error);
		Assert.throws(function() throw new Error("Wrong value"), new js.RegExp("value"));
		Assert.throws(
			function() throw new Error("Wrong value"),
			function(err) return (Std.is(err, Error) && ~/value/.match(err.message)),
			"unexpected error"
		);
	}
}
