import 'package:first/core/error/failures.dart';
import 'package:first/core/services/app_preferences.dart';
import 'package:first/features/login/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final AppPreferences appPreferences;

  AuthProvider({required this.authRepository, required this.appPreferences});

  bool isLoading = false;
  String? errorMessage;
  bool isLoggedIn = false;
  bool isOnBoradingComplete = false;

  String? name;
  String? email;

  Future<void> loadUserData() async {
    name = appPreferences.getUserName();
    email = appPreferences.getUserEmail();
    notifyListeners();
  }

  Future<void> logout() async {
    await appPreferences.logout();
     isLoggedIn = false;
     notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    isOnBoradingComplete = appPreferences.isOnboardingCompleted();
    final token = appPreferences.getToken();
    final isAuth = appPreferences.isAuthenticated();
    isLoggedIn = token != null && token.isNotEmpty && isAuth;

    if (isLoggedIn) {
      await loadUserData();
    }

    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
  await authRepository.login(email, password);
      isLoggedIn = true;
    } on Failure catch (e) {
      errorMessage = e.message;
      isLoggedIn = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
