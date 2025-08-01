import 'package:vexana/vexana.dart';
import 'package:rick_and_morty_prj/core/models/location_model.dart';
import 'package:rick_and_morty_prj/core/services/network_manager.dart';

class LocationService {
  final INetworkManager _networkManager = NetworkService().manager;

  Future<List<Location>?> fetchLocations({
    int page = 1,
    String? name,
    String? type,
    String? dimension,
  }) async {
    final queryParams = {
      'page': page.toString(),
      if (name != null && name.isNotEmpty) 'name': name,
      if (type != null && type.isNotEmpty) 'type': type,
      if (dimension != null && dimension.isNotEmpty) 'dimension': dimension,
    };

    final uri = Uri(queryParameters: queryParams).query;

    final response = await _networkManager
        .send<LocationsResponse, LocationsResponse>(
          'Location/?$uri',
          parseModel: LocationsResponse(),
          method: RequestType.GET,
        );

    return response.data?.results;
  }
}
