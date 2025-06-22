import 'package:vexana/vexana.dart';

class LocationsResponse extends INetworkModel<LocationsResponse> {
  final List<Location>? results;

  LocationsResponse({this.results});

  @override
  LocationsResponse fromJson(Map<String, dynamic> json) {
    return LocationsResponse(
      results:
          (json['results'] as List?)?.map((e) => Location.fromJson(e)).toList(),
    );
  }

  @override
  Map<String, dynamic>? toJson() => {
    'results': results?.map((e) => e.toJson()).toList(),
  };
}

class Location {
  final int? id;
  final String? name;
  final String? type;
  final String? dimension;

  Location({this.id, this.name, this.type, this.dimension});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json['id'],
    name: json['name'],
    type: json['type'],
    dimension: json['dimension'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'dimension': dimension,
  };
}
