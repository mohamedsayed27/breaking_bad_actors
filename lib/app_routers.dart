import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/characters_cubit.dart';
import 'package:flutter_breaking/data/models/characters_model.dart';
import 'package:flutter_breaking/data/web_services/characters_web_services.dart';
import 'package:flutter_breaking/presentation/screens/character_details.dart';
import 'constants/strings.dart';
import 'data/repositories/characters_repository.dart';
import 'presentation/screens/characters_screen.dart';

class AppRouters{
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  late CharactersModel charactersModel;

  AppRouters(){
    charactersRepository = CharactersRepository(CharacterWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }


  Route? generateRoute(RouteSettings settings){
    switch(settings.name) {
      case charactersScreen :
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                    create: (BuildContext context) => charactersCubit ,
                  child:   const CharactersScreen(),
                )

        );
      case detailsCharacterScreen :
        final charactersModel = settings.arguments as CharactersModel;
        return MaterialPageRoute(
            builder: (_) =>  BlocProvider(
              create: (BuildContext context ) => CharactersCubit(charactersRepository)..getCharacterQuotes(charactersModel.name),
                child: CharactersDetailsScreen(charactersModel: charactersModel,))
        );
    }
    return null;
  }
}