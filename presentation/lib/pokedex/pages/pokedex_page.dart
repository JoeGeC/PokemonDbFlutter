import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokemon_model.dart';
import 'package:domain/usecases/pokedex_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/pokedex/bloc/pokedex_bloc.dart';
import '../../common/pages/empty_page.dart';
import '../../common/pages/error_page.dart';
import '../../common/loading_page.dart';
import '../../injections.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  final PokedexBloc _bloc =
      PokedexBloc(pokedexUseCase: getIt<PokedexUseCase>());
  late PokedexModel pokedex;

  @override
  void initState() {
    getPokedex();
    super.initState();
  }

  void getPokedex({bool isLoading = true}) {
    _bloc.add(GetPokedexEvent(isLoading: isLoading));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<PokedexBloc, PokedexState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is PokedexSuccessState) {
              pokedex = state.pokedex;
            }
          },
          builder: (context, state) {
            return switch (state) {
              PokedexLoadingState() => LoadingPage(),
              PokedexErrorState() => ErrorPage(),
              PokedexState() => buildSuccessPage(theme),
            };
          },
        ),
      ),
    );
  }

  StatelessWidget buildSuccessPage(ThemeData theme) => pokedex.pokemon.isEmpty
      ? EmptyPage()
      : buildEntriesList(pokedex.pokemon, theme);

  ListView buildEntriesList(
      List<PokemonModel> pokemonEntries, ThemeData theme) {
    return ListView.builder(
      itemCount: pokemonEntries.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: buildPokemonEntry(pokemonEntries, index, theme),
        );
      },
    );
  }

  Row buildPokemonEntry(
      List<PokemonModel> pokemonEntries, int index, ThemeData theme) {
    var pokemon = pokemonEntries[index];
    return Row(children: [
      Text(pokemon.pokedexEntryNumbers[pokedex.id])
      Text(pokemon.name,
          style: theme.textTheme.displaySmall!.copyWith()),
    ]);
  }
}
