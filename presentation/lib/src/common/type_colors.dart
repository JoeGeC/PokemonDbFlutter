import 'package:flutter/material.dart';
import 'package:presentation/src/l10n/gen/presentation_localizations.dart';

Color getTypeColor(String? type, PresentationLocalizations localizations) {
  final typeColors = {
      localizations.normal: Color(0xFF7A7C80),
      localizations.fire: Color(0xFFE53C20),
      localizations.water: Color(0xFF2F8AE6),
      localizations.electric: Color(0xFFE5B72E),
      localizations.grass: Color(0xFF6BB74D),
      localizations.ice: Color(0xFF5CB7E5),
      localizations.fighting: Color(0xFFA84D3D),
      localizations.poison: Color(0xFF994D8A),
      localizations.ground: Color(0xFFC7A84E),
      localizations.flying: Color(0xFF7A89E5),
      localizations.psychic: Color(0xFFE54D8A),
      localizations.bug: Color(0xFF98A91F),
      localizations.rock: Color(0xFFA79A5C),
      localizations.ghost: Color(0xFF5C5CA8),
      localizations.dragon: Color(0xFF6A5BD6),
      localizations.dark: Color(0xFF6B4D3E),
      localizations.steel: Color(0xFF9999A8),
      localizations.fairy: Color(0xFFD68AD5),
    };
  return typeColors[type] ?? Color(0xFF7A7C80);
}

Color getTypeBorderColor(String? type, PresentationLocalizations localizations) {
      final typeBorderColors = {
            localizations.normal: Color(0xFF6B6D70),
            localizations.fire: Color(0xFFBA3318),
            localizations.water: Color(0xFF2776C2),
            localizations.electric: Color(0xFFD19E28),
            localizations.grass: Color(0xFF5C9E40),
            localizations.ice: Color(0xFF4CA0C2),
            localizations.fighting: Color(0xFF8E4234),
            localizations.poison: Color(0xFF853F77),
            localizations.ground: Color(0xFFAB8F45),
            localizations.flying: Color(0xFF6A78C2),
            localizations.psychic: Color(0xFFD14579),
            localizations.bug: Color(0xFF828E19),
            localizations.rock: Color(0xFF8F8451),
            localizations.ghost: Color(0xFF504A91),
            localizations.dragon: Color(0xFF5C4DBA),
            localizations.dark: Color(0xFF5E4335),
            localizations.steel: Color(0xFF868686),
            localizations.fairy: Color(0xFFC07EBF),
      };
      return typeBorderColors[type] ?? Color(0xFF6B6D70);
}



