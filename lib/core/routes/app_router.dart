 import 'package:first/landing_screen.dart';
import 'package:first/features/arrivals/arrivals.dart';
import 'package:first/features/details/description_screen.dart';
import 'package:first/features/details/details_screen.dart';
import 'package:first/features/home/home_screen.dart';
import 'package:first/features/auth/forgot_password_screen.dart';
import 'package:first/features/auth/login_screen.dart';
import 'package:first/main_screen.dart';
import 'package:first/core/routes/route_names.dart';
import 'package:first/features/products/product_model.dart';
import 'package:first/features/welcome/onboarding_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //landing
      case RouteNames.landingScren:
        return _buildRoute(LandingScreen(), settings);

      //onboarding
      case RouteNames.onboardingScreen:
        return _buildRoute(OnboardingScreen(), settings);

      //home

      case RouteNames.mainScreen:
        final index = settings.arguments as int?;

        return _buildRoute(MainScreen(selectedeIndex: index), settings);

      case RouteNames.homeScreen:
        return _buildRoute(HomeScreen(), settings);

      //login
      case RouteNames.loginScreen:
        return _buildRoute(LoginScreen(), settings);

      case RouteNames.forgotPasswordScreen:
        return _buildRoute(ForgotPassword(), settings);

      //products
      case RouteNames.detailsScreen:
        final args = settings.arguments as ProductModel;

        return _buildRoute(DetailsScreen(args), settings);

      case RouteNames.arrivalsScreen:
        return _buildRoute(ArrivalsScreen(), settings);

      case RouteNames.descriptionScreen:
        final args = settings.arguments as List;
        final name = args[0];
        final description = args[1];
        return _buildRoute(DescriptionScreen(name, description), settings);

      default:
        return _buildRoute(const _UnknownRouteScreen(), settings);
    }
  }

  // Helper method لبناء الـ Route  

  static MaterialPageRoute<T> _buildRoute<T>(
    Widget page,
    RouteSettings settings,
  ) {
    return MaterialPageRoute<T>(builder: (_) => page, settings: settings);
  }

 
}

// صفحة للـ routes غير الموجودة
class _UnknownRouteScreen extends StatelessWidget {
  const _UnknownRouteScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خطأ')),
      body: const Center(
        child: Text('الصفحة غير موجودة', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
