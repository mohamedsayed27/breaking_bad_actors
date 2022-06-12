import 'package:flutter_breaking/data/models/characters_model.dart';
import 'package:flutter_breaking/data/models/quote_model.dart';

import '../web_services/characters_web_services.dart';

class CharactersRepository {
  final CharacterWebServices characterWebServices;

  CharactersRepository(this.characterWebServices);

  Future<List<CharactersModel>> getAllCharacters() async {
    final character = await characterWebServices.getAllCharacters();
    return character.map( (e) => CharactersModel.fromJson(e) ).toList();
  }

  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final quote = await characterWebServices.getCharacterQuotes(charName);
    return quote.map( (e) => Quote.fromJson(e) ).toList();
  }


  // Future<List<Quote>> getQuotes(String charName) async {
  //   final quote = await characterWebServices.getQuotes(charName);
  //   return quote.map((e) => Quote.fromJson(e)).toList();
  // }
}
