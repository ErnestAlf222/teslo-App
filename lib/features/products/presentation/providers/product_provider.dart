import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'products_repository_provider.dart';

// autoDispose => limpia cada vez que no se va a utilizar

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNofier, ProductState, String>((ref, productId) {

  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductNofier(
    productsRepository: productsRepository,
    productId: productId,
  );
});

class ProductNofier extends StateNotifier<ProductState> {
  final ProductsRepository productsRepository;

  ProductNofier({
    required this.productsRepository,
    required String productId,
  }) : super(ProductState(id: productId)){
    loadProduct();
  }

  Future<void> loadProduct() async {
    try {
      final product = await productsRepository.getProductById(state.id);
      state = state.copyWith(
        isLoading: false,
        product: product
      );
      
    } catch (e) {
      print(e);
    }
  }
}

class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
