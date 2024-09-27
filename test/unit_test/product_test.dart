import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/product_entity.dart';
import 'package:liquor_ordering_system/features/home/domain/usecases/product_usecase.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/products_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_test.mocks.dart';
import 'test_data/product_test_data.dart';

@GenerateNiceMocks([
  MockSpec<ProductUseCase>(),
])
void main() {
  late MockProductUseCase mockProductUseCase;
  late ProviderContainer container;
  late List<ProductEntity> lstProducts;

  setUp(() {
    mockProductUseCase = MockProductUseCase();
    lstProducts = ProductTestData.getProductsTestData();
    container = ProviderContainer(
      overrides: [
        productViewModelProvider.overrideWith(
            (ref) => ProductViewModel(productUsecase: mockProductUseCase)),
      ],
    );
  });

  test('ProductUseCase should return product list on success', () async {
    when(mockProductUseCase.pagination(any, any))
        .thenAnswer((_) async => Right(lstProducts));

    await container.read(productViewModelProvider.notifier).getProducts();

    final productState = container.read(productViewModelProvider);

    expect(productState.isLoading, false);
  });
  tearDown(
    () {
      container.dispose();
    },
  );
}
