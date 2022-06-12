import 'package:flutter_breaking/data/models/characters_model.dart';
import 'package:flutter_breaking/data/models/quote_model.dart';

abstract class CharactersState{}
class CharactersInitial extends CharactersState{}
class CharactersLoaded extends CharactersState{
  final List<CharactersModel> characters;
  CharactersLoaded(this.characters);
}

class QuoteLoaded extends CharactersState{
  final List<Quote> quotes;
  QuoteLoaded(this.quotes);
}