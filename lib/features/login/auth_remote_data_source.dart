import 'package:first/core/network/api_client.dart';
import 'package:first/core/network/api_endpoints.dart';
import 'package:first/core/network/response_wrapper.dart';

abstract class AuthRemoteDataSource {
  Future<ResponseWrapper<dynamic>> login({
    required String email,
    required String password,
  });


}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ResponseWrapper<dynamic>> login({
    required String email,
    required String password,
  }) async {
     return await apiClient.post(
      ApiEndpoints.login,
      body: {
        "email": email,
        "password": password,
      },
    );

    
  }
}
