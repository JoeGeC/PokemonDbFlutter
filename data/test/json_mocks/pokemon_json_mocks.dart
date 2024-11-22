class PokemonJsonMocks {

  static Map<String, dynamic> pokemonJson(int id, String name,
      String type1, String type2, String frontSpriteUrl) =>
      {
        "id": id,
        "name": name,
        "sprites": {
          "front_default": frontSpriteUrl,
        },
        "types": [
          {
            "slot": 1,
            "type": {
              "name": type1,
              "url": ""
            }
          },
          {
            "slot": 2,
            "type": {
              "name": type2,
              "url": ""
            }
          },
        ],
      };
}
