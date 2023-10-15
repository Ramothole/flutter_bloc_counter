import 'package:CounterApp/Question1/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

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
          centerTitle: true,
          title: const Text('BLoC Pattern'),
        ),
        body: BlocProvider(
          create: (_) => CounterBloc(),
          child: const BlocCounterWidget(),
        ),
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
                style: const TextStyle(fontSize: 48.0, color: Colors.white),
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
                child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/rick.png"),
                          fit: BoxFit.cover),
                    ),
                    child: const Text('ADD')),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<CounterBloc>(context).decrement();
                },
                child: const Text('MINUS'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
