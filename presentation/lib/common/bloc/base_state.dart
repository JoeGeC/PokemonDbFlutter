abstract class BaseState {}

class InitialState extends BaseState {}

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

class SuccessState extends BaseState {}