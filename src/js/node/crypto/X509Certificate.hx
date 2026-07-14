/*
 * Copyright (C)2014-2020 Haxe Foundation
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

package js.node.crypto;

import haxe.extern.EitherType;
import js.node.Buffer;

/**
	Encapsulates an X509 certificate and provides read-only access to its information.

	@see https://nodejs.org/api/crypto.html#class-x509certificate
**/
@:jsRequire("crypto", "X509Certificate")
extern class X509Certificate {
	/**
		Creates a new `X509Certificate` object from PEM or DER encoded data.
	**/
	function new(buffer:EitherType<String, EitherType<Buffer, js.lib.ArrayBufferView>>);

	/**
		The SHA-1 fingerprint of this certificate.
	**/
	var fingerprint(default, never):String;

	/**
		The SHA-256 fingerprint of this certificate.
	**/
	var fingerprint256(default, never):String;

	/**
		The SHA-512 fingerprint of this certificate.
	**/
	var fingerprint512(default, never):String;

	/**
		The issuer identification included in this certificate.
	**/
	var issuer(default, never):String;

	/**
		The subject identification included in this certificate.
	**/
	var subject(default, never):String;

	/**
		The subject alternative names included in this certificate.
	**/
	@:optional var subjectAltName(default, never):String;

	/**
		Information access information for this certificate.
	**/
	@:optional var infoAccess(default, never):String;

	/**
		The date/time from which this certificate is valid (ISO string).
	**/
	var validFrom(default, never):String;

	/**
		The date/time until which this certificate is valid (ISO string).
	**/
	var validTo(default, never):String;

	/**
		The date from which this certificate is valid.
	**/
	var validFromDate(default, never):js.lib.Date;

	/**
		The date until which this certificate is valid.
	**/
	var validToDate(default, never):js.lib.Date;

	/**
		The serial number of this certificate.
	**/
	var serialNumber(default, never):String;

	/**
		The algorithm used to sign this certificate.
	**/
	var signatureAlgorithm(default, never):String;

	/**
		The raw DER bytes of this certificate.
	**/
	var raw(default, never):Buffer;

	/**
		The public key of this certificate.
	**/
	var publicKey(default, never):KeyObject;

	/**
		`true` if this is a Certificate Authority (CA) certificate.
	**/
	var ca(default, never):Bool;

	/**
		Key usages for this certificate, if any.
	**/
	var keyUsage(default, never):Array<String>;

	/**
		Checks whether the certificate matches the given host name.
	**/
	function checkHost(name:String, ?options:X509CheckOptions):Null<String>;

	/**
		Checks whether the certificate matches the given email address.
	**/
	function checkEmail(email:String, ?options:X509CheckOptions):Null<String>;

	/**
		Checks whether the certificate matches the given IP address (IPv4 or IPv6).
	**/
	function checkIP(ip:String):Null<String>;

	/**
		Checks whether this certificate was issued by the given `otherCert`.
	**/
	function checkIssued(otherCert:X509Certificate):Bool;

	/**
		Checks whether the public key for this certificate matches the given private key.
	**/
	function checkPrivateKey(privateKey:KeyObject):Bool;

	/**
		PEM encoding of this certificate.
	**/
	function toString():String;

	/**
		Legacy encoding used by older Node.js versions / JSON serialization helper.
	**/
	function toJSON():String;
}

/**
	Options for `X509Certificate` host/email checks.
**/
typedef X509CheckOptions = {
	@:optional var subject:String;
	@:optional var wildcards:Bool;
	@:optional var partialWildcards:Bool;
	@:optional var multiLabelWildcards:Bool;
	@:optional var singleLabelSubdomains:Bool;
}
