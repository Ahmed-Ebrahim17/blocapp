import 'package:blocapp/bussiness_logic/cubit/characters_cubit.dart';
import 'package:blocapp/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/character.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Result> allCharacters = [];
  List<Result> searchedForCharacters = [];
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  void addCharactersSearchedList(String characterSearch) {
    searchedForCharacters = allCharacters
        .where((e) => e.name.toLowerCase().startsWith(characterSearch))
        .toList();
    setState(() {});
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: "Find a character",
        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
        border: InputBorder.none,
      ),
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      onChanged: (searchedCharacter) {
        addCharactersSearchedList(searchedCharacter);
      },
    );
  }

  List<Widget> _buildActionsAppBar() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        )
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  Widget buildBlocBody() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildLoadedListwidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
        child: CircularProgressIndicator(
      color: MyColors.secondryColor,
    ));
  }

  Widget buildLoadedListwidgets() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            buildLoadedCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildLoadedCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
        itemBuilder: (ctx, index) {
          return CharacterItem(
            result: _searchController.text.isEmpty
                ? allCharacters[index]
                : searchedForCharacters[index],
            index: index,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: MyColors.secondryColor,
        title: _isSearching
            ? _buildSearchField()
            : const Text(
                "Characters",
                style: TextStyle(
                    color: MyColors.myWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
        elevation: 0,
        actions: _buildActionsAppBar(),
      ),
      body: buildBlocBody(),
    );
  }
}
