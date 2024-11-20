import 'package:domain/usecases/pokedex_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/common/widgets/pokemon_types.dart';
import 'package:presentation/common/widgets/scroll_up_header_list_view.dart';
import 'package:presentation/pokedex/bloc/pokedex_bloc.dart';
import 'package:presentation/pokedex/converters/pokedex_local_converter.dart';
import '../../common/pages/empty_page.dart';
import '../../common/pages/error_page.dart';
import '../../common/pages/loading_page.dart';
import '../../injections.dart';
import '../models/pokedex_presentation_model.dart';
import '../models/pokedex_pokemon_presentation_model.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  final PokedexBloc _bloc =
      PokedexBloc(getIt<PokedexUseCase>(), getIt<PokedexPresentationConverter>());
  late PokedexPresentationModel pokedex;

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
      backgroundColor: theme.colorScheme.primary,
      body: SafeArea(
        child: BlocConsumer<PokedexBloc, PokedexState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is PokedexSuccessState) {
              pokedex = state.pokedex;
            }
          },
          builder: (context, state) => switch (state) {
            PokedexLoadingState() => LoadingPage(),
            PokedexErrorState() => ErrorPage(),
            PokedexState() => buildSuccessPage(theme),
          },
        ),
      ),
    );
  }

  Widget buildSuccessPage(ThemeData theme) => pokedex.pokemon.isEmpty
      ? EmptyPage()
      : ScrollUpHeaderListView(
          headerBuilder: (headerKey) => buildPokedexHeader(theme, headerKey),
          itemCount: pokedex.pokemon.length,
          itemBuilder: (context, index) =>
              buildPokemonEntry(pokedex.pokemon[index], theme),
          background: theme.colorScheme.surface,
        );

  Widget buildPokemonEntry(PokedexPokemonPresentationModel pokemon, ThemeData theme) =>
      Padding(
        padding: EdgeInsets.all(8),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage('assets/pokeball_background.png'),
                opacity: const AlwaysStoppedAnimation(.4),
                height: 100,
                width: 100,
              ),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        pokemon.pokedexEntryNumber,
                        style: theme.textTheme.labelMedium!.copyWith(),
                      ),
                      SizedBox(width: 10),
                      Text(
                        pokemon.name,
                        style: theme.textTheme.labelMedium!.copyWith(),
                      ),
                    ],
                  ),
                  buildPokemonTypes()
                ],
              )
            ],
          ),
        ),
      );

  Widget buildPokedexHeader(ThemeData theme, GlobalKey key) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/pokedex_header_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Text(
            pokedex.name,
            key: key,
            style: theme.textTheme.titleMedium!.copyWith(),
            textAlign: TextAlign.center,
          ),
      );
}
