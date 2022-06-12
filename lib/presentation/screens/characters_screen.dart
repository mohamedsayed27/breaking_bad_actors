import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/characters_cubit.dart';
import 'package:flutter_breaking/business_logic/characters_state.dart';
import 'package:flutter_breaking/constants/colors.dart';
import 'package:flutter_breaking/data/models/characters_model.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharactersModel> allCharacters;

  late List<CharactersModel> searchedCharacters;

  bool isSearching = false;

  final searchController = TextEditingController();

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: AppColors.myGrey,
      decoration: const InputDecoration(
          hintText: 'Input Character"s Name ....',
          border: InputBorder.none,
          hintStyle: TextStyle(color: AppColors.myGrey, fontSize: 18)),
      style: const TextStyle(color: AppColors.myGrey, fontSize: 18),
      onChanged: (searchCharacter) {
        addSearchedCharacterToList(searchCharacter);
      },
    );
  }

  void addSearchedCharacterToList(searchedCharacter) {
    searchedCharacters = allCharacters
        .where((element) =>
            element.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
            onPressed: () {
              clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear))
      ];
    } else {
      return [
        IconButton(onPressed: startSearch, icon: const Icon(Icons.search))
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  Widget buildAppBarTitle() {
    return const Text('Characters');
  }

  Widget buildOfflineWidget() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You aren\'t connected to the internet......',
              style: TextStyle(fontSize: 20, color: AppColors.myGrey),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/no internet.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    allCharacters = CharactersCubit.get(context).getAllCharacters();
    return Scaffold(
      appBar: AppBar(
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
        backgroundColor: AppColors.myYellow,
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return myBuilder();
          } else {
            return buildOfflineWidget();
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget myBuilder() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidget();
        } else {
          return showProgressIndicator();
        }
      },
    );
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.myGrey,
        child: Column(
          children: [
            buildCharactersGridView(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersGridView() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: searchController.text.isEmpty
            ? allCharacters.length
            : searchedCharacters.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return CharacterItem(
              charactersModel: searchController.text.isEmpty
                  ? allCharacters[index]
                  : searchedCharacters[index]);
        });
  }
}
