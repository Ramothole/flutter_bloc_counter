import 'package:CounterApp/Question3/bloc/bloc.dart';
import 'package:CounterApp/Question3/repository/rick_and_morty_repo.dart';
import 'package:CounterApp/Question3/views/character_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'card.dart';

class MyRickyMortyWidget extends StatefulWidget {
  const MyRickyMortyWidget({super.key});

  @override
  State<MyRickyMortyWidget> createState() => _MyRickyMortyWidgetState();
}

class _MyRickyMortyWidgetState extends State<MyRickyMortyWidget> {
  RickAndMortyBloc? bloc;
  @override
  void initState() {
    super.initState();
    bloc = RickAndMortyBloc(RickAndMortyState.initial);
    bloc?.add(RickAndMortyInitializeEvent());
  }

  @override
  void dispose() {
    bloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text("The Rick and Morty"),
          centerTitle: false,
        ),
        body: RepositoryProvider(
          create: (context) => RickMortysRepository(),
          child: BlocBuilder<RickAndMortyBloc, RickAndMortyState>(
            bloc: bloc,
            builder: (context, currentState) {
              if (currentState == RickAndMortyState.loading) {
                return _loading();
              }

              if (currentState == RickAndMortyState.initial) {
                return _initial();
              }

              if (currentState == RickAndMortyState.error) {
                return Container();
              }
              return Container();
            },
          ),
        ));
  }

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _initial() {
    if (bloc == null || bloc?.characters == null) {
      return _loading();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: bloc?.characters!.length,
        itemBuilder: (context, index) {
          return CharacterCard(
            name: bloc!.characters![index].name,
            status: bloc!.characters![index].status.name,
            firstSeen: bloc!.characters![index].origin.name,
            location: bloc!.characters![index].location.name,
            species: bloc!.characters![index].species.name,
            image: bloc?.characters![index].image ?? 'assets/rick_mortypng.png',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CharacterDetailsModal(
                        name: bloc!.characters![index].name,
                        status: bloc!.characters![index].status.name,
                        species: bloc!.characters![index].species.name,
                      ));
            },
          );
        },
      ),
    );
  }
}
