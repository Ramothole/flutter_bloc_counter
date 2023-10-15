import 'package:CounterApp/Question3/bloc/bloc.dart';
import 'package:CounterApp/Question3/repository/rick_and_morty_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodesWidget extends StatefulWidget {
  final List<String> episode;
  final String name;
  final String image;
  const EpisodesWidget(
      {required this.episode,
      required this.image,
      required this.name,
      super.key});

  @override
  State<EpisodesWidget> createState() => _EpisodesWidgetState();
}

class _EpisodesWidgetState extends State<EpisodesWidget> {
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
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text("${widget.name}'s Episodes"),
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
                    if (currentState == RickAndMortyState.episode) {
                      return _episodeDetails();
                    }
                    if (currentState == RickAndMortyState.error) {
                      return Container();
                    }
                    return Container();
                  },
                ))));
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
          itemCount: widget.episode.length,
          itemBuilder: (context, index) {
            return Card(
              color: const Color(0xFF160444),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              shadowColor: Colors.red,
              child: GestureDetector(
                onTap: () {
                  var item = widget.episode[index].split('episode/');
                  bloc!.add(EpisodesDetails(int.parse(item[1])));
                },
                child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  title: Text(
                    'Episode ${index + 1}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _episodeDetails() {
    return WillPopScope(
      onWillPop: () async => true,
      child: SimpleDialog(
        contentPadding: const EdgeInsets.all(16),
        children: <Widget>[
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "This is ${widget.name}'s episode named  ${bloc!.episodes!.name}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "It was first aired on ${bloc!.episodes!.airDate} and its played by ${bloc!.episodes!.characters.length} characters",
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Container(
                  height: 8,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
