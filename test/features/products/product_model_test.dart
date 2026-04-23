import 'package:flutter_test/flutter_test.dart';
import 'package:smart_kart_ai/features/products/data/models/product_model.dart';

void main() {
  test('ProductModel.fromJson parses category and price', () {
    final model = ProductModel.fromJson(const {
      'id': 1,
      'title': 'Laptop',
      'price': 1299.99,
      'description': 'Thin and light',
      'images': ['https://example.com/image.png'],
      'category': {'name': 'Electronics'},
    });

    expect(model.id, 1);
    expect(model.title, 'Laptop');
    expect(model.price, 1299.99);
    expect(model.categoryName, 'Electronics');
    expect(model.images, isNotEmpty);
  });
}


