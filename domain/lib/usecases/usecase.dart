import 'package:dartz/dartz.dart';
import '../models/Failure.dart';

abstract class UseCase<T> {
  Future<Either<Failure, T>> call();
}