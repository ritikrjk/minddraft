import 'dart:math';

class IdGenerator {
  static const String _chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  static final Random _random = Random.secure();

  /// Generates a unique ID with specified length
  static String generateId({int length = 16}) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(_random.nextInt(_chars.length)),
      ),
    );
  }

  /// Generates a timestamp-based ID for better sorting
  static String generateTimestampId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = _random.nextInt(10000);
    return '${timestamp}_$random';
  }

  /// Generates a UUID-like ID
  static String generateUUID() {
    return '${_generateSegment(8)}-${_generateSegment(4)}-${_generateSegment(4)}-${_generateSegment(4)}-${_generateSegment(12)}';
  }

  static String _generateSegment(int length) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(_random.nextInt(_chars.length)),
      ),
    );
  }
}
