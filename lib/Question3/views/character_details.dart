import 'package:flutter/material.dart';

class CharacterDetailsModal extends StatelessWidget {
  final String name;
  final String status;
  final String species;

  const CharacterDetailsModal({
    required this.name,
    required this.status,
    required this.species,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: $name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Status: $status', style: TextStyle(fontSize: 16)),
            Text('Species: $species', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
