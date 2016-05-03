import js.node.Crypto;
import js.node.Buffer;

class CryptoCipherExample {
    static function main() {
        var cipher = Crypto.createCipher('aes192', 'a password');

        var encrypted = '';
        cipher.on('readable', function() {
            var data:Buffer = cipher.read();
            if (data != null)
                encrypted += data.toString('hex');
        });
        cipher.on('end', function() {
            trace(encrypted);
            // Prints: ca981be48e90867604588e75d04feabb63cc007a8f8ad89b10616ed84d815504
        });

        cipher.write('some clear text data');
        cipher.end();
    }
}
