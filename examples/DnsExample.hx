import js.node.Dns;
import js.node.NodeJS.console;

class DnsExample {
    static function main() {
        Dns.resolve4('www.google.com', function (err, addresses) {
            if (err != null) throw err;

            console.log('addresses: ' + haxe.Json.stringify(addresses));

            for (a in addresses) {
                Dns.reverse(a, function (err, domains) {
                if (err != null) {
                    throw err;
                }

                console.log('reverse for ' + a + ': ' + haxe.Json.stringify(domains));
                });
            }
        });
    }
}
