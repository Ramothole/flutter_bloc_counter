import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterState extends Equatable {
  final int count;

  const CounterState({required this.count});

  @override
  List<Object?> get props => [count];
}

class CounterBloc extends Cubit<CounterState> {
  CounterBloc() : super(const CounterState(count: 0));

  void increment() => emit(CounterState(count: state.count + 1));

  void decrement() => emit(CounterState(count: state.count - 1));
}