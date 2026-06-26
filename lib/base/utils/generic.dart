extension NullCheck<T> on T? {
  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    }
    if (this is String) {
      if (this == "") {
        return true;
      }
    }
    if (this is double && this == 0) {
      return true;
    }

    return false;
  }
}
