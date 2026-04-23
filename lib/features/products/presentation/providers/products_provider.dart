import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../data/models/product_model.dart';
import '../../domain/entities/product.dart';

const _productsCacheKey = 'cached_products';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
  (_) => SharedPreferences.getInstance(),
);

final productsProvider = AsyncNotifierProvider<ProductsNotifier, List<Product>>(
  ProductsNotifier.new,
);

class ProductsNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() => _loadProducts();

  Future<List<Product>> _loadProducts() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);

    try {
      final response = await ref.read(apiClientProvider).get(ApiConstants.products);
      final productModels = (response.data as List)
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();

      await prefs.setString(
        _productsCacheKey,
        jsonEncode(productModels.map((e) => e.toJson()).toList()),
      );

      return productModels;
    } catch (_) {
      final cached = prefs.getString(_productsCacheKey);
      if (cached == null || cached.isEmpty) {
        rethrow;
      }

      final decoded = jsonDecode(cached) as List<dynamic>;
      return decoded
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadProducts);
  }
}


