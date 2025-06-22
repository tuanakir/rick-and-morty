import 'package:vexana/vexana.dart';

class EpisodesResponse extends INetworkModel<EpisodesResponse> {
  final List<Episode>? results;

  EpisodesResponse({this.results});

  @override
  EpisodesResponse fromJson(Map<String, dynamic> json) {
    return EpisodesResponse(
      results:
          (json['results'] as List?)?.map((e) => Episode.fromJson(e)).toList(),
    );
  }

  @override
  Map<String, dynamic>? toJson() => {
    'results': results?.map((e) => e.toJson()).toList(),
  };
}

class Episode {
  final int? id;
  final String? name;
  final String? airDate;
  final String? episode;

  Episode({this.id, this.name, this.airDate, this.episode});

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
    id: json['id'],
    name: json['name'],
    airDate: json['air_date'],
    episode: json['episode'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'air_date': airDate,
    'episode': episode,
  };
}
