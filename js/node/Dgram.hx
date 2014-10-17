package js.node;

import js.node.Buffer;
import js.node.dgram.Socket;

/**
    Datagram sockets
**/
@:jsRequire("dgram")
extern class Dgram {
    /**
        Creates a datagram `Socket` of the specified types.

        Takes an optional `callback` which is added as a listener for 'message' events.

        Call `socket.bind` if you want to receive datagrams. `socket.bind` will bind to
        the "all interfaces" address on a random port (it does the right thing for both `udp4` and `udp6` sockets).
        You can then retrieve the address and port with `socket.address().address` and `socket.address().port`.
    **/
    static function createSocket(type:SocketType, ?callback:Buffer->RemoteInfo->Void):Socket;
}
