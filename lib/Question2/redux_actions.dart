import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redux/redux.dart';

class IncrementAction {}

class DecrementAction {}

class CounterBloc extends Cubit<int> {
  final Store<int> reduxStore;

  CounterBloc(this.reduxStore) : super(0);

  void increment() {
    reduxStore.dispatch(IncrementAction());
  }

  void decrement() {
    reduxStore.dispatch(DecrementAction());
  }
}