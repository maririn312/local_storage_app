class DebugStateException implements Exception {
  String cause;
  String info;

  DebugStateException({this.cause, this.info});

  @override
  String toString() => '$cause + $info';
}
