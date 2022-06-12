import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/characters_cubit.dart';
import 'package:flutter_breaking/business_logic/characters_state.dart';
import 'package:flutter_breaking/constants/colors.dart';
import 'package:flutter_breaking/data/models/characters_model.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final CharactersModel charactersModel;
  const CharactersDetailsScreen({Key? key,required this.charactersModel}) : super(key: key);


  Widget buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
            charactersModel.nickName,
            style: const TextStyle(color: AppColors.myWhite),
          ),

        centerTitle: true,
        background: Hero(
            tag: charactersModel.id,
            child: Image.network(charactersModel.image,fit: BoxFit.cover,)),
      ),
    );
  }

  Widget characterInformation(String title , String value){
    return RichText(
      maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                  color: AppColors.myWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                  color: AppColors.myWhite,
                  fontSize: 16,
              ),
            ),
          ]
        )
    );
  }

  Widget dividerBuilder(double endIndent){
    return Divider(
      color: AppColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget columnOfBetterCallSaulAppearance(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        characterInformation('Actor/Actress name : ', charactersModel.betterCallSaulAppearance.join(' / ')),
        dividerBuilder(160),
      ],
    );
  }

  Widget checkIfQuoteLoadedOrNot(CharactersState state){
    if(state is QuoteLoaded){
      return displayRandomQuoteOrEmptySpace(state);
    }else{
      return const Center(child: CircularProgressIndicator(color: AppColors.myYellow,));
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state){
    var quotes = (state).quotes;

    if(quotes.length !=0){
      int randomQuoteIndex = Random().nextInt(quotes.length-1);
      return Center(
        child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.myWhite,
              shadows: [
                Shadow(
                  blurRadius: 7,
                  color: AppColors.myYellow,
                  offset: Offset(0, 0),
                )
              ]
            ),
            child: AnimatedTextKit(
              repeatForever: true,
                animatedTexts: [
                  FlickerAnimatedText(quotes[randomQuoteIndex].quote),
                ]
            )
        ),
      );
    }else{
      return Container();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          characterInformation('Jobs : ', charactersModel.jobs.join(' / ')),
                          dividerBuilder(290),
                          characterInformation('Appeared in : ', charactersModel.categoryForTwoSeries),
                          dividerBuilder(230),
                          characterInformation('Season : ', charactersModel.appearanceOfSeason.join(' / ')),
                          dividerBuilder(270),
                          characterInformation('Status : ', charactersModel.statusIfDeadOrAlive),
                          dividerBuilder(275),
                          charactersModel.betterCallSaulAppearance.isEmpty? Container(height: 0,) : columnOfBetterCallSaulAppearance(),
                          characterInformation('Actor/Actress name : ', charactersModel.name),
                          dividerBuilder(160),
                          const SizedBox(height: 10,),
                          BlocBuilder<CharactersCubit,CharactersState>(
                              builder: (context,state){
                                return checkIfQuoteLoadedOrNot(state);
                              }
                              ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 500,)
                  ]
              ),
          )
        ],
      ),
    );
  }
}
