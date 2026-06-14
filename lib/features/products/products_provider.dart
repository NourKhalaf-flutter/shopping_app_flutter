import 'dart:developer';

import 'package:first/features/products/product_model.dart';
import 'package:first/features/products/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:first/core/error/failures.dart';

class ProductsProvider extends ChangeNotifier {
  final ProductsRepository repository;

  ProductsProvider({required this.repository});

  // ===== State =====
  final List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  //==== Best Sellers ====
  final List<ProductModel> _bestProducts = [];
  List<ProductModel> get bestProducts => _bestProducts;

  bool isLoading = false;
  bool isLoadingMore = false;
  String? errorMessage;

  int _currentPage = 1;
  bool _hasMore = true;

  Future<void> getProducts() async {
    try {
        _resetState();
      _setLoading(true, true);
      final page = await repository.products(page: 13);
      _bestProducts.addAll(page.products );
    } on Failure catch (e) {
      log('provider error1');
      errorMessage = e.message;
    } catch (_) {
      log('provider error');

      errorMessage = 'Something went wrong';
    } finally {
      _setLoading(true, false);
     }
  }

  // ===== Public API =====

  Future<void> loadInitialProducts() async {
    _resetState();
    await _fetchProducts(isInitial: true);
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore || !_hasMore) return;
    await _fetchProducts(isInitial: false);
  }

  // ===== Core Logic =====

  Future<void> _fetchProducts({required bool isInitial}) async {
    try {
      _setLoading(isInitial, true);
      final page = await repository.products(page: _currentPage);
      _products.addAll(page.products);

      
      _hasMore = page.hasMore;
      _currentPage++;

      errorMessage = null;
    } on Failure catch (e) {
      log('provider error1');
      errorMessage = e.message;
    } catch (_) {
      log('provider error');

      errorMessage = 'Something went wrong';
    } finally {
      _setLoading(isInitial, false);
      notifyListeners();
    }
  }

  // ===== Helpers =====

  void _resetState() {
    _products.clear();
    _currentPage = 1;
    _hasMore = true;
    errorMessage = null;
  }

  void _setLoading(bool isInitial, bool value) {
    if (isInitial) {
      isLoading = value;
    } else {
      isLoadingMore = value;
    }
    notifyListeners();
  }
}
