import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/home/data/data_source/remote/product_remote_data_source.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/product_entity.dart';
import 'package:liquor_ordering_system/features/home/domain/repository/i_product_repository.dart';

final productRemoteRepository = Provider<IProductRepository>((ref) {
  final productRemoteDataSource = ref.watch(productRemoteDataSourceProvider);
  return ProductRemoteRepository(
      productRemoteDataSource: productRemoteDataSource);
});

class ProductRemoteRepository implements IProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRemoteRepository({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> pagination(int page, int limit) {
    return productRemoteDataSource.pagination(page: page, limit: limit);
  }
}
