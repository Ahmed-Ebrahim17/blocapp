import 'package:blocapp/data/repository/characters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/character.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Result> characters = [];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Result> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
}
