/*
 * Copyright (C)2014-2019 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */
package js.node;

/**
	Information about the currently effective user (returned by `Os.userInfo` method).

	On POSIX platforms, this is typically a subset of the password file.
**/
typedef OsUserInfo = {
	/**
		-1 on Windows
	**/
	var uid:Int;

	/**
		-1 on Windows
	**/
	var gid:Int;

	var username:String;

	/**
		Provided by the operating system. This differs from the result of `Os.homedir`,
		which queries several environment variables for the home directory
		before falling back to the operating system response.
	**/
	var homedir:String;

	/**
		null on Windows
	**/
	var shell:Null<String>;
}

/**
	Object containing the number of milliseconds the CPU/core spent in: user, nice, sys, idle, and irq
**/
typedef CPUTime = {
	/**
		The number of milliseconds the CPU has spent in user mode.
	**/
	var user:Int;

	/**
		The number of milliseconds the CPU has spent in nice mode.
	**/
	var nice:Int;

	/**
		The number of milliseconds the CPU has spent in sys mode.
	**/
	var sys:Int;

	/**
		The number of milliseconds the CPU has spent in idle mode.
	**/
	var idle:Int;

	/**
		The number of milliseconds the CPU has spent in irq mode.
	**/
	var irq:Int;
}

/**
	Object containing information about each CPU/core installed. Returned by `Os.cpus` method.
**/
typedef CPU = {
	/**
		CPU Model.
		E.g. 'Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz'
	**/
	var model:String;

	/**
		MHz Speed.
		E.g. 2926
	**/
	var speed:Int;

	/**
		CPUTime data.
	**/
	var times:CPUTime;
}

/**
	Objects containing information about network interface addresses.
**/
typedef NetworkInterface = Array<NetworkInterfaceAddressInfo>;
typedef NetworkInterfaceAddressInfo = {
	/**
		IP address family (either IPv4 or IPv6).
	**/
	var family:js.node.net.Socket.SocketAdressFamily;

	/**
		The assigned IPv4 or IPv6 address.
	**/
	var address:String;

	/**
		The IPv4 or IPv6 network mask.
	**/
	var netmask:String;

	/**
		The MAC address of the network interface.
	**/
	var mac:String;

	/**
		True if the network interface is a loopback or similar interface that is not remotely accessible; otherwise false
	**/
	var internal:Bool;

	/**
		The numeric IPv6 scope ID (only specified when family is IPv6)
	**/
	@:optional var scopeid:Int;
}

@:enum abstract Endianness(String) to String {
	var BigEndian = "BE";
	var LittleEndian = "LE";
}

