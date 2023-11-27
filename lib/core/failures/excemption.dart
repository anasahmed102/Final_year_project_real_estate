// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerException implements Exception {
  final String message;
  ServerException({
    required this.message,
  });
}

class EmptycacheException implements Exception {
  final String message;
  EmptycacheException({
    required this.message,
  });
}

class OfflineException implements Exception {
  final String message;
  OfflineException({
    required this.message,
  });
}

class CacheException implements Exception {}


class InvalidDataException implements Exception {}

class CanceledByUserException implements Exception {}

class NotFoundException implements Exception {}

class InvalidDateException implements Exception {}

class FirebaseDataException implements Exception {
  final String message;

  FirebaseDataException(this.message);
}
