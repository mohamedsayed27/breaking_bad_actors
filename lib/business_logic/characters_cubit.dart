import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/data/models/characters_model.dart';

import '../data/repositories/characters_repository.dart';
import 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository myCharactersRepository;
  List<CharactersModel> characters =[];
  CharactersCubit(this.myCharactersRepository) : super(CharactersInitial());

  List<CharactersModel> getAllCharacters() {
    myCharactersRepository.getAllCharacters().then((value) {
      emit(CharactersLoaded(value));
      characters = value;
    });
    return characters;
  }
  //tring

   void getCharacterQuotes(String charName) {
    myCharactersRepository.getCharacterQuotes(charName).then((value) {
      emit(QuoteLoaded(value));
    });
  }

  static CharactersCubit get(context) => BlocProvider.of(context);
}