/**
	Constants object returned by `Os.constants`.

	Note: Not all constants will be available on every operating system.
**/
typedef OsConstants = {
	/**
		Signal Constants
	**/
	var signals:{
		/**
			Sent to indicate when a controlling terminal is closed or a parent process exits.
		**/
		var SIGHUP:Int;

		/**
			Sent to indicate when a user wishes to interrupt a process ((Ctrl+C)).
		**/
		var SIGINT:Int;

		/**
			Sent to indicate when a user wishes to terminate a process and perform a core dump.
		**/
		var SIGQUIT:Int;

		/**
			Sent to a process to notify that it has attempted to perform an illegal, malformed, unknown or privileged instruction.
		**/
		var SIGILL:Int;

		/**
			Sent to a process when an exception has occurred.
		**/
		var SIGTRAP:Int;

		/**
			Sent to a process to request that it abort.
		**/
		var SIGABRT:Int;

		/**
			Synonym for SIGABRT
		**/
		var SIGIOT:Int;

		/**
			Sent to a process to notify that it has caused a bus error.
		**/
		var SIGBUS:Int;

		/**
			Sent to a process to notify that it has performed an illegal arithmetic operation.
		**/
		var SIGFPE:Int;

		/**
			Sent to a process to terminate it immediately.
		**/
		var SIGKILL:Int;

		/**
			SIGUSR2	Sent to a process to identify user-defined conditions.
		**/
		var SIGUSR1:Int;

		/**
			Sent to a process to notify of a segmentation fault.
		**/
		var SIGSEGV:Int;

		/**
			Sent to a process when it has attempted to write to a disconnected pipe.
		**/
		var SIGPIPE:Int;

		/**
			Sent to a process when a system timer elapses.
		**/
		var SIGALRM:Int;

		/**
			Sent to a process to request termination.
		**/
		var SIGTERM:Int;

		/**
			Sent to a process when a child process terminates.
		**/
		var SIGCHLD:Int;

		/**
			Sent to a process to indicate a stack fault on a coprocessor.
		**/
		var SIGSTKFLT:Int;

		/**
			Sent to instruct the operating system to continue a paused process.
		**/
		var SIGCONT:Int;

		/**
			Sent to instruct the operating system to halt a process.
		**/
		var SIGSTOP:Int;

		/**
			Sent to a process to request it to stop.
		**/
		var SIGTSTP:Int;

		/**
			Sent to indicate when a user wishes to interrupt a process.
		**/
		var SIGBREAK:Int;

		/**
			Sent to a process when it reads from the TTY while in the background.
		**/
		var SIGTTIN:Int;

		/**
			Sent to a process when it writes to the TTY while in the background.
		**/
		var SIGTTOU:Int;

		/**
			Sent to a process when a socket has urgent data to read.
		**/
		var SIGURG:Int;

		/**
			Sent to a process when it has exceeded its limit on CPU usage.
		**/
		var SIGXCPU:Int;

		/**
			Sent to a process when it grows a file larger than the maximum allowed.
		**/
		var SIGXFSZ:Int;

		/**
			Sent to a process when a virtual timer has elapsed.
		**/
		var SIGVTALRM:Int;

		/**
			Sent to a process when a system timer has elapsed.
		**/
		var SIGPROF:Int;

		/**
			Sent to a process when the controlling terminal has changed its size.
		**/
		var SIGWINCH:Int;

		/**
			Sent to a process when I/O is available.
		**/
		var SIGIO:Int;

		/**
			Synonym for SIGIO
		**/
		var SIGPOLL:Int;

		/**
			Sent to a process when a file lock has been lost.
		**/
		var SIGLOST:Int;

		/**
			Sent to a process to notify of a power failure.
		**/
		var SIGPWR:Int;

		/**
			Synonym for SIGPWR
		**/
		var SIGINFO:Int;

		/**
			Sent to a process to notify of a bad argument.
		**/
		var SIGSYS:Int;

		/**
			Synonym for SIGSYS
		**/
		var SIGUNUSED:Int;
	};

	/**
		Error Constants
	**/
	var errno:{
		/**
			Indicates that the list of arguments is longer than expected.
		**/
		var E2BIG:Int;

		/**
			Indicates that the operation did not have sufficient permissions.
		**/
		var EACCES:Int;

		/**
			Indicates that the network address is already in use.
		**/
		var EADDRINUSE:Int;

		/**
			Indicates that the network address is currently unavailable for use.
		**/
		var EADDRNOTAVAIL:Int;

		/**
			Indicates that the network address family is not supported.
		**/
		var EAFNOSUPPORT:Int;

		/**
			Indicates that there is currently no data available and to try the operation again later.
		**/
		var EAGAIN:Int;

		/**
			Indicates that the socket already has a pending connection in progress.
		**/
		var EALREADY:Int;

		/**
			Indicates that a file descriptor is not valid.
		**/
		var EBADF:Int;

		/**
			Indicates an invalid data message.
		**/
		var EBADMSG:Int;

		/**
			Indicates that a device or resource is busy.
		**/
		var EBUSY:Int;

		/**
			Indicates that an operation was canceled.
		**/
		var ECANCELED:Int;

		/**
			Indicates that there are no child processes.
		**/
		var ECHILD:Int;

		/**
			Indicates that the network connection has been aborted.
		**/
		var ECONNABORTED:Int;

		/**
			Indicates that the network connection has been refused.
		**/
		var ECONNREFUSED:Int;

		/**
			Indicates that the network connection has been reset.
		**/
		var ECONNRESET:Int;

		/**
			Indicates that a resource deadlock has been avoided.
		**/
		var EDEADLK:Int;

		/**
			Indicates that a destination address is required.
		**/
		var EDESTADDRREQ:Int;

		/**
			Indicates that an argument is out of the domain of the function.
		**/
		var EDOM:Int;

		/**
			Indicates that the disk quota has been exceeded.
		**/
		var EDQUOT:Int;

		/**
			Indicates that the file already exists.
		**/
		var EEXIST:Int;

		/**
			Indicates an invalid pointer address.
		**/
		var EFAULT:Int;

		/**
			Indicates that the file is too large.
		**/
		var EFBIG:Int;

		/**
			Indicates that the host is unreachable.
		**/
		var EHOSTUNREACH:Int;

		/**
			Indicates that the identifier has been removed.
		**/
		var EIDRM:Int;

		/**
			Indicates an illegal byte sequence.
		**/
		var EILSEQ:Int;

		/**
			Indicates that an operation is already in progress.
		**/
		var EINPROGRESS:Int;

		/**
			Indicates that a function call was interrupted.
		**/
		var EINTR:Int;

		/**
			Indicates that an invalid argument was provided.
		**/
		var EINVAL:Int;

		/**
			Indicates an otherwise unspecified I/O error.
		**/
		var EIO:Int;

		/**
			Indicates that the socket is connected.
		**/
		var EISCONN:Int;

		/**
			Indicates that the path is a directory.
		**/
		var EISDIR:Int;

		/**
			Indicates too many levels of symbolic links in a path.
		**/
		var ELOOP:Int;

		/**
			Indicates that there are too many open files.
		**/
		var EMFILE:Int;

		/**
			Indicates that there are too many hard links to a file.
		**/
		var EMLINK:Int;

		/**
			Indicates that the provided message is too long.
		**/
		var EMSGSIZE:Int;

		/**
			Indicates that a multihop was attempted.
		**/
		var EMULTIHOP:Int;

		/**
			Indicates that the filename is too long.
		**/
		var ENAMETOOLONG:Int;

		/**
			Indicates that the network is down.
		**/
		var ENETDOWN:Int;

		/**
			Indicates that the connection has been aborted by the network.
		**/
		var ENETRESET:Int;

		/**
			Indicates that the network is unreachable.
		**/
		var ENETUNREACH:Int;

		/**
			Indicates too many open files in the system.
		**/
		var ENFILE:Int;

		/**
			Indicates that no buffer space is available.
		**/
		var ENOBUFS:Int;

		/**
			Indicates that no message is available on the stream head read queue.
		**/
		var ENODATA:Int;

		/**
			Indicates that there is no such device.
		**/
		var ENODEV:Int;

		/**
			Indicates that there is no such file or directory.
		**/
		var ENOENT:Int;

		/**
			Indicates an exec format error.
		**/
		var ENOEXEC:Int;

		/**
			Indicates that there are no locks available.
		**/
		var ENOLCK:Int;

		/**
			Indications that a link has been severed.
		**/
		var ENOLINK:Int;

		/**
			Indicates that there is not enough space.
		**/
		var ENOMEM:Int;

		/**
			Indicates that there is no message of the desired type.
		**/
		var ENOMSG:Int;

		/**
			Indicates that a given protocol is not available.
		**/
		var ENOPROTOOPT:Int;

		/**
			Indicates that there is no space available on the device.
		**/
		var ENOSPC:Int;

		/**
			Indicates that there are no stream resources available.
		**/
		var ENOSR:Int;

		/**
			Indicates that a given resource is not a stream.
		**/
		var ENOSTR:Int;

		/**
			Indicates that a function has not been implemented.
		**/
		var ENOSYS:Int;

		/**
			Indicates that the socket is not connected.
		**/
		var ENOTCONN:Int;

		/**
			Indicates that the path is not a directory.
		**/
		var ENOTDIR:Int;

		/**
			Indicates that the directory is not empty.
		**/
		var ENOTEMPTY:Int;

		/**
			Indicates that the given item is not a socket.
		**/
		var ENOTSOCK:Int;

		/**
			Indicates that a given operation is not supported.
		**/
		var ENOTSUP:Int;

		/**
			Indicates an inappropriate I/O control operation.
		**/
		var ENOTTY:Int;

		/**
			Indicates no such device or address.
		**/
		var ENXIO:Int;

		/**
			Indicates that an operation is not supported on the socket. Note that while ENOTSUP and EOPNOTSUPP have the same value on Linux, according to POSIX.1 these error values should be distinct.)
		**/
		var EOPNOTSUPP:Int;

		/**
			Indicates that a value is too large to be stored in a given data type.
		**/
		var EOVERFLOW:Int;

		/**
			Indicates that the operation is not permitted.
		**/
		var EPERM:Int;

		/**
			Indicates a broken pipe.
		**/
		var EPIPE:Int;

		/**
			Indicates a protocol error.
		**/
		var EPROTO:Int;

		/**
			Indicates that a protocol is not supported.
		**/
		var EPROTONOSUPPORT:Int;

		/**
			Indicates the wrong type of protocol for a socket.
		**/
		var EPROTOTYPE:Int;

		/**
			Indicates that the results are too large.
		**/
		var ERANGE:Int;

		/**
			Indicates that the file system is read only.
		**/
		var EROFS:Int;

		/**
			Indicates an invalid seek operation.
		**/
		var ESPIPE:Int;

		/**
			Indicates that there is no such process.
		**/
		var ESRCH:Int;

		/**
			Indicates that the file handle is stale.
		**/
		var ESTALE:Int;

		/**
			Indicates an expired timer.
		**/
		var ETIME:Int;

		/**
			Indicates that the connection timed out.
		**/
		var ETIMEDOUT:Int;

		/**
			Indicates that a text file is busy.
		**/
		var ETXTBSY:Int;

		/**
			Indicates that the operation would block.
		**/
		var EWOULDBLOCK:Int;

		/**
			Indicates an improper link.
		**/
		var EXDEV:Int;

		/**
			Indicates an interrupted function call.
		**/
		var WSAEINTR:Int;

		/**
			Indicates an invalid file handle.
		**/
		var WSAEBADF:Int;

		/**
			Indicates insufficient permissions to complete the operation.
		**/
		var WSAEACCES:Int;

		/**
			Indicates an invalid pointer address.
		**/
		var WSAEFAULT:Int;

		/**
			Indicates that an invalid argument was passed.
		**/
		var WSAEINVAL:Int;

		/**
			Indicates that there are too many open files.
		**/
		var WSAEMFILE:Int;

		/**
			Indicates that a resource is temporarily unavailable.
		**/
		var WSAEWOULDBLOCK:Int;

		/**
			Indicates that an operation is currently in progress.
		**/
		var WSAEINPROGRESS:Int;

		/**
			Indicates that an operation is already in progress.
		**/
		var WSAEALREADY:Int;

		/**
			Indicates that the resource is not a socket.
		**/
		var WSAENOTSOCK:Int;

		/**
			Indicates that a destination address is required.
		**/
		var WSAEDESTADDRREQ:Int;

		/**
			Indicates that the message size is too long.
		**/
		var WSAEMSGSIZE:Int;

		/**
			Indicates the wrong protocol type for the socket.
		**/
		var WSAEPROTOTYPE:Int;

		/**
			Indicates a bad protocol option.
		**/
		var WSAENOPROTOOPT:Int;

		/**
			Indicates that the protocol is not supported.
		**/
		var WSAEPROTONOSUPPORT:Int;

		/**
			Indicates that the socket type is not supported.
		**/
		var WSAESOCKTNOSUPPORT:Int;

		/**
			Indicates that the operation is not supported.
		**/
		var WSAEOPNOTSUPP:Int;

		/**
			Indicates that the protocol family is not supported.
		**/
		var WSAEPFNOSUPPORT:Int;

		/**
			Indicates that the address family is not supported.
		**/
		var WSAEAFNOSUPPORT:Int;

		/**
			Indicates that the network address is already in use.
		**/
		var WSAEADDRINUSE:Int;

		/**
			Indicates that the network address is not available.
		**/
		var WSAEADDRNOTAVAIL:Int;

		/**
			Indicates that the network is down.
		**/
		var WSAENETDOWN:Int;

		/**
			Indicates that the network is unreachable.
		**/
		var WSAENETUNREACH:Int;

		/**
			Indicates that the network connection has been reset.
		**/
		var WSAENETRESET:Int;

		/**
			Indicates that the connection has been aborted.
		**/
		var WSAECONNABORTED:Int;

		/**
			Indicates that the connection has been reset by the peer.
		**/
		var WSAECONNRESET:Int;

		/**
			Indicates that there is no buffer space available.
		**/
		var WSAENOBUFS:Int;

		/**
			Indicates that the socket is already connected.
		**/
		var WSAEISCONN:Int;

		/**
			Indicates that the socket is not connected.
		**/
		var WSAENOTCONN:Int;

		/**
			Indicates that data cannot be sent after the socket has been shutdown.
		**/
		var WSAESHUTDOWN:Int;

		/**
			Indicates that there are too many references.
		**/
		var WSAETOOMANYREFS:Int;

		/**
			Indicates that the connection has timed out.
		**/
		var WSAETIMEDOUT:Int;

		/**
			Indicates that the connection has been refused.
		**/
		var WSAECONNREFUSED:Int;

		/**
			Indicates that a name cannot be translated.
		**/
		var WSAELOOP:Int;

		/**
			Indicates that a name was too long.
		**/
		var WSAENAMETOOLONG:Int;

		/**
			Indicates that a network host is down.
		**/
		var WSAEHOSTDOWN:Int;

		/**
			Indicates that there is no route to a network host.
		**/
		var WSAEHOSTUNREACH:Int;

		/**
			Indicates that the directory is not empty.
		**/
		var WSAENOTEMPTY:Int;

		/**
			Indicates that there are too many processes.
		**/
		var WSAEPROCLIM:Int;

		/**
			Indicates that the user quota has been exceeded.
		**/
		var WSAEUSERS:Int;

		/**
			Indicates that the disk quota has been exceeded.
		**/
		var WSAEDQUOT:Int;

		/**
			Indicates a stale file handle reference.
		**/
		var WSAESTALE:Int;

		/**
			Indicates that the item is remote.
		**/
		var WSAEREMOTE:Int;

		/**
			Indicates that the network subsystem is not ready.
		**/
		var WSASYSNOTREADY:Int;

		/**
			Indicates that the winsock.dll version is out of range.
		**/
		var WSAVERNOTSUPPORTED:Int;

		/**
			Indicates that successful WSAStartup has not yet been performed.
		**/
		var WSANOTINITIALISED:Int;

		/**
			Indicates that a graceful shutdown is in progress.
		**/
		var WSAEDISCON:Int;

		/**
			Indicates that there are no more results.
		**/
		var WSAENOMORE:Int;

		/**
			Indicates that an operation has been canceled.
		**/
		var WSAECANCELLED:Int;

		/**
			Indicates that the procedure call table is invalid.
		**/
		var WSAEINVALIDPROCTABLE:Int;

		/**
			Indicates an invalid service provider.
		**/
		var WSAEINVALIDPROVIDER:Int;

		/**
			Indicates that the service provider failed to initialized.
		**/
		var WSAEPROVIDERFAILEDINIT:Int;

		/**
			Indicates a system call failure.
		**/
		var WSASYSCALLFAILURE:Int;

		/**
			Indicates that a service was not found.
		**/
		var WSASERVICE_NOT_FOUND:Int;

		/**
			Indicates that a class type was not found.
		**/
		var WSATYPE_NOT_FOUND:Int;

		/**
			Indicates that there are no more results.
		**/
		var WSA_E_NO_MORE:Int;

		/**
			Indicates that the call was canceled.
		**/
		var WSA_E_CANCELLED:Int;

		/**
			Indicates that a database query was refused.
		**/
		var WSAEREFUSED:Int;
	};

	/**
		libuv-specific constant
	**/
	var UV_UDP_REUSEADDR:Int;
}

