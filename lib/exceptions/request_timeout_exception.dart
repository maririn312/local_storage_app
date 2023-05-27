class RequestTimeoutException implements Exception {
  final String url;

  RequestTimeoutException(this.url);

  @override
  String toString() => 'Language.EXCEPTION_TIMEOUT_OR_SOCKET';
}
