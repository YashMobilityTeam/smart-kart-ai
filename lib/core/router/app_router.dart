import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/products/presentation/pages/product_details_page.dart';
import '../../features/products/presentation/pages/products_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductsPage(),
      ),
      GoRoute(
        path: '/products/:productId',
        name: 'productDetails',
        builder: (context, state) {
          final productIdStr = state.pathParameters['productId']!;
          final productId = int.parse(productIdStr);
          return ProductDetailsPage(productId: productId);
        },
      ),
    ],
  );
});
