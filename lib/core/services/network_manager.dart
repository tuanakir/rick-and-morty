import 'package:vexana/vexana.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  late final INetworkManager manager;

  NetworkService._internal() {
    manager = NetworkManager<EmptyModel>(
      options: BaseOptions(baseUrl: 'https://rickandmortyapi.com/api/'),
    );
  }
}
