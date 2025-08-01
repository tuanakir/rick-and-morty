import 'package:vexana/vexana.dart';
import 'package:rick_and_morty_prj/core/models/episode_model.dart';
import 'package:rick_and_morty_prj/core/services/network_manager.dart';

class EpisodeService {
  final INetworkManager _networkManager = NetworkService().manager;

  Future<List<Episode>?> fetchEpisodes({
    int page = 1,
    String? name,
    String? episode,
  }) async {
    final queryParams = {
      'page': page.toString(),
      if (name != null && name.isNotEmpty) 'name': name,
      if (episode != null && episode.isNotEmpty) 'episode': episode,
    };

    final uri = Uri(queryParameters: queryParams).query;

    final response = await _networkManager
        .send<EpisodesResponse, EpisodesResponse>(
          'Episode/?$uri',
          parseModel: EpisodesResponse(),
          method: RequestType.GET,
        );

    return response.data?.results;
  }
}
