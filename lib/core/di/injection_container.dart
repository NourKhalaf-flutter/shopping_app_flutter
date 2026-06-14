 import 'package:first/core/helper/cart_db_helpers.dart';
import 'package:first/features/details/product_details_provider.dart';
import 'package:first/features/details/related_products_provider.dart';
 import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:first/features/cart/cart_provider.dart';
import 'package:first/features/login/auth_provider.dart';
import 'package:first/features/login/auth_remote_data_source.dart';
import 'package:first/features/login/auth_repository.dart';
import 'package:first/features/products/product_repository.dart';
import 'package:first/features/products/products_provider.dart';
import 'package:first/features/products/products_remote_data_source.dart';
import 'package:first/core/network/api_client.dart';
import 'package:first/core/network/app_interceptors.dart';
import 'package:first/core/services/app_preferences.dart';

  
final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());

  // Helpers
  // Services
  sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

  // Network
  sl.registerLazySingleton<ApiClient>(() => ApiClient(client: sl()));
  sl.registerLazySingleton<AppInterceptors>(
    () => AppInterceptors(appPreferences: sl()),
  );

  //! Features

  // ===== Auth =====
  sl.registerFactory(
    () => AuthProvider(authRepository: sl(), appPreferences: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), appPreferences: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: sl()),
  );

  // ===== Products =====

  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImp(apiClient: sl()),
  );
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => ProductsProvider(repository: sl()));

  // ===== Products =====

  sl.registerFactory(() => RelatedProductsProvider(repository: sl()));

  sl.registerFactory(() => ProductDetailsProvider(repository: sl()));

   sl.registerLazySingleton(() => CartDbHelper());
  sl.registerLazySingleton(() => CartProvider(dbHelper: sl() ));

   }
