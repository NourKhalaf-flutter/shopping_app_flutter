import 'package:first/core/routes/route_names.dart';
 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first/features/auth/auth_provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final authProvider = context.read<AuthProvider>();
      await authProvider.checkAuthStatus();
      if (authProvider.isOnBoradingComplete) {
           //  Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainScreen,(route) => false,);

        if (authProvider.isLoggedIn) {
          Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainScreen,(route) => false,);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, RouteNames.loginScreen,(route) => false,);
        }
      } else {
        Navigator.pushNamedAndRemoveUntil(context, RouteNames.onboardingScreen,(route) => false,);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
