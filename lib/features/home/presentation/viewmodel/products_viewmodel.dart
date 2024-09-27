import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/home/domain/usecases/product_usecase.dart';
import 'package:liquor_ordering_system/features/home/presentation/state/product_state.dart';

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>(
        (ref) => ProductViewModel(
              productUsecase: ref.watch(productUsecaseProvider),
            ));

class ProductViewModel extends StateNotifier<ProductState> {
  ProductViewModel({required this.productUsecase})
      : super(ProductState.initial()) {
    getProducts();
  }

  final ProductUseCase productUsecase;

  Future resetState() async {
    state = ProductState.initial();
    getProducts();
  }

  Future getProducts() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final products = currentState.products;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await productUsecase.pagination(page, 4);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              products: [...products, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
    if (hasReachedMax) {
      state = state.copyWith(isLoading: false);
    }
  }
}
