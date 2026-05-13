import 'package:dio/dio.dart';
import 'user_session.dart';

class AuthService {

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',

      connectTimeout: Duration(seconds: 10),

      receiveTimeout: Duration(seconds: 10),

      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );


  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
          'expiresInMins': 30, 
        },
      );

      if (response.statusCode == 200) {
        UserSession().simpanDariApi(response.data);
        return 'sukses';
      }

      return 'Login gagal. Coba lagi.';

    } on DioException catch (e) {

      if (e.response?.statusCode == 401) {
        return 'Username atau password salah.';
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return 'Koneksi timeout. Periksa internet kamu.';
      }

      if (e.type == DioExceptionType.connectionError) {
        return 'Tidak ada koneksi internet.';
      }

      return 'Terjadi kesalahan: ${e.message}';

    } catch (e) {
      return 'Error tidak dikenal: $e';
    }
  }


  void logout() {
    UserSession().hapusSession();
  }
}