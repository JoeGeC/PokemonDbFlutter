abstract class BaseState {}

class LoadingState extends BaseState {}

class ErrorState extends BaseState {
  final String? errorMessage;

  ErrorState(this.errorMessage);

  @override
  bool operator ==(Object other) {
    return other is ErrorState && errorMessage == other.errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}
