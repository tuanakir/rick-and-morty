import 'package:vexana/vexana.dart';

class CharactersResponse extends INetworkModel<CharactersResponse> {
  final List<Character>? results;

  CharactersResponse({this.results});

  @override
  CharactersResponse fromJson(Map<String, dynamic> json) {
    return CharactersResponse(
      results:
          (json['results'] as List?)
              ?.map((e) => Character.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic>? toJson() => {
    'results': results?.map((e) => e.toJson()).toList(),
  };
}

class Character {
  int? id;
  String? name;
  String? image;
  String? status;
  String? species;
  String? gender;

  Character({
    this.id,
    this.name,
    this.image,
    this.status,
    this.species,
    this.gender,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    status: json['status'],
    species: json['species'],
    gender: json['gender'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'status': status,
    'species': species,
    'gender': gender,
  };
}
