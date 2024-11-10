import 'package:domain/models/pokedex_model.dart';
import '../models/pokedex_local_model.dart';

abstract class PokedexLocalConverter {
  PokedexLocalModel convert(PokedexModel pokedexDomain);
}
