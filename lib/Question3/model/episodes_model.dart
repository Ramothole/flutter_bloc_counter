import 'dart:convert';

Episodes episodesFromJson(String str) => Episodes.fromJson(json.decode(str));

String episodesToJson(Episodes data) => json.encode(data.toJson());

class Episodes {
    int id;
    String name;
    String airDate;
    String episode;
    List<String> characters;
    String url;
    DateTime created;

    Episodes({
        required this.id,
        required this.name,
        required this.airDate,
        required this.episode,
        required this.characters,
        required this.url,
        required this.created,
    });

    factory Episodes.fromJson(Map<String, dynamic> json) => Episodes(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: List<String>.from(json["characters"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters": List<dynamic>.from(characters.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
    };
}
