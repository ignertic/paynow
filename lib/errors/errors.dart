// remove

class HashMismatchException implements Exception {
  final String cause;
  HashMismatchException(this.cause);
}

class ValueError implements Exception {
  final String cause;
  ValueError(this.cause);
}
