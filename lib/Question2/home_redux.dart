import 'package:CounterApp/Question2/counter_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


class ReduxCounterScreen extends StatelessWidget {
  const ReduxCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: store,
      
      child: Scaffold(
     
      appBar: AppBar(
        title: const Text('Redux Pattern'),
      ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StoreConnector<int, int>(
              converter: (store) => store.state,
              builder: (context, count) {
                return Text(
                  '$count', // Display the count as a string
                  style: TextStyle(fontSize: 48.0),
                );
              },
            ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StoreConnector<int, VoidCallback>(
                    converter: (store) {
                      return () => store.dispatch(ActionType.increment);
                    },
                    builder: (context, callback) {
                      return ElevatedButton(
                        onPressed: callback,
                        child: Text('+'),
                      );
                    },
                  ),
                  StoreConnector<int, VoidCallback>(
                    converter: (store) {
                      return () => store.dispatch(ActionType.decrement);
                    },
                    builder: (context, callback) {
                      return ElevatedButton(
                        onPressed: callback,
                        child: Text('-'),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
