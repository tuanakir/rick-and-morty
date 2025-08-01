import 'package:vexana/vexana.dart';
import 'package:rick_and_morty_prj/core/models/character_model.dart';
import 'package:rick_and_morty_prj/core/services/network_manager.dart';

class CharacterService {
  final INetworkManager _networkManager = NetworkService().manager;

  Future<List<Character>?> fetchCharacters({
    int page = 1,
    String? name,
    String? status,
    String? gender,
    String? species,
  }) async {
    final queryParams = {
      'page': page.toString(),
      if (name != null && name.isNotEmpty) 'name': name,
      if (status != null && status.isNotEmpty) 'status': status,
      if (gender != null && gender.isNotEmpty) 'gender': gender,
      if (species != null && species.isNotEmpty) 'species': species,
    };

    final uri = Uri(queryParameters: queryParams).query;

    final response = await _networkManager
        .send<CharactersResponse, CharactersResponse>(
          'character/?$uri',
          parseModel: CharactersResponse(),
          method: RequestType.GET,
        );

    return response.data?.results;
  }
}
