import '../models/exceptions/NullException.dart';

abstract class BaseRepositoryConverter {
  int getIdFromUrl(String? pokemonUrl) {
    if (pokemonUrl == null) throw NullException(NullType.id);
    RegExp regex = RegExp(r'(\d+)/$');
    final match = regex.firstMatch(pokemonUrl);
    if (match == null) {
      throw NullException(NullType.id);
    } else {
      return int.parse(match.group(1)!);
    }
  }
}