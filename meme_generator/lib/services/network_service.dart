import 'package:dio/dio.dart';
import 'package:meme_generator/services/interfaces/i_network_service.dart';

class NetworkService implements INetworkService{
  final Dio _dio;
  static final NetworkService _instance = NetworkService._();

  NetworkService._() : _dio = Dio();

  factory NetworkService(){
    return _instance;
  }

  @override
  Future<bool> isImageUrl(String url) async {
    try {
      final response = await _dio.head(url);
      return response.headers.value('content-type')?.startsWith('image/') ?? false;
    } catch (e) {
      return false;
    }
  }

}