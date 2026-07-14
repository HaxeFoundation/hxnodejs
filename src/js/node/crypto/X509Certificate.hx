/*
 * Copyright (C)2014-2026 Haxe Foundation
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

	@see https://nodejs.org/docs/latest-v24.x/api/crypto.html#class-x509certificate
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
	final fingerprint:String;

	/**
		The SHA-256 fingerprint of this certificate.
	**/
	final fingerprint256:String;

	/**
		The SHA-512 fingerprint of this certificate.
	**/
	final fingerprint512:String;

	/**
		The issuer identification included in this certificate.
	**/
	final issuer:String;

	/**
		The issuer certificate corresponding to this certificate, if available.
	**/
	@:optional final issuerCertificate:X509Certificate;

	/**
		The subject identification included in this certificate.
	**/
	final subject:String;

	/**
		The subject alternative names included in this certificate.
	**/
	@:optional final subjectAltName:String;

	/**
		Information access information for this certificate.
	**/
	@:optional final infoAccess:String;

	/**
		The date/time from which this certificate is valid (ISO string).
	**/
	final validFrom:String;

	/**
		The date/time until which this certificate is valid (ISO string).
	**/
	final validTo:String;

	/**
		The date from which this certificate is valid.
	**/
	final validFromDate:js.lib.Date;

	/**
		The date until which this certificate is valid.
	**/
	final validToDate:js.lib.Date;

	/**
		The serial number of this certificate.
	**/
	final serialNumber:String;

	/**
		The algorithm used to sign this certificate.
	**/
	final signatureAlgorithm:String;

	/**
		The OID of the algorithm used to sign this certificate.
	**/
	final signatureAlgorithmOid:String;

	/**
		The raw DER bytes of this certificate.
	**/
	final raw:Buffer;

	/**
		The public key of this certificate.
	**/
	final publicKey:KeyObject;

	/**
		`true` if this is a Certificate Authority (CA) certificate.
	**/
	final ca:Bool;

	/**
		Key usages for this certificate, if any.
	**/
	final keyUsage:Array<String>;

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
		Verifies that this certificate was signed by the given public key.
	**/
	function verify(publicKey:KeyObject):Bool;

	/**
		PEM encoding of this certificate.
	**/
	function toString():String;

	/**
		Legacy encoding used by older Node.js versions / JSON serialization helper.
	**/
	function toJSON():String;

	/**
		Returns an information object representing this certificate for compatibility with legacy APIs.
	**/
	function toLegacyObject():Any;
}

/**
	Options for `X509Certificate` host/email checks.
**/
typedef X509CheckOptions = {
	@:optional final subject:String;
	@:optional final wildcards:Bool;
	@:optional final partialWildcards:Bool;
	@:optional final multiLabelWildcards:Bool;
	@:optional final singleLabelSubdomains:Bool;
}
