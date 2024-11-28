import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';

class PokedexGroupPresentationModel extends Expandable {
  final String title;
  final List<PokedexPresentationModel> pokedexList;

  PokedexGroupPresentationModel(this.title, this.pokedexList);

  void toggleExpanded() {

  }
}

abstract class Expandable {
  bool isExpanded = false;
}