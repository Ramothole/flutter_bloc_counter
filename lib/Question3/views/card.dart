import 'package:CounterApp/Question3/model/Rick_and_morty_model.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final String name;
  final String image;
  final String status;
  final String location;
  final String firstSeen;
  final String species;
  final Result character;
  final Function() onPressed;

  const CharacterCard({
    super.key,
    required this.name,
    required this.firstSeen,
    required this.location,
    required this.species,
    required this.character,
    required this.status,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF160440),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return _buildCharacterDialogs(context, character);
              });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
              scale: 2,
            ),
            Container(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: status == 'ALIVE' ? Colors.green : Colors.grey,
                      size: 8,
                    ),
                    Text(
                      " $status",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Last known location:',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  location,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'First seen in:',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  firstSeen,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildCharacterDialogs(context, Result character) {
    return WillPopScope(
      onWillPop: () async => true,
      child: SimpleDialog(
        contentPadding: const EdgeInsets.all(16),
        children: <Widget>[
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  character.image,
                  fit: BoxFit.cover,
                  scale: 3,
                ),
                Container(
                  height: 8,
                ),
                Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Gender: ${character.gender.name.toLowerCase()}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  'Species: ${character.species.name.toLowerCase()}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  'Location: ${character.location.name}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Container(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Theme.of(context).primaryColor.withOpacity(0.15),
                  child: Text(
                    'This character has played  ${character.episode.length} episodes',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                    Container(
                      width: 8.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('View Episodes'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
