import 'package:CounterApp/Question1/home_bloc.dart';
import 'package:CounterApp/Question2/counter_redux.dart';
import 'package:CounterApp/Question2/home_redux.dart';
import 'package:CounterApp/Question3/views/ricky_morty_view.dart';
import 'package:CounterApp/Question4/network_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

void main() async {
  final store = Store<int>(
    counterReducer,
    initialState: 0,
  );
  WidgetsFlutterBinding.ensureInitialized();

  // Check internet connectivity and display a toast message
  await checkInternetConnectivity();
  runApp(LittleFishApp(store: store));
}

class LittleFishApp extends StatelessWidget {
  final Store<int> store;
  const LittleFishApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartupScreen(),
    );
  }
}

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.pattern),
            icon: Icon(Icons.pattern),
            label: 'Redux',
          ),
          NavigationDestination(
            icon: Icon(Icons.pattern),
            label: 'BLoC',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.image_sharp),
            icon: Icon(Icons.image_rounded),
            label: 'Characters',
          ),
        ],
      ),
      body: <Widget>[
        const Center(child: ReduxCounterScreen()),
        const Center(
          child: BlocCounterScreen(),
        ),
        const MyRickyMortyWidget()
      ][currentPageIndex],
    );
  }
}
