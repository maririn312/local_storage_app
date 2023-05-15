class AuthResponseException implements Exception {
  String failure;

  AuthResponseException(this.failure);

  @override
  String toString() => failure;
}
