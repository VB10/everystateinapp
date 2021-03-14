class WidgetNotFoundException<T> implements Exception {
  final T model;

  WidgetNotFoundException(this.model);
  @override
  String toString() {
    return 'No has found network path: $model';
  }
}