/**
	Provides a number of operating system-related utility methods
**/
@:jsRequire("os")
extern class Os {
	/**
		A string constant defining the operating system-specific end-of-line marker:

		* `\n` on POSIX
		* `\r\n` on Windows
	**/
	static var EOL(default,null):String;

	/**
		Returns an object containing commonly used operating system specific constants for error codes,
		process signals, and so on.
	**/
	static var constants(default,null):OsConstants;

	/**
		Returns a string specifying the operating system's default directory for temporary files.
	**/
	static function tmpdir():String;

	/**
		Returns a string identifying the endianness of the CPU for which the Node.js binary was compiled.
	**/
	static function endianness():Endianness;

	/**
		Returns the home directory of the current user.
	**/
	static function homedir():String;

	/**
		Returns the hostname of the operating system.
	**/
	static function hostname():String;

	/**
		Returns a string identifying the operating system name as returned by `uname(3)`.

		For example 'Linux' on Linux, 'Darwin' on OS X and 'Windows_NT' on Windows.

		Please see https://en.wikipedia.org/wiki/Uname#Examples for additional information about
		the output of running `uname(3)` on various operating systems.
	**/
	static function type():String;

	/**
		Returns a string identifying the operating system platform as set during compile time of Node.js.

		Currently possible values are:
		* 'aix'
		* 'darwin'
		* 'freebsd'
		* 'linux'
		* 'openbsd'
		* 'sunos'
		* 'win32'

		Note: The value 'android' may also be returned if the Node.js is built on the Android operating system.
		However, Android support in Node.js is considered to be experimental at this time.
	**/
	static function platform():String;

	/**
		Returns a string identifying the operating system CPU architecture for which the Node.js binary was compiled.

		The current possible values are: 'arm', 'arm64', 'ia32', 'mips', 'mipsel', 'ppc', 'ppc64', 's390', 's390x', 'x32', 'x64', and 'x86'.
	**/
	static function arch():String;

	/**
		Returns a string identifying the operating system release.

		Note: On POSIX systems, the operating system release is determined by calling `uname(3)`.
		On Windows, `GetVersionExW()` is used. Please see https://en.wikipedia.org/wiki/Uname#Examples for more information.
	**/
	static function release():String;

	/**
		Returns the system uptime in number of seconds.

		Note: Within Node.js' internals, this number is represented as a double. However, fractional seconds are not
		returned and the value can typically be treated as an integer.
	**/
	static function uptime():Int;

	/**
		Returns information about the currently effective user -- on POSIX platforms, this is typically a subset of the password file.
	**/
	static function userInfo(?options:{encoding:String}):OsUserInfo;

	/**
		Returns an array containing the 1, 5, and 15 minute load averages.

		The load average is a measure of system activity, calculated by the operating system and expressed as a fractional number.
		As a rule of thumb, the load average should ideally be less than the number of logical CPUs in the system.

		The load average is a UNIX-specific concept with no real equivalent on Windows platforms.
		On Windows, the return value is always `[0, 0, 0]`.
	**/
	static function loadavg():Array<Float>;

	/**
		Returns the total amount of system memory in bytes.
	**/
	static function totalmem():Float;

	/**
		Returns the amount of free system memory in bytes.
	**/
	static function freemem():Float;

	/**
		Returns an array of objects containing information about each CPU/core installed.
	**/
	static function cpus():Array<CPU>;

	/**
		Returns an object containing only network interfaces that have been assigned a network address.
	**/
	static function networkInterfaces():haxe.DynamicAccess<NetworkInterface>;
}
