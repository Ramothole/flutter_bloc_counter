import 'package:CounterApp/Question1/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Pattern'),
      ),
      body: BlocProvider(
        create: (_) => CounterBloc(),
        child: const BlocCounterWidget(),
      ),
    );
  }
}

class BlocCounterWidget extends StatelessWidget {
  const BlocCounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<CounterBloc, int>(
            builder: (context, count) {
              return Text(
                '$count',
                style:const TextStyle(fontSize: 48.0),
              );
            },
          ),
         const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context).increment();
                },
                child: const Text('+'),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context).decrement();
                },
                child:const  Text('-'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
