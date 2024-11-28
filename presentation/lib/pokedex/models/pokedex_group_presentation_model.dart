import 'package:collection/collection.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';

import '../../common/models/expandable.dart';

class PokedexGroupPresentationModel extends Expandable {
  final String title;
  final List<PokedexPresentationModel> pokedexList;

  PokedexGroupPresentationModel(this.title, this.pokedexList);

  @override
  bool operator ==(Object other) {
    return other is PokedexGroupPresentationModel
        && title == other.title
        && ListEquality().equals(pokedexList, other.pokedexList);
  }

  @override
  int get hashCode => Object.hash(title, pokedexList);

}