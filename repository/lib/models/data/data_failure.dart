import 'package:equatable/equatable.dart';

class DataFailure extends Equatable {
  final String? errorMessage;

  const DataFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
