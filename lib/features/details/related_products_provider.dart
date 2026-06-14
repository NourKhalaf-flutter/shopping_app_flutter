import 'dart:developer';
 import 'package:first/features/products/product_model.dart';
import 'package:first/features/products/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:first/core/error/failures.dart';

class RelatedProductsProvider extends ChangeNotifier {
  final ProductsRepository repository;

  RelatedProductsProvider({required this.repository});

  final List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool isLoading = false;

  String? errorMessage;

  Future<void> loadProducts(int productId) async {
    try {
      _setLoading(true);

      final relatedProducts = await repository.relatedProducts(
        productId: productId,
      );
      _products
      ..clear()
      ..addAll(relatedProducts);

      errorMessage = null;
    } on Failure catch (e) {
      log('provider error1');
      errorMessage = e.message;
    } catch (e, s) {
  log('RelatedProductsProvider error: $e');
  log('StackTrace: $s');
  errorMessage = 'Something went wrong';
} finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    isLoading = value;

    notifyListeners();
  }
}
