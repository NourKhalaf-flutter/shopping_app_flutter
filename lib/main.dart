import 'package:first/features/cart/cart_provider.dart';
import 'package:first/core/di/injection_container.dart';
import 'package:first/core/notifications/notification_service.dart';
import 'package:first/core/routes/app_router.dart';
import 'package:first/core/routes/route_names.dart';
import 'package:first/core/constants/app_colors.dart';
import 'package:first/features/details/product_details_provider.dart';
import 'package:first/features/details/related_products_provider.dart';
import 'package:first/features/auth/auth_provider.dart';
import 'package:first/features/products/products_provider.dart';
import 'package:flutter/material.dart';
 import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init(); // GetIt initialization

  //Notification
  await NotificationService().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ProductsProvider>()),
        ChangeNotifierProvider(create: (_) => sl<RelatedProductsProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ProductDetailsProvider>()),
        ChangeNotifierProvider(create: (_) => sl<CartProvider>()),
      ],
      child: MyApp(appRouter: AppRouter()),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: GoogleFonts.dmSans(
            fontSize: 16,
            color: AppColors.mainColor,
            height: 1.7,
          ),
        ),

        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),

        colorScheme: .fromSeed(seedColor: Color(0xFF142535)),
      ),
      initialRoute: RouteNames.landingScren,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
