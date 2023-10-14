import 'package:flutter/material.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rick and Morty Characters'),
        ),
        body: SingleChildScrollView(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: const Color.fromRGBO(30, 30, 30, 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.network(
                          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                        ),
                      ),
                      Container(
                        width: 16,
                      ),
                      Expanded(
                        flex: 2,
                        child: _buildCharacterDetails(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        )));
  }

  _buildCharacterDetails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'name',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(height: 4),
            const Text(
              'status',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
            const Text(
              'Last Known Location:',
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
            const Text(
              'First seen in:',
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // void _onCharacterSelected(BuildContext context, Character character) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => CharacterDetailModal(character: character),
  //   );
  // }
}
