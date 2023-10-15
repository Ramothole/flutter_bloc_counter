import 'package:CounterApp/Question3/bloc/bloc.dart';
import 'package:CounterApp/Question3/model/Rick_and_morty_model.dart';
import 'package:CounterApp/Question3/model/single_character_model.dart';
import 'package:CounterApp/Question3/repository/rick_and_morty_repo.dart';
import 'package:CounterApp/Question3/views/character_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'card.dart';

class MyRickyMortyWidget extends StatefulWidget {
  const MyRickyMortyWidget({super.key});

  @override
  State<MyRickyMortyWidget> createState() => _MyRickyMortyWidgetState();
}

class _MyRickyMortyWidgetState extends State<MyRickyMortyWidget> {
  RickAndMortyBloc? bloc;
  bool _isLoading = false;

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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("The Rick and Morty"),
            centerTitle: true,
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
                if (currentState == RickAndMortyState.success) {
                  return _singleCharacterModel();
                }
                return Container();
              },
            ),
          )),
    );
  }

  Widget _buildCharacterDialog(BuildContext context, Result character) {
    return AlertDialog(
      title: const Text('Character Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${character.name}'),
          Text('Status: ${character.status}'),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _singleCharacterModel() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return _buildCharacterDialog(context, bloc!.singleCharacter!);
          });
    });
    return Container();
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
      child: SingleChildScrollView(
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
                character: bloc!.characters![index],
                image: bloc?.characters![index].image ??
                    'assets/rick_mortypng.png',
                onPressed: () => null);
          },
        ),
      ),
    );
  }
}
