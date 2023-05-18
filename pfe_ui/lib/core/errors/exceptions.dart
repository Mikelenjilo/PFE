class DjangoException implements Exception {
  final String message;

  const DjangoException(this.message);

  @override
  String toString() => 'LocalDatabaseException: $message';
}
