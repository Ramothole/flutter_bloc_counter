import 'package:CounterApp/Question1/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyCounterApp());
}

class MyCounterApp extends StatelessWidget {
  const MyCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: const CounterScreen(),
      ),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LittleFish BLoC Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  '${state.count}',
                  style: TextStyle(fontSize: 48.0),
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
                  child: const Text('+ ADDITION'),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CounterBloc>(context).decrement();
                  },
                  child: const Text('- SUBTRACT'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
