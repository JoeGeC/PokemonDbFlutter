import 'package:domain/models/pokedex_model.dart';
import '../models/pokedex_presentation_model.dart';

abstract class PokedexPresentationConverter {
  PokedexPresentationModel convert(PokedexModel pokedex);

  Map<String, List<PokedexPresentationModel>> convertAndOrder(
      List<PokedexModel> pokedex);
}
