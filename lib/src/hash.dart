import 'dart:convert';

import 'package:crypto/crypto.dart';

String generatePaynowHash(String payloadString) {
  final payloadBytes = utf8.encode(payloadString);
  final hexDigest = sha512.convert(payloadBytes);
  return hexDigest.toString().toUpperCase();
}
