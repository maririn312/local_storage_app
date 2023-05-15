class BadResponseException implements Exception {
  String cause;
  BadResponseException(this.cause);

  @override
  String toString() => cause;
}
