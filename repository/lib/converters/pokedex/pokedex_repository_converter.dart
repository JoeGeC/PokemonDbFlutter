import 'package:domain/models/pokedex.dart';
import '../../models/pokedex_data.dart';

abstract class PokedexRepositoryConverter{
  Pokedex convert(PokedexData pokedexData);
}