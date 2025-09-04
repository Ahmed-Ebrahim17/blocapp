import 'package:blocapp/bussiness_logic/cubit/characters_cubit.dart';
import 'package:blocapp/constants/strings.dart';
import 'package:blocapp/data/repository/characters_repository.dart';
import 'package:blocapp/data/web_services/characters_web_services.dart';
import 'package:blocapp/presentation/screens/characters_details.dart';
import 'package:blocapp/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  late CharactersCubit charactersCubit;
  late CharactersRepository charactersRepository;
  AppRoute() {
    charactersRepository = CharactersRepository(CharactersWebServices());

    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case charactersDetalisScreen:
        return MaterialPageRoute(
            builder: (_) => const CharactersDetailsScreen());
    }
    return null;
  }
}
