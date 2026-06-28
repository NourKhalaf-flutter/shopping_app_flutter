import 'package:first/core/error/failures.dart';
import 'package:first/core/network/response_wrapper.dart';
import 'package:first/core/services/app_preferences.dart';
import 'package:first/features/auth/auth_remote_data_source.dart';

abstract class AuthRepository {
  Future<ResponseWrapper<dynamic>> login(String email, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.appPreferences,
  });

  @override
  Future<ResponseWrapper<dynamic>> login(String email, String password) async {
    final response = await remoteDataSource.login(
      email: email,
      password: password,
    );
    //   فشل
    if (response.statusModel.error == 1) {
      if (response.statusModel.errorMessages.isNotEmpty) {
        throw UserFailure(response.statusModel.errorMessages.first);
      }
      throw UserFailure(response.statusModel.message);
    }

    //   نجاح
     
    final user = response.data[0];
      await appPreferences.setToken(user['customer_token']);
      await appPreferences.setAuthenticated(true);
      await appPreferences.setUserName(user['name']);
      await appPreferences.setUserEmail(user['email']);
   

    return response;
  }
}
