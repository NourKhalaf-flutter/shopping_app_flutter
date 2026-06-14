import 'dart:developer';
 import 'package:first/features/products/product_model.dart';
import 'package:first/features/products/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:first/core/error/failures.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final ProductsRepository repository;

  ProductDetailsProvider({required this.repository});

  ProductModel? _product;
  ProductModel? get product => _product;

  bool isLoading = false;

  String? errorMessage;

  void setInitialProduct(ProductModel product){
    _product= product;
    notifyListeners();
  }

  Future<void> loadProductDetails(int productId) async {
    try {
      _setLoading(true);
      final productDetails = await repository.productDetails(
        productId: productId,
      );
      _product = productDetails;

      errorMessage = null;
    } on Failure catch (e,s) {
      log('detail provider error1');
      log('DetailsProductsProvider error: $e');
  log('StackTrace: $s');
      errorMessage = e.message;
    } catch (e, s) {
  log('DetailsProductsProvider error: $e');
  log('StackTrace: $s');
 
      errorMessage = 'Something went wrong';
    } finally {
      _setLoading(false);
     }
  }

  void _setLoading(bool value) {
    isLoading = value;

    notifyListeners();
  }
}
