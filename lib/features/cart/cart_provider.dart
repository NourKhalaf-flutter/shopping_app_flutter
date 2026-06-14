import 'package:first/features/cart/cart_model.dart';
import 'package:first/core/helper/cart_db_helpers.dart';
import 'package:first/features/products/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _items = {};
  final CartDbHelper dbHelper;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CartProvider({required this.dbHelper}) {
    _loadFromDb();
  }

  // Load items from DB on initialization
  Future<void> _loadFromDb() async {
    _setLoading(true);
    final dbItems = await dbHelper.getItems();
    _items.clear();
    for (var item in dbItems) {
      _items[item.id] = item;
    }
    _setLoading(false);
    notifyListeners();
  }

  Map<String, CartModel> get items => {..._items};

  int get itemCount => _items.length;
  CartModel? getItemById(String productId) {
    return _items[productId];
  }

  double get totalPrice {
    return _items.values.fold(0.0, (sum, item) {
      final price = double.tryParse(item.price) ?? 0;
      return sum + price * item.quantity;
    });
  }

  Future<void> addItem(ProductModel product, {int quantity = 1}) async {
    if (_items.containsKey(product.productId)) {
      final existing = _items[product.productId]!;
      final updated = existing.copyWith(quantity: existing.quantity + quantity);
      _items[product.productId!] = updated;
      await dbHelper.updateItem(updated);
    } else {
      if (product.productId == null) return;

      final newItem = CartModel(
        id: product.productId!,
        name: product.name ?? '',
        quantity: quantity,
        price: product.price ?? '',
        image: product.thumbnailUrl ?? '',
        description: product.description ?? '',
      );

      _items.putIfAbsent(product.productId!, () => newItem);

      await dbHelper.insertItem(newItem);
    }
    notifyListeners();
  }

  Future<void> removeItem(String productId) async {
    _items.remove(productId);
    await dbHelper.deleteItem(productId);
    notifyListeners();
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (!_items.containsKey(productId)) return;
    final existing = _items[productId]!;
    final updated = existing.copyWith(quantity: newQuantity);

    _items[productId] = updated;
    await dbHelper.updateItem(updated);

    notifyListeners();
  }

  Future<void> clear() async {
    _items.clear();
    await dbHelper.clear();
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;

    notifyListeners();
  }
}
