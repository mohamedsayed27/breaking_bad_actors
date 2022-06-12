import 'package:flutter/material.dart';
import 'package:flutter_breaking/constants/colors.dart';
import 'package:flutter_breaking/data/models/characters_model.dart';

import '../../constants/strings.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({Key? key, required this.charactersModel}) : super(key: key);
  final CharactersModel charactersModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: AppColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, detailsCharacterScreen,arguments: charactersModel),
        child: GridTile(
          child: Hero(
            tag: charactersModel.id,
            child: Container(
                color: AppColors.myGrey,
                child: charactersModel.image.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/loading1.gif',
                        image: charactersModel.image)
                    : Image.asset(
                        'assets/images/04.jpg',
                      )),
          ),
          footer: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                charactersModel.name,
                style: const TextStyle(
                    color: AppColors.myWhite,
                    height: 1.3,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              )),
        ),
      ),
    );
  }
}
