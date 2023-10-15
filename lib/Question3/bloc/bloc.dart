import 'dart:io';

import 'package:CounterApp/Question3/model/Rick_and_morty_model.dart';
import 'package:CounterApp/Question3/model/episodes_model.dart';
import 'package:CounterApp/Question3/repository/rick_and_morty_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RickAndMortyBloc extends Bloc<RickAndMortyEvent, RickAndMortyState> {
  //Fields
  /// The error code when [currentState] is an instance of [RickAndMortyState.error].
  int? errorCode;

  /// The error message when [currentState] is an instance of [RickAndMortyState.error].
  String? errorMessage;

  /// The reason code when [currentState] is an instance of [RickAndMortyState.error].
  String? reasonMessage;

  List<Result>? characters;
  Result? singleCharacter;
  Episodes? episodes;

  RickAndMortyBloc(RickAndMortyState initialState) : super(initialState);

  //Methods
  @override
  Stream<RickAndMortyState> mapEventToState(
    RickAndMortyEvent event,
  ) async* {
    yield RickAndMortyState.loading;
    yield await event.applyAsync(this);
  }

  //Getters and Setters
  RickAndMortyState get initialState => RickAndMortyState.loading;
}

/// Models the different states of the [RickAndMortyBloc]
enum RickAndMortyState { loading, error, initial, success, episode }

/// superclass used to model all events dispatched by [RickAndMortyBloc]
abstract class RickAndMortyEvent {
  Future<RickAndMortyState> applyAsync(RickAndMortyBloc bloc);
}

/// Gets the QR code of this stock order and the date that it expires, then assign
/// the relevant [RickAndMortyBloc] instance's field accordingly before returning
/// an instance of [RickAndMortyState.initial].
///
/// May return an instance of [RickAndMortyState.error] if
/// an exception is thrown.
class RickAndMortyInitializeEvent extends RickAndMortyEvent {
  RickAndMortyInitializeEvent();

  @override
  Future<RickAndMortyState> applyAsync(RickAndMortyBloc bloc) async {
    try {
      RickyAndMortyModel characters =
          await RickMortysRepository.fetchCharacterList();
      bloc.characters = characters.results;

      return RickAndMortyState.initial;
    } on HttpException catch (e) {
      bloc.errorMessage = e.message;
      return RickAndMortyState.error;
    }
  }
}

class EpisodesDetails extends RickAndMortyEvent {
  final int? id;
  EpisodesDetails(this.id);

  @override
  Future<RickAndMortyState> applyAsync(RickAndMortyBloc bloc) async {
    try {
      Episodes episodes = await RickMortysRepository.getEpisodes(id!);
      bloc.episodes = episodes;
      return RickAndMortyState.episode;
    } on HttpException catch (e) {
      bloc.errorMessage = e.message;
      return RickAndMortyState.error;
    }
  }
}

class CharacterDetails extends RickAndMortyEvent {
  final int? id;
  CharacterDetails(this.id);

  @override
  Future<RickAndMortyState> applyAsync(RickAndMortyBloc bloc) async {
    try {
      Result characters = await RickMortysRepository.getSingleCharacter(id!);
      bloc.singleCharacter = characters;
      return RickAndMortyState.success;
    } on HttpException catch (e) {
      bloc.errorMessage = e.message;
      return RickAndMortyState.error;
    }
  }
}
