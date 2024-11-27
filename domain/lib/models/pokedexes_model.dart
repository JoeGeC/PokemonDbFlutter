import 'package:equatable/equatable.dart';

class PokedexesModel extends Equatable {
  final int id;
  final String region;
  final List<String> versions;

  const PokedexesModel(
      {required this.id, required this.region, required this.versions});

  @override
  List<Object?> get props => throw UnimplementedError();
}
