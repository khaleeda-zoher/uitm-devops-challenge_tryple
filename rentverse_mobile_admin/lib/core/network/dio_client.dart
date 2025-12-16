import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio(String token) {
    return Dio(
      BaseOptions(
        baseUrl: 'http://192.168.0.118:3000/api', // Android emulator
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}
