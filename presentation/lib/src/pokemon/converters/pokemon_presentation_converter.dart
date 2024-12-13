import 'package:domain/domain.dart';

import '../models/pokemon_presentation_model.dart';

abstract class PokemonPresentationConverter{
  PokemonPresentationModel convert(PokemonModel pokemon);
}