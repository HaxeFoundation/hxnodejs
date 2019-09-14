package js.node;

/**
	Key/value access helper.
**/
abstract KeyValue<K, V>(Array<Any>) {
	public var key(get, never):K;
	public var value(get, never):V;

	inline function get_key():K {
		return this[0];
	}

	inline function get_value():V {
		return this[1];
	}
}
