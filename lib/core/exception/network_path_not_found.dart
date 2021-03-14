import '../feature/comments_service.dart';

class NetworkPathException implements Exception {
  final NetworkPath path;

  NetworkPathException(this.path);
  @override
  String toString() {
    return 'No has found network path: $path';
  }
}
