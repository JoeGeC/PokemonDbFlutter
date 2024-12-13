abstract class BaseState {}

class InitialState extends BaseState {}

class LoadingState extends BaseState {
  @override
  bool operator ==(Object other) {
    return other is LoadingState;
  }
}

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

class CompletedState extends BaseState {
  final BaseState lastState;

  CompletedState(this.lastState);

  @override
  bool operator ==(Object other) {
    return other is CompletedState && lastState == other.lastState;
  }

  @override
  int get hashCode => lastState.hashCode;
}