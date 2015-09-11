import js.node.Crypto;

class CryptoECDHExample {
    static function main() {
        var alice = Crypto.createECDH('secp256k1');
        var bob = Crypto.createECDH('secp256k1');
        
        alice.generateKeys();
        bob.generateKeys();

        var alice_secret = alice.computeSecret(bob.getPublicKey(), null, 'hex');
        var bob_secret = bob.computeSecret(alice.getPublicKey(), null, 'hex');

        /* alice_secret and bob_secret should be the same */
        trace(alice_secret == bob_secret);
    }
}
