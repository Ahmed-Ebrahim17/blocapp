import 'package:blocapp/data/models/character.dart';
import 'package:blocapp/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Result>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map<Result>((character) => Result.fromJson(character))
        .toList();
  }
}
