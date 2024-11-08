abstract class DataModel{
  bool notRuntimeType(Object other) => other.runtimeType != runtimeType;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (notRuntimeType(other)) return false;
    return false;
  }
}