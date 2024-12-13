import 'package:domain/models/pokemon_model.dart';

import '../models/pokemon_presentation_model.dart';

abstract class PokemonPresentationConverter{
  PokemonPresentationModel convert(PokemonModel pokemon);
}