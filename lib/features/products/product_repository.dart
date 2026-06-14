import 'package:first/core/error/failures.dart';
 import 'package:first/features/products/product_model.dart';

import 'package:first/features/products/product_page_model.dart';
import 'package:first/features/products/products_remote_data_source.dart';

abstract class ProductsRepository {
  Future<ProductsPageModel> products({int page = 1});
  Future<List<ProductModel>> relatedProducts({required int productId});
  Future<ProductModel> productDetails({required int productId});
}

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProductsPageModel> products({int page = 1}) async {
    final response = await remoteDataSource.products(page: page);
    // ❌ فشل
    if (response.statusModel.error == 1) {
      if (response.statusModel.errorMessages.isNotEmpty) {
        throw UserFailure(response.statusModel.errorMessages.first);
      }
      throw ServerFailure(response.statusModel.message);
    }
    // ✅ نجاح

    final pageJson = (response.data as List).first;
    try {
      return ProductsPageModel.fromJson(pageJson);
    } on Exception catch (e) {
      throw Failure('Failed to parse products: $e');
    }
  }

  @override
  Future<List<ProductModel>> relatedProducts({required int productId}) async {
    final response = await remoteDataSource.relatedProducts(
      productId: productId,
    );
    // ❌ فشل
    if (response.statusModel.error == 1) {
      if (response.statusModel.errorMessages.isNotEmpty) {
        throw UserFailure(response.statusModel.errorMessages.first);
      }
      throw ServerFailure(response.statusModel.message);
    }
    // ✅ نجاح

    final relatedProducts = (response.data as List);
    try {
      return relatedProducts.map((e) => ProductModel.fromJson(e)).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }


  @override
  Future<ProductModel> productDetails({required int productId}) async {
    final response = await remoteDataSource.productDetails(productId: productId);
    // ❌ فشل
    if (response.statusModel.error == 1) {
      if (response.statusModel.errorMessages.isNotEmpty) {
        throw UserFailure(response.statusModel.errorMessages.first);
      }
      throw ServerFailure(response.statusModel.message);
    }
    // ✅ نجاح
    final detailsJson = (response.data as List).first;
    try {
      return ProductModel.fromJson(detailsJson);
    } on Exception catch (e) {
      throw Failure('Failed to parse products: $e');
    }
  }

}
