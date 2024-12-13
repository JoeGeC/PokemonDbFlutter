import 'package:domain/domain.dart';
import '../models/pokedex_group_presentation_model.dart';
import '../models/pokedex_presentation_model.dart';

abstract class PokedexPresentationConverter {
  PokedexPresentationModel convert(PokedexModel pokedex);

  List<PokedexGroupPresentationModel> convertAndOrder(
      List<PokedexModel> pokedex);
}
