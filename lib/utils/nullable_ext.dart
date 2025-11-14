extension NullableExt<T> on T? {
  R? let<R>(R Function(T self) mapper) {
    final _self = this;
    return _self != null ? mapper(_self) : null;
  }
}
